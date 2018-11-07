ERPIAM_DEPENDENCIES += rpi-firmware
ERPIAM_INSTALL_IMAGES = YES
ERPAIM_LOGO_LINES = `wc -l ${BR2_PACKAGE_ERPIAM_BOOT_SPLASH} | awk '{print $$1}'`

ifeq ($(BR2_PACKAGE_ERPIAM_X11_NOCURSOR),y)
define ERPIAM_INSTALL_X11_ARGS
	echo -n "-nocursor" > $(TARGET_DIR)/etc/x11args
endef
else
define ERPIAM_INSTALL_X11_ARGS
	echo -n "" > $(TARGET_DIR)/etc/x11args
endef
endif

define ERPIAM_INSTALL_DTOVERLAY
	echo "dtoverlay=${BR2_PACKAGE_ERPIAM_CONFIG_DTOVERLAY}" >> $(BINARIES_DIR)/rpi-firmware/config.txt
endef

define ERPIAM_INSTALL_DTPARAM
	echo "dtparam=${BR2_PACKAGE_ERPIAM_CONFIG_DTPARAM}" >> $(BINARIES_DIR)/rpi-firmware/config.txt
endef

define ERPIAM_INSTALL_BOOT_SPLASH
	sed -e "s/+1,@@/+1,$(ERPAIM_LOGO_LINES) @@/" package/erpiam/kernel.patch_header > ${BUILD_DIR}/erpiam_kernel.patch
	sed -e 's/^/+/' ${BR2_PACKAGE_ERPIAM_BOOT_SPLASH} >> ${BUILD_DIR}/erpiam_kernel.patch
endef

define ERPIAM_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 package/erpiam/config.txt $(BINARIES_DIR)/rpi-firmware/config.txt
	$(INSTALL) -D -m 0644 package/erpiam/cmdline.txt $(BINARIES_DIR)/rpi-firmware/cmdline.txt
	$(ERPIAM_INSTALL_X11_ARGS)
	$(ERPIAM_INSTALL_DTOVERLAY)
	$(ERPIAM_INSTALL_DTPARAM)
	$(ERPIAM_INSTALL_BOOT_SPLASH)
endef

$(eval $(generic-package))
