from wingmen.wingman import Wingman
from services.edge import EdgeTTS
from services.secret_keeper import SecretKeeper
import speech_recognition as sr


class FreeWingman(Wingman):
    def __init__(self, name: str, config: dict[str, any], secret_keeper: SecretKeeper):
        super().__init__(name, config, secret_keeper)
        self.edge_tts = EdgeTTS()
        self.r = sr.Recognizer()

    async def _transcribe(self, audio_input_wav: str) -> tuple[str | None, str | None]:
        with sr.AudioFile(audio_input_wav) as source:
            audio = self.r.record(source)
        result = self.r.recognize_google(audio)

        return result, None

    async def _get_response_for_transcript(
        self, transcript: str, locale: str | None
    ) -> tuple[str, str]:
        instant_response = self._try_instant_activation(transcript)
        if instant_response:
            return instant_response, instant_response

        return None, None

    async def _play_to_user(self, text: str):
        if not text or text == "None":
            return

        edge_config = self.config["edge_tts"]
        if edge_config:
            tts_voice = edge_config.get("tts_voice")

            await self.edge_tts.generate_speech(
                text, filename="audio_output/free.mp3", voice=tts_voice
            )

            if self.config.get("features", {}).get("enable_robot_sound_effect"):
                self.audio_player.effect_audio("audio_output/free.mp3")

            self.audio_player.play("audio_output/free.mp3")
