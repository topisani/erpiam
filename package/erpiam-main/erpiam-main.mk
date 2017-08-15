ERPIAM_MAIN_SITE_METHOD = git
ERPIAM_MAIN_VERSION = master
ERPIAM_MAIN_SITE = https://github.com/gbevin/erpiam-main.git
ERPIAM_MAIN_DEPENDENCIES = alsa-lib freetype libcurl xlib_libX11 xlib_libXext xlib_libXcursor xlib_libXinerama xlib_libXrandr

ifeq ($(BR2_i386),y)
	ERPIAM_MAIN_TARGET_ARCH = x86
else ifeq ($(BR2_x86_64),y)
	ERPIAM_MAIN_TARGET_ARCH = x64
else ifeq ($(BR2_powerpc),y)
	ERPIAM_MAIN_TARGET_ARCH = ppc
else ifeq ($(BR2_arm)$(BR2_armeb),y)
	ERPIAM_MAIN_TARGET_ARCH = armv7-a
else ifeq ($(BR2_mips),y)
	ERPIAM_MAIN_TARGET_ARCH = mips
else ifeq ($(BR2_mipsel),y)
	ERPIAM_MAIN_TARGET_ARCH = mipsel
else
	ERPIAM_MAIN_TARGET_ARCH = $(BR2_ARCH)
endif

define ERPIAM_MAIN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) CONFIG=Release TARGET_ARCH=-march=$(ERPIAM_MAIN_TARGET_ARCH) -C $(@D)/Builds/LinuxMakefile
endef

define ERPIAM_MAIN_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/Builds/LinuxMakefile/build/erpiam-main $(TARGET_DIR)/usr/bin/erpiam-main
endef

$(eval $(generic-package))
