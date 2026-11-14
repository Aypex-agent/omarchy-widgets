# capture

Talk to your phone, and it lands in a file your terminal can read.

Tap the bar, speak, tap it again. The words appear in a field right on the tile, where you
fix them with the keyboard, then save. Nothing is written before you have seen it — the
draft survives a restart, so a half-finished thought is never lost.

Entries go to `~/inbox.md`, one per line, as a plain markdown list:

```
# inbox · what you said to the phone. tick a line to close it.
- [ ] call the plumber about the drip
- [x] buy a 30W charger
```

- `○` ticks an entry done (`- [x]`): it stays in the file and in the list, dimmed. Tap `●` to undo.
- Tap an entry's words to edit it in the same field; saving rewrites that line.
- `×` asks first (`delete?`), then removes the line from the file.

Because it is a plain file, `grep`, a shell script or a coding agent can add to it, and the
tile picks it up: the two sides share one list. Change the path by editing the `source
inbox = file(...)` line.

Dictation is Android's own speech recognizer, so it needs a microphone and asks for it the
first time you tap the bar. Without one (or without Linux installed) the editor still works
by typing — the file is the only part that needs Arch.
