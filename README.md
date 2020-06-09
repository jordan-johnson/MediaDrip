# MediaDrip

MediaDrip allows you to download, convert, merge, and trim videos and other media.

## Planned Features

* Cross-platform (mobile & desktop)
* Download media via youtube-dl
* Manipulate media via ffmpeg
* Browse and play media

## Recent Updates (1.0 release)

- [x] Tested and working on Windows 10
- [x] Can update youtube-dl
- [x] Can download media via youtube-dl

*View more details on [CHANGELOG.md](CHANGELOG.md).*

## Dependencies

### Not included in build

* youtube-dl

* ffmpeg

### Included in build

* provider 4.1.2

* file chooser (currently unused)

* path provider (currently unused)

## Usage

In order to use the download functionality, you need to install youtube-dl and ffmpeg. Once done, verify that these are added to your environment variables. This is necessary as the current download functionality starts processes directly. This is why you'll see `cmd.exe` launch on windows. I cannot hide this without creating a hacky workaround, so I'm waiting on the dart devs to fix this.