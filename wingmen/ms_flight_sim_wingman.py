from api.interface import (
    WingmanConfig,
)
from services.audio_player import AudioPlayer
from services.printr import Printr
from wingmen.open_ai_wingman import OpenAiWingman
from SimConnect import *

printr = Printr()


class MSFlightSimWingman(OpenAiWingman):

    def __init__(
        self, name: str, config: WingmanConfig, audio_player: AudioPlayer
    ) -> None:
        super().__init__(name=name, config=config, audio_player=audio_player)

        self.simconnect = None
        self.aircraft = None

    async def _execute_command_by_function_call(
        self, function_name: str, function_args: dict[str, any]
    ) -> tuple[str, str]:
        (
            function_response,
            instant_response,
        ) = await super()._execute_command_by_function_call(
            function_name, function_args
        )
        
        if function_name == "read_aircraft_and_environment_data":
            function_response = await self._read_aircraft_and_environment_data(**function_args)
        
        return function_response, instant_response
    
    async def try_simconnect(self) -> bool:
        try:
            self.simconnect = SimConnect()
            self.aircraft = AircraftRequests(self.simconnect, _time=1000)
            return True
        except Exception as e:
            return False

    async def _read_aircraft_and_environment_data(self, variable: str) -> str:
        if not self.simconnect:
            if not await self.try_simconnect():
                return "SimConnect not available."

        data = self.aircraft.get(variable)

        print(variable)
        print(data)
        return data

    def _build_tools(self) -> list[dict[str, any]]:
        tools = super()._build_tools()
        tools.append(
            {
                "type": "function",
                "function": {
                    "name": "read_aircraft_and_environment_data",
                    "description": "Reads the aircraft and environment data from the simulator.",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "variable": {
                                "type": "string",
                                "description": "The variable to read from the simulator.",
                                "enum": [
                                    "PLANE_ALTITUDE",
                                ],
                            },
                        },
                        "required": ["variable"],
                    },
                },
            }
        )
        return tools