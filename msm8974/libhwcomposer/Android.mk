LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/../common.mk
include $(CLEAR_VARS)

# hwc.cpp uses GNU old-style field designator extension.
LOCAL_CLANG_CFLAGS            += -Wno-gnu-designator
LOCAL_MODULE                  := hwcomposer.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH             := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_SHARED_LIBRARIES        := $(common_libs) libEGL liboverlay \
                                 libexternal libqdutils libhardware_legacy \
                                 libdl libmemalloc libqservice libsync \
                                 libbinder libmedia
LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"qdhwcomposer\"

ifneq ($(BONE_STOCK),true)
  ifeq ($(TARGET_BUILD_VARIANT),userdebug debug)
    LOCAL_CFLAGS += -D_DISABLE_RUNTIME_DEBUGGING
  endif
endif

LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := hwc.cpp          \
                                 hwc_utils.cpp    \
                                 hwc_uevents.cpp  \
                                 hwc_vsync.cpp    \
                                 hwc_fbupdate.cpp \
                                 hwc_mdpcomp.cpp  \
                                 hwc_copybit.cpp  \
                                 hwc_qclient.cpp  \
                                 hwc_ad.cpp

include $(BUILD_SHARED_LIBRARY)
