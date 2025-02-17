################################################################################
#
# ustreamer-custom
#
################################################################################

USTREAMER_VERSION = 5.51
USTREAMER_SITE = https://sources.buildroot.net/ustreamer
USTREAMER_SOURCE = ustreamer-$(USTREAMER_VERSION).tar.gz
USTREAMER_SUBDIR = ustreamer-custom
USTREAMER_LICENSE = GPL-3.0-or-later
USTREAMER_LICENSE_FILES = LICENSE
USTREAMER_DEPENDENCIES = jpeg libevent libbsd libgpiod
USTREAMER_CONF_ENV = "CFLAGS=$(TARGET_CFLAGS)"

define USTREAMER_BUILD_CMDS
	$(MAKE)  $(if $(BR2_PACKAGE_SYSTEMD),WITH_SYSTEMD=1, ) WITH_PTHREAD_NP=1  WITH_SETPROCTITLE=1 HAS_PDEATHSIG=1 $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define USTREAMER_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/src/ustreamer.bin $(TARGET_DIR)/usr/bin/ustreamer
    $(INSTALL) -D -m 0755 $(@D)/src/ustreamer-dump.bin $(TARGET_DIR)/usr/bin/ustreamer-dump
endef

$(eval $(generic-package))
