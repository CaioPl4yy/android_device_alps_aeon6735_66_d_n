LOCAL_PATH := $(call my-dir)

# LineageOS 15.1 Go (Android 8.1) for the MT6735 tablet, 1.5 GB RAM
$(call inherit-product, $(SRC_TARGET_DIR)/product/go_defaults.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, vendor/lineage/config/common_full_tablet.mk)  # TODO: _wifionly if no modem

PRODUCT_DEVICE := aeon6735_66_d_n
PRODUCT_NAME := lineage_aeon6735_66_d_n
PRODUCT_BRAND := alps
PRODUCT_MODEL := aeon6735_66_d_n
PRODUCT_MANUFACTURER := alps

PRODUCT_PROPERTY_OVERRIDES += ro.sf.lcd_density=210
PRODUCT_CHARACTERISTICS := tablet

# Stock init scripts (MTK). Ported from Android 7.0, may need syntax fixes for 8.1+.
PRODUCT_COPY_FILES += \
    $(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/*.rc),$(f):root/$(notdir $(f))) \
    $(LOCAL_PATH)/rootdir/fstab.mt6735:root/fstab.mt6735 \
    $(LOCAL_PATH)/rootdir/enableswap.sh:root/enableswap.sh

# Proprietary vendor blobs
$(call inherit-product-if-exists, vendor/eastaeon/aeon6735_66_d_n/aeon6735_66_d_n-vendor.mk)
