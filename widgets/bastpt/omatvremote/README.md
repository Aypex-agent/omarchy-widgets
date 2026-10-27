# omatv remote

A remote for an Android TV or Google TV box, over the remote-control service the TV
already runs (`_androidtvremote2._tcp`) — the same channel the phone's own remote app
uses. No ADB, no developer options, no account, and nothing on the TV to install.

## What it shows

- **The tile** (6x3, minimum 4x3) — what the TV is doing, and the five keys worth a tap
  without opening anything: power, volume up, volume down, play/pause and mute.
- **The view** (tap the tile) — the whole remote: the pad with its centre key, back,
  home, recents, channels, transport, volume, a text box for typing into a field on the
  TV, and the switches.
- The play/pause key turns itself over as you tap it. The TV does not report playback
  over this service, so the symbol is what you last asked for, and goes back to play
  when the TV moves to another app or wakes.
- Holding the centre key sends it as a long press rather than a tap, which is how a TV
  opens the menu an app keeps behind it.
- Two layouts, `simple` and `full`, and volume by either thumb, so the remote fits the
  hand holding the phone. Keys a TV only answers in some apps draw outlined, and the
  line at the bottom names what the app in front ignores.

## Pairing

Type the TV's address and tap `pair` — the network page in the TV's own settings shows
it, as does your router's list of connected devices. The TV then shows a code; type
that into the field that appears and send. This is once per TV: the client certificate
and the address stay on the phone, and every later tap reuses them. To start over,
`python3 ~/.local/share/omatvremote/tvremote.py forget`.

## Where it keeps itself

The widget is one file. Its first run writes what it needs into
`~/.local/share/omatvremote` — the client, two helpers, a click sound and the copy of
the protocol library the client imports — and rewrites those only when the widget's own
copy changes, which a small tag file holds the hash of. Nothing is downloaded, nothing
is installed with pip, and each file the installer writes is mode 600.

Keys go through a small daemon that keeps one connection open, so a tap costs a write
to a pipe rather than a TLS handshake. It starts itself when the widget first asks for
the TV's state, or when a tap finds it gone, and reconnects with backoff while the TV is
out of reach. Once the tile stops asking — its page put away, or the phone asleep — the
daemon lets go of the TV and ends, so it holds no connection nobody is using; pairing a
second TV ends it the same way, whose keys must not keep going to the first.
`tvremote.py stop` ends it by hand, and every command leaves one line in
`~/.local/share/omatvremote/log`, kept under 32 KB.

A TV switched off with its own remote is the hard case: it stops answering but leaves
the connection behind, so a key written to it goes nowhere and nothing on the phone says
so. The service on the TV sends a keep-alive every few seconds and the client drops a
connection that has gone quiet for 16 of them, which is what tells the daemon the TV is
gone; a connect that is accepted but never opened as a remote session gives up after 10
seconds rather than waiting forever. From then on the widget says so, and a tap that
arrives while the TV is missed is held for 20 seconds in case the connection comes back,
then reported as never answered rather than counted as sent.

What it then says depends on what the address does, which is worth telling apart. A box
whose network is up but whose remote service is not — one in standby, or a television that
switched its panel off around a box still running — refuses the port, and the widget says
`asleep`. One that answers nobody, switched off at the socket or gone from this network,
waits out the network's own timeout, and the widget says `off the network`. In both the
keys dim and answer nothing, since with no session there is nowhere to send a key to,
power included; the daemon keeps asking, so the remote lights itself back up the moment
the TV's service comes back.

That ceiling is the protocol's rather than this widget's. Nothing in it carries the state
of a connected display, and the messages that would wake or sleep one are CEC, which an
app cannot send without a privileged service. So a box that is fully off cannot be woken
over the network at all, and a box that is awake behind a panel that is off keeps
reporting itself awake, with its app, and takes every key — the remote is honest about the
box, which is all the box is willing to say. On a television with Android TV or Google TV
built in, where the box and the panel are one machine, the two states above are all there
is, and a power key from this widget is what ends the standby one.

## Privacy

- The TV's address is kept in the widget's state and in that folder, and goes only to
  the TV itself, on ports 6466 and 6467 of the address you type. No other host is
  contacted.
- The pairing's private key is written by the client and never read by the widget's own
  commands.
- The text box types into whatever field is open on the TV, which can be a password.
  What you type is never shown in the widget and never written to the log: the log
  records `text (13 chars)`.
- The widget holds no account, no token and no location. Nothing personal is in this
  file: the only address in it is `192.168.0.123`, an example in a docstring.

## Requirements

The `requires` packages are what the protocol library imports and the helpers call:
`python`, `python-cryptography`, `python-protobuf`, `python-aiofiles` and `procps-ng`
(for `pgrep`).

`androidtvremote2` is vendored inside the widget file so that the whole thing ships as
one `.owl`. It is Copyright Joseph Wynn, licensed under the Apache License 2.0
(<https://github.com/JosephWynn/python-androidtvremote2>). Two changes are made to it:
its `"""` docstrings are written `'''`, which the widget language cannot hold inside a
command, and `Remote.async_connect` gives up on a TV that takes the connection but never
opens a remote session over it, where upstream waits on it forever.
