# MediaDrip

MediaDrip is a media aggregator, downloader, and manager. 

## Features

* Cross-platform (mobile & desktop) using Flutter.
* Download audio and video with MediaDrip's easy-to-use interface using Youtube-DL, which supports hundreds of sites and has over 700 open source contributors.
* Supports image downloading from configurable `Source` downloaders.
* Easily convert, trim, and crop your media with a simple interface for ffmpeg.
* Aggregate media into a personalized web feed.
* Organize your web feed with profiles (not yet available).
* Modify media metadata.
* Browse and play media (not yet available).

## Recent Updates (1.0.1 release)

- [x] Settings implemented
- [x] Storage directory (placed in device's documents)

*View more details on [CHANGELOG.md](CHANGELOG.md).*

## Dependencies

### Not included in build

* youtube-dl

* ffmpeg

### Included in build

* provider 4.1.2

* get it 4.0.2

* file chooser (currently unused)

* path provider 1.5.1

    * path provider flutter-desktop-embedding commit 79d73d3

## Usage

In order to use the download functionality, you need to install youtube-dl and ffmpeg. Once done, verify that these are added to your environment variables. This is necessary as the current download functionality starts processes directly. This is why you'll see `cmd.exe` launch on windows. I cannot hide this without creating a hacky workaround, so I'm waiting on the dart devs to fix this.