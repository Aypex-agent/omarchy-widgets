# Miami · Night Call

Offline top-down action game for Omalauncher, written in Python/Pygame and bundled as a self-contained OWL app.

**One level only.** This release contains a single motel level. Everyone is welcome to modify the code, map, colors, controls and difficulty, or make new levels, under the MIT license. All source is included in app.owl; no external game files are required.

**Un solo nivel.** Incluye un único nivel de motel. Cada persona puede modificar el código y el mapa como quiera, o crear nuevos niveles, bajo licencia MIT.

Tap JUGAR to open the Linux game window. Left stick moves; right stick aims. Automatic shooting is on by default. AUTO toggles it, TIRO cycles 0.38/0.55/0.80 seconds between pistol shots, and DISPARAR fires manually. CARGAR reloads. Settings are stored only in ~/.local/share/miami-night-call/.miami-settings.json. The starting street is safe; enter through the door to fight. Clear the first room and approach the upper door to open it, then clear the motel and return to the exit.

Dependencies: python and python-pygame. No network requests, remote code, accounts or personal files. All Python code and artwork are included in app.owl as readable source inside its launch command. It creates its own data directory and uses a PID lock under /tmp to replace its own previous game window on a repeated launch.

The OWL app is a launch screen; gameplay opens in a graphical Linux window through the documented app action. The game uses an original motel layout and code-drawn pixel art. It has no external game assets or audio.

Validation: owl-check, bundled game --self-test, dummy SDL launch/preview. Submit to apps/alqtest/miami-night-call/app.owl. License: MIT.
