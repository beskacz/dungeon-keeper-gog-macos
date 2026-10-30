# Dungeon Keeper Gold on modern macOS

> **Did it work? Please star this repository.** A star helps other Dungeon
> Keeper players—and search/indexing tools—find a verified modern macOS fix.

Run the GOG macOS release of **Dungeon Keeper Gold** full-screen on modern
Apple Silicon Macs by replacing only its single-player DOSBox launcher with
[DOSBox Staging](https://www.dosbox-staging.org/).

The original GOG wrapper bundles DOSBox 0.74-2 from 2014. It can open a Retina
full-screen surface while leaving the game at a fixed size in the centre. This
patch makes both single-player and multiplayer scale across the complete
display while keeping the original game, CD image, music, saves, language files
and GOG launcher.

The replacement scripts start DOSBox independently, so the GOG launcher closes
as soon as the game opens instead of remaining on top of the game window.

## Requirements

- A legitimate GOG installation at `/Applications/Dungeon Keeper Gold™.app`
- macOS 12 or newer on an Apple Silicon Mac
- [Homebrew](https://brew.sh/)

No game data is included in this repository.

## Install

Install DOSBox Staging:

```bash
brew install dosbox-staging
```

Download or clone this repository, then run:

```bash
chmod +x install.sh
./install.sh
```

Open **Dungeon Keeper Gold™** normally and choose **Singleplayer** or
**Multiplayer**. The game will fill the Retina display. The supplied profile
intentionally stretches the original image to the whole screen. To preserve the
original proportions, edit `dosboxDK_staging.conf` and change `aspect=stretch`
to `aspect=on`.

## Multiplayer

The GOG launcher provides two choices:

- **Start Network Host Game** starts an IPX-over-UDP server on port `19900`.
- **Start Network Client Game** asks for the host address. Enter the address and
  port separated by a space, for example `192.168.1.20 19900`.

For play on the same LAN, use the host Mac's local IP address. For internet
play, forward UDP port `19900` to the host Mac. If port forwarding is not
available, both players can join the same Tailscale or ZeroTier network and use
the host's VPN address.

Both players should select the same game—Dungeon Keeper or Deeper Dungeons—and
then choose the in-game multiplayer option.

## Zoom on a MacBook

The original DOS release does not support mouse-wheel or two-finger trackpad
zoom. Its documented zoom keys are `Home` and `End`. On a MacBook keyboard use:

- `Fn` + `Left Arrow` - zoom in (`Home`)
- `Fn` + `Right Arrow` - zoom out (`End`)

The alternative original controls are right Control + Up/Down, but `Fn` with
the arrow keys is usually more convenient on a Mac laptop.

## Higher internal resolution

The fullscreen patch scales the picture to the complete Retina display, but the
original game starts dungeon levels in its low internal resolution. After a
level has loaded, press `Option` + `R` (`Alt` + `R` on a PC keyboard) to toggle
the original high-resolution mode.

The unmodified DOS game only offers its original low and high modes; arbitrary
HD, 1440p, or Retina internal resolutions require KeeperFX. Menus and videos may
continue to use their original fixed resolutions.

The included DOSBox Staging profile also replaces GOG's fixed `80000`-cycle
setting with the dynamic CPU core and `200000` protected-mode cycles. This gives
the high-resolution renderer substantially more headroom while keeping a fixed,
repeatable emulated speed.

## Custom app location

Pass the `.app` path as the first argument:

```bash
./install.sh "/path/to/Dungeon Keeper Gold™.app"
```

## Restore the original launcher

```bash
./uninstall.sh
```

The installer creates one-time backups named `script_sp.pre-dosbox-staging`,
`script_s.pre-dosbox-staging`, and `script_c.pre-dosbox-staging`. It does not
alter or redistribute the game files.

## Troubleshooting

- **Small image with a thick border:** confirm that
  `/opt/homebrew/bin/dosbox` exists, then run `./install.sh` again.
- **White screen:** the original 2014 `surface` renderer is still being used;
  reinstall this patch so `script_sp` launches DOSBox Staging.
- **GOG launcher remains over the game:** update to the latest version and run
  `./install.sh` again; current launch scripts detach DOSBox before returning.
- **Two-finger scrolling does not zoom:** this is a limitation of the original
  DOS game, not the renderer. Use `Fn` + Left/Right Arrow for Home/End.
- **Dungeon graphics look blocky:** after entering a level, press `Option` + `R`
  to switch to the original high-resolution mode.
- **High-resolution mode is slow:** reinstall the latest patch. It includes the
  updated dynamic CPU profile; older releases inherited GOG's `80000` cycles.
- **Normal black bars at the sides:** you selected the proportion-preserving
  `aspect=on` option. Use `aspect=stretch` to fill the entire widescreen panel.

## Files

- `files/script_sp` — launches GOG single-player with DOSBox Staging
- `files/script_s` — launches the multiplayer host
- `files/script_c` — launches the multiplayer client
- `files/dosboxDK_staging.conf` — modern Retina/full-screen rendering override
- `install.sh` — backs up and installs the two changed files
- `uninstall.sh` — restores the original single-player launcher
- `docs/index.html` — simple GitHub Pages documentation

## GitHub Pages

Push this directory to GitHub, then open **Settings → Pages** and select:

- Source: **Deploy from a branch**
- Branch: **main**
- Folder: **/docs**

## Notes

- Multiplayer uses DOSBox Staging's IPX-over-UDP support on port `19900`.
- Polish and other GOG language selections continue to work.
- DOSBox Staging may print compatibility warnings for the old GOG config; the
  relevant settings are overridden by `dosboxDK_staging.conf`.

Dungeon Keeper is a trademark of Electronic Arts. This project contains only
configuration and launcher scripts and is not affiliated with EA, GOG, or the
DOSBox Staging project.
