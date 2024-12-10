[![Build Status](https://travis-ci.org/card-io/card.io-Android-source.svg)](https://travis-ci.org/card-io/card.io-Android-source)

[![card.io logo](https://raw.githubusercontent.com/card-io/press-kit/master/card_io_logo_200.png "card.io")](https://www.card.io)

# Card IO Fork

This repo is a fork of the original Card IO Android SDK Source Code.

The main purpose being to fix the issues with Android 15, namely support for 16KB page size devices.

## Building this forked version

1. Clone this forked repo
2. Open the cloned project in a terminal and init its `dmz` submodule: `git submodule sync; git submodule update --init --recursive`.
Until dmz code is merged, checkout branch https://github.com/OS-pedrogustavobilro/card.io-dmz/tree/fix/RMET-3602/android15-16kb-page-size
3. Open the project in Android Studio (used Android Studio Ladybug | 2024.2.1 Patch 2 on Mac)
4. Install NDK 28 - Android Studio -> Tools -> SDK Manager 
5. Open the project in Android Studio (used Android Studio Ladybug | 2024.2.1 Patch 2 on Mac)
6. Download SDK 25 if you haven't already (In Android Studio -> Tools -> SDK Manager)
7. Set the JDK version of the project to JDK 17. 
8. If you are on a MAC OS and Apple is blocking NDK binaries, go to the folder where NDK is installed and run in a terminal `sudo spctl --master-disable`; then open Mac's Settings – Privacy and Security – Allow Applications from – Anywhere 
9. You should now be able to sync and build the card-io SDK -> `./gradlew assembleRelease`
10. Aar file in `card.io/build/outputs/aar`

### Open CV

The Open CV library's most recent version, 4.10.0, does not support 16KB page sizes. See https://github.com/opencv/opencv/issues/26027

So we built it from source using the branch from https://github.com/opencv/opencv/pull/26057.

Because OpenCV's build script generates an .so file for the entire library (increases the apk size by too much), but we only want a few modules, we use the script at [opencv/build_opencv_16kb.sh] 


------------------------
------------------------
------------------------
------------------------

Credit card scanning for Android apps
=====================================

This repository contains everything needed to build the [**card.io**](https://card.io) library for Android.

What it does not yet contain is much in the way of documentation. :crying_cat_face: So please feel free to ask any questions by creating github issues -- we'll gradually build our documentation based on the discussions there.

Note that this is actual production code, which has been iterated upon by multiple developers over several years. If you see something that could benefit from being tidied up, rewritten, or otherwise improved, your Pull Requests will be welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

Brought to you by
[![PayPal logo](https://raw.githubusercontent.com/card-io/card.io-iOS-source/master/Resources/pp_h_rgb.png)](https://paypal.com/ "PayPal")


Using card.io
-------------

If you merely wish to incorporate **card.io** within your Android app, simply download the latest official release from https://github.com/card-io/card.io-Android-SDK. That repository includes complete integration instructions and sample code.

Dev Setup
---------

### Prerequisites

- Current version of the Android SDK. (obviously)
- Android NDK. We've tested with r10e. At minimum, the Clang toolchain is required.

### First build

There are a few bugs in the build process, so these steps are required for the first build:

1. clone this repo
2. `$ cd card.io-Android-source`
3. init its `dmz` submodule: `git submodule sync; git submodule update --init --recursive`
4. `$ cp local.properties.example local.properties`
5. Edit `local.properties` with your env (Assuming you've defined `$ANDROID_NDK` correctly, run `$ echo "$ANDROID_NDK" "$ANDROID_SDK"`
6. `$ ./gradlew clean assembleDebug`

#### Hints & tricks.
- See [card.io/src/main/jni](card.io/src/main/jni) for native layer (NDK) discussion.

### Testing

#### Running

1. Connect an Android 18 (or better) device.
2. `$ ./gradlew connectedAndroidTest`

You should see the app open and run through some tests.

### Un-official Release

`$ ./gradlew clean :card.io:assembleRelease` Cleans and builds an aar file for distribution.

The [official release process](official-release-process.md) is described separately.

Contributors
------------

**card.io** was created by [Josh Bleecher Snyder](https://github.com/josharian/).

Subsequent help has come from [Brent Fitzgerald](https://github.com/burnto/), [Tom Whipple](https://github.com/tomwhipple), [Dave Goldman](https://github.com/dgoldman-ebay), [Jeff Brateman](https://github.com/braebot), [Roman Punskyy](https://github.com/romk1n), [Matt Jacunski](https://github.com/mattjacunski), [Dan Nizri](https://github.com/dsn5ft), and [Zach Sweigart](https://github.com/zsweigart).

And from **you**! Pull requests and new issues are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for details.



