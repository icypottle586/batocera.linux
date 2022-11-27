################################################################################
#
# pcsx2-avx2
#
################################################################################
#Version: Commits on Nov 27, 2022
PCSX2_AVX2_VERSION = v1.7.3648
PCSX2_AVX2_SITE = https://github.com/pcsx2/pcsx2.git
PCSX2_AVX2_SITE_METHOD = git
PCSX2_AVX2_GIT_SUBMODULES = YES
PCSX2_AVX2_LICENSE = GPLv3
PCSX2_AVX2_LICENSE_FILE = COPYING.GPLv3

PCSX2_AVX2_SUPPORTS_IN_SOURCE_BUILD = NO

PCSX2_AVX2_DEPENDENCIES += xserver_xorg-server alsa-lib freetype zlib libpng
PCSX2_AVX2_DEPENDENCIES += libaio portaudio libsoundtouch sdl2 libpcap yaml-cpp
PCSX2_AVX2_DEPENDENCIES += libsamplerate fmt wxwidgets libgtk3

PCSX2_AVX2_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
PCSX2_AVX2_CONF_OPTS += -DBUILD_SHARED_LIBS=OFF
PCSX2_AVX2_CONF_OPTS += -DPCSX2_TARGET_ARCHITECTURES=x86_64
PCSX2_AVX2_CONF_OPTS += -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE
PCSX2_AVX2_CONF_OPTS += -DwxWidgets_CONFIG_EXECUTABLE="$(STAGING_DIR)/usr/bin/wx-config"
PCSX2_AVX2_CONF_OPTS += -DQT_BUILD=FALSE
PCSX2_AVX2_CONF_OPTS += -DXDG_STD=TRUE
PCSX2_AVX2_CONF_OPTS += -DDISABLE_PCSX2_WRAPPER=1
PCSX2_AVX2_CONF_OPTS += -DPACKAGE_MODE=FALSE
PCSX2_AVX2_CONF_OPTS += -DENABLE_TESTS=OFF
PCSX2_AVX2_CONF_OPTS += -DUSE_SYSTEM_LIBS=AUTO
PCSX2_AVX2_CONF_OPTS += -DDISABLE_ADVANCE_SIMD=OFF
PCSX2_AVX2_CONF_OPTS += -DUSE_VTUNE=OFF
PCSX2_AVX2_CONF_OPTS += -DUSE_DISCORD_PRESENCE=OFF
PCSX2_AVX2_CONF_OPTS += -DLTO_PCSX2_CORE=ON
PCSX2_AVX2_CONF_OPTS += -DUSE_ACHIEVEMENTS=ON
PCSX2_AVX2_CONF_OPTS += -DUSE_ASAN=ON

ifeq ($(BR2_PACKAGE_XORG7),y)
    PCSX2_AVX2_CONF_OPTS += -DX11_API=ON
else
    PCSX2_AVX2_CONF_OPTS += -DX11_API=OFF
endif

ifeq ($(BR2_PACKAGE_BATOCERA_WAYLAND),y)
    PCSX2_AVX2_CONF_OPTS += -DWAYLAND_API=ON
else
    PCSX2_AVX2_CONF_OPTS += -DWAYLAND_API=OFF
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
    PCSX2_AVX2_CONF_OPTS += -DUSE_OPENGL=ON
else
    PCSX2_AVX2_CONF_OPTS += -DUSE_OPENGL=OFF
endif

ifeq ($(BR2_PACKAGE_VULKAN_HEADERS)$(BR2_PACKAGE_VULKAN_LOADER),yy)
    PCSX2_AVX2_CONF_OPTS += -DUSE_VULKAN=ON
else
    PCSX2_AVX2_CONF_OPTS += -DUSE_VULKAN=OFF
endif

define PCSX2_AVX2_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/buildroot-build/pcsx2/pcsx2 $(TARGET_DIR)/usr/pcsx2-avx2/bin/pcsx2
	cp -pr  $(@D)/bin/resources $(TARGET_DIR)/usr/pcsx2-avx2/bin/
endef

$(eval $(cmake-package))
