This repository contains Android build files and various additional
files needed to build your self a version of libcairo and libpixman
that you can use on Android devices.

This is for Android applications that are using the NDK for some or
all of their work - only the C/C++ headers are present, there are
no Java bindings included.


Obtaining the source code
=========================

This git repository uses submodules to track the official cairo
and pixman repositories, as such you'll need to do a 

    git clone --recursive git@github.com:anoek/android-cairo.git

to pull down not only the android-cairo source, but also the
cairo and pixman source.


Compiling & Using
=================

The contents of the jni/ directory are meant to be either copied
or symlinked into your application's jni/ directory. Once done,
you can then include the cairo.mk and pixman.mk files into your
own Android.mk file, modify your LOCAL_CFLAGS variable to add
include paths for each of the cairo/pixman/cairo-extra/pixman-extra
directories, then finally add libcairo and libpixman to your
LOCAL_STATIC_LIBRARIES variable.

Once all of that is done, simply run ndk-build to compile everything
together to produce your application's .so file.

For more concrete usage information, see the example applications
in examples/

Screenshots
===========

![From pure-ndk](https://github.com/anoek/android-cairo/raw/master/examples/pure-ndk/screenshot.png)
