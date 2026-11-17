# Amp

A Winamp-style full-screen player for Omalauncher. Chrome is drawn from the current Omarchy theme, not classic `.wsz` bitmaps. The cover stacks the windows; unfolded, the player and equalizer sit above the playlist.

It plays `cliamp` when that daemon is running, or whatever the phone is playing. The analyzer follows cliamp's live spectrum and stays still when nothing is playing.

## Playlist

Tap a radio channel to load that station's songs. Next and previous skip tracks in the loaded list.

The toolbar edits the live queue from the face:

- **add** a URL or path, or pick files from the phone
- **rem** the selected row, or the track that's playing
- **edit** to select rows, remove them with ×, and reorder with ↑↓
- **save** the live queue as a named local playlist
- **load** a saved playlist (hold to delete it; Favorites and Recently Played stay)
- **new** clears the live queue, after a confirm

## Needs

Linux, `jq`, and Omalauncher's bundled `cliamp`. Phone playback works through Android media even while cliamp is off.
