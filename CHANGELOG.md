# MediaDrip Changelog

## 1.1.0 (not complete)

### Important

> *NOTE:* The scope of the project has slightly changed. MediaDrip -- on top of downloading and modifying media -- will now aggregate media. This means MediaDrip can be your all-in-one application for playing/reading/listening, downloading, and modifying media. **Not all of these features will be available for v1.1.0 release.**

### New features

* Browse

    * Browse files and folders, allowing you to rename and delete files.

* Web feed

    * Landing page/home view now shows a web feed (currently supports Reddit and Youtube)

    * `feed.txt` located in `My Documents/MediaDrip/config/` houses each web address per line.

    * Each web feed is parsed, ordered by date, and is displayed to the user in a youtube-like fashion of today, yesterday, this week, this month, and older.

    * A setting was implemented to house a maximum number of feed entries. The oldest entries are removed based on this setting. The default setting is 30.

    * A setting was implemented to manage feeds. Users can add a new feed or delete an old one. Until a crossplatform database solution is available, editing a feed will not be implemented.

    * Clicking on an entry will take the user to the browse view which displays the entry's thumbnail, title, date, and description. A save button at the bottom right of the screen saves the media, if the media can be saved.

* Tools

    * Users can now modify media but with limited features.

    * Convert vid -> gif and vice versa.

    * Trim media from point A to B.

* Settings layout updated.

* Dark/light mode theme changer implemented.

### Fixes

* Refactored views because I wasn't happy with the ViewManagerService. I may revisit it some day but for now things are manually written out.

* Application title updated on Windows.

### To do

* Provide status functionality to services so views can update state when services are running.

* Test mobile devices and macOS.

## 1.0.1 (June 16, 2020)

### New features

* Settings implemented

* Storage directory (located in My Documents)

    * Currently stores application settings.

    * Will eventually store youtube-dl configuration and downloads.

### Fixes

* Refactored a ton... basically a rewrite

    * Wrote documentation for services

### To do

* Disable download and update buttons while youtube-dl service is running

* Improve visuals

* Test mobile devices

* RSS feed on home view

* Update settings view

    * Create, modify, and save a configuration file for youtube-dl

## 1.0 (June 09, 2020)

### New features

* Download media via youtube-dl
* Download progress output
* Update youtube-dl functionality (supports native and pip processes)

### To do

* Disable download and update buttons while youtube-dl service is running

* Improve visuals

* Test mobile devices

* RSS feed on home view

* Update settings view

    * Create, modify, and save app settings
    * Create, modify, and save a configuration file for youtube-dl

### Waiting on...

* Update window title on desktop

    * Flutter currently uses the directory name (src) for the window title. This would require me to create a workaround or wait for a fix.

* Cross-platform file chooser

    * Need a solution for browse and tools views. Currently exists for mobile but not desktop (unless you dig into plugins on [FDE repo](https://github.com/google/flutter-desktop-embedding)).

* Minimum window size on desktop

* Window position (center) on desktop