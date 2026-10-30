# Dungeon Keeper Gold on modern macOS

> **Did it work? Please star this repository.** A star helps other Dungeon
> Keeper players—and search/indexing tools—find a verified modern macOS fix.

Run the GOG macOS release of **Dungeon Keeper Gold** full-screen on modern
Apple Silicon Macs by replacing only its single-player DOSBox launcher with
[DOSBox Staging](https://www.dosbox-staging.org/).

The original GOG wrapper bundles DOSBox 0.74-2 from 2014. It can open a Retina
full-screen surface while leaving the game at a fixed size in the centre. This
patch keeps the original game, CD image, music, saves, language files and GOG
launcher, but uses a current renderer for single-player.

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

Open **Dungeon Keeper Gold™** normally and choose **Singleplayer**. The game
will fill the Retina display. The supplied profile intentionally stretches the
original image to the whole screen. To preserve the original proportions, edit
`dosboxDK_staging.conf` and change `aspect=stretch` to `aspect=on`.

## Custom app location

Pass the `.app` path as the first argument:

```bash
./install.sh "/path/to/Dungeon Keeper Gold™.app"
```

## Restore the original launcher

```bash
./uninstall.sh
```

The installer creates a one-time backup named
`script_sp.pre-dosbox-staging`. It does not alter or redistribute the game
files.

## Troubleshooting

- **Small image with a thick border:** confirm that
  `/opt/homebrew/bin/dosbox` exists, then run `./install.sh` again.
- **White screen:** the original 2014 `surface` renderer is still being used;
  reinstall this patch so `script_sp` launches DOSBox Staging.
- **Normal black bars at the sides:** you selected the proportion-preserving
  `aspect=on` option. Use `aspect=stretch` to fill the entire widescreen panel.

## Files

- `files/script_sp` — launches the GOG configuration with DOSBox Staging
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

- Multiplayer launch scripts are left untouched.
- Polish and other GOG language selections continue to work.
- DOSBox Staging may print compatibility warnings for the old GOG config; the
  relevant settings are overridden by `dosboxDK_staging.conf`.

Dungeon Keeper is a trademark of Electronic Arts. This project contains only
configuration and launcher scripts and is not affiliated with EA, GOG, or the
DOSBox Staging project.
