ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PoGO-Tweak
PoGO-Tweak_FILES = Tweak.xm $(wildcard *.m) $(wildcard google/protobuf/*.m)

include $(THEOS_MAKE_PATH)/tweak.mk
