# Weather & Wear

Today's local weather and practical, gender-neutral outfit suggestions from Codex.
The tile shows current and feels-like temperatures, the daily range, peak rain
chance and wind, and a clothing suggestion. Tap it for the full outfit, useful
accessories, the weather explanation, UV index, and settings.

## Setup

1. Enable the launcher's Arch Linux environment. The widget declares `python`
   and `bash`; Python uses only its standard library.
2. Install Codex through the launcher's agent settings and sign in. Codex is
   managed by the launcher through mise, rather than installed with pacman.
   The widget looks for `codex` on PATH, then in mise's standard installation.
3. Tap the widget, enter a city and clothing preferences, and tap **Save settings**.
   A blank city uses the public network's approximate location, which can be
   affected by a VPN. Use the temperature button to switch between Celsius and
   Fahrenheit.

Weather remains available without Codex; outfit suggestions require a working,
signed-in Codex installation. Account usage limits and charges, if applicable,
are those of the user's Codex account. Clothing advice is currently in English.

## Refresh and data

- Weather comes from wttr.in, fetched from Android every 30 minutes while the
  widget is active. **Refresh weather** requests an immediate update.
- Codex receives the forecast, including approximate location, and the saved
  clothing preferences. Advice uses a temporary working directory and an
  ephemeral, read-only Codex session with a structured JSON response.
- Successful suggestions are cached for up to three hours in
  `~/.cache/omalauncher/weather-wear/`. Failed requests are cached for ten minutes
  where possible. **New suggestion** requests a fresh answer.
- City, clothing preferences, and temperature units are saved by the launcher.
  The shared widget file contains no account credentials or saved user settings.

## License

MIT, as declared in `widget.owl` and the store repository's LICENSE.
