[![Build Status](https://travis-ci.org/card-io/card.io-Android-source.svg)](https://travis-ci.org/card-io/card.io-Android-source)

[![card.io logo](https://raw.githubusercontent.com/card-io/press-kit/master/card_io_logo_200.png "card.io")](https://www.card.io)

# Card IO Fork

This repo is a fork of the original Card IO Android SDK Source Code.

The main purpose being to fix the issues with Android 15, namely support for 16KB page size devices.

## Building this forked version

1. Clone this forked repo
2. Open the cloned project in a terminal and init its `dmz` submodule: `git submodule sync; git submodule update --init --recursive`
3. Install NDK 17 - https://github.com/android/ndk/wiki/Unsupported-Downloads#r17c
4. If you are on a MAC OS be sure to follow the steps 4a. and 4b.

    4a. Update the ndk-build to not fail if running on arm64 architecture (M1 processors) - https://stackoverflow.com/a/69555276
    
    4b. For Mac OS to not block NDK, run `sudo spctl --master-disable` and open Mac's Settings – Privacy and Security – Allow Applications from – Anywhere
5. Paste the ndk folder in the Android studio NDK location.
6. Open the project in Android Studio (used Android Studio Ladybug | 2024.2.1 Patch 2 on Mac)
7. Download SDK 25 if you haven't already (In Android Studio -> Tools -> SDK Manager)
8. Set the JDK version of the project to JDK 11.
9. You should now be able to sync and build the card-io SDK.

The card-io SDK crashes on 16KB page size devices. The same thing applies to the OpenCV library.

See https://github.com/opencv/opencv/issues/26027 + https://github.com/opencv/opencv/pull/26057

The next steps would be do update the OpenCV library and build it with a more recent version of NDK - https://developer.android.com/guide/practices/page-sizes#compile-r27

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



