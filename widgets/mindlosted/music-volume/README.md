# Music & Volume

A unified home-screen widget combining a now-playing media player card and an interactive vertical volume slider in one adaptive tile.

## Features

- **Media Player**:
  - Live album art (or fallback theme-tinted music note) with tap-to-open media player.
  - Track title and artist / source app name.
  - Audio output switcher (AirPlay / Bluetooth / Cast) using `settings("output")`.
  - Previous, Play/Pause, and Next playback controls.
  - Gracefully displays "Not playing" when no media is active.
- **Interactive Vertical Volume Slider**:
  - Directly sets media volume using `volume(level)` as you drag or tap.
  - Dynamic theme `accent` fill tracking volume level.
  - Quick mute toggle by tapping near the bottom or on the speaker icon.
  - Percentage readout at the top.
- **Theme Adaptive**:
  - Adapts to any Omarchy theme (`accent`, `foreground`, `background`, `surface`, `border`, `corners`).
- **Zero Dependencies**:
  - Uses native Android sources (`android.media`, `android.volume`) without requiring any Linux packages.
