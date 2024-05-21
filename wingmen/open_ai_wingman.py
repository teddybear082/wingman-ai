import json
from exceptions import MissingApiKeyException
from services.open_ai import OpenAi
from services.printr import Printr
from wingmen.wingman import Wingman
from PIL import Image
import base64
import requests


class OpenAiWingman(Wingman):
    def __init__(self, name: str, config: dict[str, any]):
        super().__init__(name, config)

        if not self.config.get("openai").get("api_key"):
            raise MissingApiKeyException

        api_key = self.config["openai"]["api_key"]
        if api_key == "YOUR_API_KEY":
            raise MissingApiKeyException

        self.openai = OpenAi(api_key)
        self.messages = [
            {
                "role": "system",
                "content": self.config["openai"].get("context"),
            },
        ]

    def _transcribe(self, audio_input_wav: str) -> str:
        super()._transcribe(audio_input_wav)
        transcript = self.openai.transcribe(audio_input_wav)
        return transcript.text if transcript else None

    def _process_transcript(self, transcript: str) -> str:
        self.messages.append({"role": "user", "content": transcript})

        # Check if the transcript is an instant activation command.
        # If so, it will be executed immediately and no further processing is needed.
        instant_activation_command = self._process_instant_activation_command(
            transcript
        )
        if instant_activation_command:
            self._play_audio(self._get_exact_response(instant_activation_command))
            return None

        # This is the main GPT call including tools / functions
        completion = self.openai.ask(
            messages=self.messages,
            tools=self.__get_tools(),
        )

        if completion is None:
            return None

        response_message = completion.choices[0].message
        tool_calls = response_message.tool_calls
        content = response_message.content

        # add the response message to the messages list so that it can be used in the next GPT call
        self.messages.append(response_message)

        # if there are tool calls, we have to process them
        if tool_calls:
            for tool_call in tool_calls:  # there could be multiple tool calls at once
                function_name = tool_call.function.name
                function_args = json.loads(tool_call.function.arguments)

                if function_name == "execute_command":
                    # get the command based on the argument passed by GPT
                    command = self._get_command(function_args["command_name"])
                    # execute the command
                    function_response = self._execute_command(command)
                    # if the command has responses, we have to play one of them
                    if command.get("responses"):
                        self._play_audio(self._get_exact_response(command))

                if function_name == "get_vision_from_screen_or_view":
                    question = function_args["original_question"]
                    function_response = self._get_vision_from_screen_or_view(question)

                # add the response of the function to the messages list so that it can be used in the next GPT call
                if function_response:
                    self.messages.append(
                        {
                            "tool_call_id": tool_call.id,
                            "role": "tool",
                            "name": function_name,
                            "content": function_response,
                        }
                    )

                if function_name == "get_vision_from_screen_or_view":
                    return None

            # Make a second GPT call to process the function responses.
            # This basically summarizes the function responses.
            # We don't need GPT-4-Turbo for this, GPT-3.5 is enough
            second_response = self.openai.ask(
                messages=self.messages,
                model="gpt-3.5-turbo-1106",
            )
            if second_response is None:
                return None

            second_content = second_response.choices[0].message.content
            self.messages.append(second_response.choices[0].message)
            self._play_audio(second_content)

            # return second_content

        return content

    def _finish_processing(self, text: str):
        if text:
            self._play_audio(text)

    def _play_audio(self, text: str):
        response = self.openai.speak(text, self.config["openai"].get("tts_voice"))
        if response is not None:
            self.audio_player.stream_with_effects(
                response.content,
                self.config.get("features", {}).get("play_beep_on_receiving"),
                self.config.get("features", {}).get("enable_radio_sound_effect"),
            )

    def __get_tools(self) -> list[dict[str, any]]:
        # all commands that are NOT instant_activation
        commands = [
            command["name"]
            for command in self.config["commands"]
            if not command.get("instant_activation")
        ]
        tools = [
            {
                "type": "function",
                "function": {
                    "name": "execute_command",
                    "description": "Executes a command",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "command_name": {
                                "type": "string",
                                "description": "The command to execute",
                                "enum": commands,
                            },
                        },
                        "required": ["command_name"],
                    },
                },
            },
            {
                "type": "function",
                "function": {
                    "name": "get_vision_from_screen_or_view",
                    "description": "Gets a description of what is on the screen or in the view.",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "original_question": {
                                "type": "string",
                                "description": "The original question that was asked",
                            },
                        },
                        "required": ["original_question"],
                    },
                },
            },
        ]
        return tools

    def _get_vision_from_screen_or_view(self, question: str) -> str:
        import dxcam

        print("Getting vision from screen or view...")

        camera = dxcam.create()
        frame = camera.grab()

        # Create a PIL image from array
        image = Image.fromarray(frame)

        desired_width = 1280
        aspect_ratio = image.height / image.width
        new_height = int(desired_width * aspect_ratio)

        # resized_image = image.resize((512, 512))
        resized_image = image.resize((desired_width, new_height))

        # Save the image
        resized_image.save("image.png")

        # Path to your image
        image_path = "image.png"

        # Getting the base64 string
        base64_image = self.encode_image(image_path)

        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer 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",
        }

        payload = {
            "model": "gpt-4-vision-preview",
            "messages": [
                self.messages[0],
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": f"{question} Please respond in max. 1 sentence.",
                        },
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{base64_image}"
                            },
                        },
                    ],
                }
            ],
            "max_tokens": 300,
        }

        response = requests.post(
            "https://api.openai.com/v1/chat/completions", headers=headers, json=payload
        )

        response_json = response.json()
        response_text = response_json.get("choices")[0].get("message").get("content")
        print(response_text)

        self._play_audio(response_text)

        return response_text

    def encode_image(self, image_path):
        with open(image_path, "rb") as image_file:
            return base64.b64encode(image_file.read()).decode("utf-8")
