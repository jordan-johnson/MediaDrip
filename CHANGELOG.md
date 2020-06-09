# MediaDrip Changelog

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