# Erpiam

Erpiam is an Embedded Raspberry PI 3 Linux distribution for Audio and MIDI

## Purpose

This Linux distribution is extremely minimal and configured for low latency
and high performance. No services are started at all and a single main
application will be launched at the end of the boot process, running
full-screen.

## Main application

This is currently an example JUCE application, called erpiam-main.
It is configured in the 'package/erpiam-main' directory, refer to the Buildroot
documentation to make changes. If another binary should be launched during
boot, you might have to tweak the executable that is launched in the init
script 'board/erpiam/overlay/etc/init.d/S99main'.

The sources of the example JUCE application can be found here:
https://github.com/gbevin/erpiam-main

## Building

To build Erpiam, do the following:

1) run 'make erpiam_defconfig'
2) run 'make'
3) wait while it compiles
4) find the kernel, bootloader, root filesystem, etc. in output/images

The file 'output/images/sdcard.img' can be used to install Erpiam on an SD card.

Detailed information about how to install images for Raspberry PI on SD cards
can be found on the official Raspberry PI website:
https://www.raspberrypi.org/documentation/installation/installing-images/README.md

Here's a video that shows an example of Erpiam in action:

<a href="https://www.youtube.com/watch?v=brBYhjwltdo" target="_blank"><img src="https://i.ytimg.com/vi/brBYhjwltdo/maxresdefault.jpg" alt="Erpiam in action" width="640" height="360" border="0" /></a>

## Customizing

To customize Erpiam, do the following:

1) run 'rm -rf output' to clear all the previous build products
2) run 'make menuconfig'
3) navigate towards 'Target packages' and press enter
4) the top-entry is Erpiam with options underneath
5) pressing the '?' key when an option is highlighted will provide documentation
6) press ESC twice to exit
7) select 'Yes' to save the changes to your configuration

Erpiam can now be built as explained in the beginning of this document.

## All thanks to Buildroot

Erpian is created with Buildroot, a simple, efficient and easy-to-use tool
to generate embedded Linux systems through cross-compilation.

Online documentation for Buildroot can be found at
http://buildroot.org/docs.html

# Licensing

Buildroot is covered by its own GPLv2 licensing, but since it's a build
system that is not part of the final end product, the license of the
individual packages should be examined.

The Erpiam files that are in the located at board/erpiam,
package/erpiam, package/erpiam-main and configs/erpiam_defconfig, are
licensed under the Creative Commons Attribution 4.0 International License.