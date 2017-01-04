ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

DIR1 = ../../../
DIR2 = ../../

INC=$(DIR1) $(DIR2) ...
INC_PARAMS=$(foreach d, $(INC), -I$d)

TWEAK_NAME = PoGO-Tweak
PoGO-Tweak_FILES = Tweak.xm $(wildcard *.m) $(wildcard google/protobuf/*.m)
#$(wildcard /*/*.m)

include $(THEOS_MAKE_PATH)/tweak.mk
