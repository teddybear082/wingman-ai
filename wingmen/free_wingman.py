from wingmen.wingman import Wingman
from services.edge import EdgeTTS
from services.printr import Printr
import speech_recognition as sr


class FreeWingman(Wingman):
    async def _transcribe(self, audio_input_wav: str) -> tuple[str | None, str | None]:
        r = sr.Recognizer()
        with sr.AudioFile(audio_input_wav) as source:
            audio = r.record(source)
        result = r.recognize_google(audio)

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
        edge_tts = EdgeTTS()
        random_voice = await edge_tts.get_random_voice()
        await edge_tts.generate_speech(
            text, filename="audio_output/free.mp3", voice=random_voice
        )
        self.audio_player.play("audio_output/free.mp3")
