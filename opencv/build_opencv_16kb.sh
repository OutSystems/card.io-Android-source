# This is a script to build open cv with only the necesssary modules for card io with support for 16KB page size.
# The reason why we don't use the standard build_sdk.py that comes in the Open CV repository is that there seems to be no way to only build the .so files for the modules we want, resulting in the card io aar file becoming quite large.
#
# Built with MAC OS, arm architecture (M1 processor) and NDK 27.
# Script may take a few minutes to run.
#
# Follow the steps below:
# 1. Clone the open CV repository - I checkout the branch from a fork with the following PR:
#   https://github.com/opencv/opencv/pull/26057
# 2. Paste this script at the root folder of the repo
# 3. Install NDK 27 (easily done from Android Studio -> Tools -> SDK Manager -> SDK Tools -> Check "Show Package Details" in bottom right corner to be able to select a specific NDK version)
# 4. Set / Confirm the variables in the script
# 5. Add run permissions to the script - "chmod +x <file_name>"
# 6. Run this script.
# 7. .so files for each cpu Architecture will be located at build_opencv_so_files. Just copy and paste them to card-io repository - "card.io/src/main/jni/lib".

# IMPORTANT - Step 4. - Set / confirm these variables before running the script
# location of the NDK 27; If you installed it via Android Studio it should be in a directory inside Android SDK location.
PATH_TO_NDK_27="/Users/pedrobilro/Library/Android/sdk/ndk/27.0.12077973"
# toolchain file to use by cmake; if you are using NDK 27, you can leave it as is
PATH_TO_CMAKE_TOOLCHAIN="$PATH_TO_NDK_27/build/cmake/android.toolchain.cmake"
# strip command to decrease size of generated .so files; if you are using a different CPU architecture (e.g. MAC with intel processor) you may need to change this line
PATH_TO_NDK_STRIP_COMMAND="$PATH_TO_NDK_27/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-strip"

# this is the directory where the generated .so files will be at
mkdir build_opencv_so_files

build_so_for_architecture()
{
    # this is the directory where cmake will run
    mkdir opencv_build_16kb_$arch
    cd opencv_build_16kb_$arch

    arch=$1
    cmake_extra_args=$2
    cmake -DCMAKE_TOOLCHAIN_FILE="$PATH_TO_CMAKE_TOOLCHAIN" -DAndroid_NDK="$PATH_TO_NDK_27" -DANDROID_NATIVE_API_LEVEL=android-21 -DBUILD_JAVA=OFF -DBUILD_ANDROID_EXAMPLES=OFF -DBUILD_ANDROID_PROJECTS=OFF -DANDROID_STL=c++_shared -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX:PATH=~/opencv_build_16kb/ $cmake_extra_args -DBUILD_LIST=core,imgproc  ..

    # build .so files
    make opencv_core -j8
    make opencv_imgproc -j8

    # make file size smaller
    "$PATH_TO_NDK_STRIP_COMMAND" --strip-all lib/$arch/libopencv_core.so
    "$PATH_TO_NDK_STRIP_COMMAND" --strip-all lib/$arch/libopencv_imgproc.so

    mkdir ../build_opencv_so_files/$arch
    cp lib/$arch/libopencv_core.so ../build_opencv_so_files/$arch/libopencv_core.so
    cp lib/$arch/libopencv_imgproc.so ../build_opencv_so_files/$arch/libopencv_imgproc.so

    cd ..
}


build_so_for_architecture armeabi-v7a "-DANDROID_ABI=armeabi-v7a -DWITH_NEON=ON"
build_so_for_architecture arm64-v8a "-DANDROID_ABI=arm64-v8a -DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON"
build_so_for_architecture x86_64 "-DANDROID_ABI=x86_64 -DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON"
build_so_for_architecture x86 "-DANDROID_ABI=x86"

echo "COMPLETE!"