# Unknown Chinese tablet, MT6735 (stock: Android 7.0 NRD90M, build K1035P3_V1.0.0_20230214)
# Real hardware: 1.5 GB RAM / 16 GB eMMC. The ro.ty.fake.* props in stock are fake specs.
DEVICE_PATH := device/eastaeon/aeon6735_66_d_n

# Platform
TARGET_BOARD_PLATFORM := mt6735
TARGET_BOOTLOADER_BOARD_NAME := mt6735
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Architecture: 64-bit kernel (arm64), stock userspace is zygote64_32
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

# 32-bit secondary arch (zygote64_32 userspace). Kept for TWRP too: the TWRP 9.0 relink step
# needs the 32-bit linker, a 64-bit-only build fails with "system/bin/linker missing".
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_USES_64_BIT_BINDER := true

# Kernel: prebuilt from stock boot.img (Image.gz + appended DTB, Linux 3.18.35)
# No mkbootimg --dt needed, the DTB is appended to the kernel.
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz-dtb
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00080000
BOARD_RAMDISK_OFFSET := 0x04000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_TAGS_OFFSET := 0x0e000000
# LK needs bootopt= in the cmdline to choose the 64-bit kernel path
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --second_offset $(BOARD_SECOND_OFFSET) --tags_offset $(BOARD_TAGS_OFFSET)

# Partitions (from MTKClient printgpt)
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2994733056
BOARD_CACHEIMAGE_PARTITION_SIZE := 419430400
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12018253824
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_COPY_OUT_VENDOR := system/vendor

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
BOARD_HAS_NO_SELECT_BUTTON := true
RECOVERY_SDCARD_ON_DATA := true

# TWRP
# NOTE: never put a trailing "# comment" after a value, make keeps the spaces in it.
ifneq ($(wildcard bootable/recovery/gui),)
RECOVERY_VARIANT := twrp
endif
# Panel is 800x1280 portrait, density 210
TW_THEME := portrait_hdpi
# Stock uses ro.sf.hwrotation=180, remove this line if the first boot looks right without it
TW_ROTATION := 180
TW_DEFAULT_LANGUAGE := en
# TODO: verify the backlight path on the device
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120
# LK fastboot is not usable on this device
TW_NO_REBOOT_BOOTLOADER := true
# Keep the image small: the recovery partition is only 16 MB and the kernel takes ~6.5 MB
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := true
TW_NO_EXFAT := true
TW_NO_EXFAT_FUSE := true
# TODO: stock userdata uses encryptable=<metadata partition>, crypto is left off for now

-include vendor/eastaeon/aeon6735_66_d_n/BoardConfigVendor.mk
