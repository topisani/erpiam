OTTO_MAIN_SITE_METHOD = git
OTTO_MAIN_VERSION = develop-topisani
OTTO_MAIN_GIT_SUBMODULES = YES
OTTO_MAIN_SITE = https://github.com/topisani/otto.git
OTTO_MAIN_DEPENDENCIES = alsa-lib freetype libcurl rpi-firmware rpi-userland

ifeq ($(BR2_i386),y)
	OTTO_MAIN_TARGET_ARCH = x86
else ifeq ($(BR2_x86_64),y)
	OTTO_MAIN_TARGET_ARCH = x64
else ifeq ($(BR2_powerpc),y)
	OTTO_MAIN_TARGET_ARCH = ppc
else ifeq ($(BR2_arm)$(BR2_armeb),y)
	OTTO_MAIN_TARGET_ARCH = armv7-a
else ifeq ($(BR2_mips),y)
	OTTO_MAIN_TARGET_ARCH = mips
else ifeq ($(BR2_mipsel),y)
	OTTO_MAIN_TARGET_ARCH = mipsel
else
	OTTO_MAIN_TARGET_ARCH = $(BR2_ARCH)
endif

define OTTO_MAIN_BUILD_CMDS
    CXXFLAGS+=-march=$(OTTO_MAIN_TARGET_ARCH) ;\
    CFLAGS+=-march=$(OTTO_MAIN_TARGET_ARCH) ;\
    cd $(@D)  ;\
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) cmake .  -DOTTO_BOARD=rpi-proto-1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ;\
    cmake --build .
endef

define OTTO_MAIN_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bin/otto $(TARGET_DIR)/usr/bin/otto-main
	mkdir -p $(TARGET_DIR)/usr/share/otto/data
	cp -r $(@D)/data $(TARGET_DIR)/usr/share/otto/data
endef

$(eval $(generic-package))
