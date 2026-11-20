PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/omni_aeon6735_66_d_n.mk

# LineageOS product, only when the Lineage vendor config is present in the tree
ifneq ($(wildcard vendor/lineage/config/common.mk),)
PRODUCT_MAKEFILES += $(LOCAL_DIR)/lineage_aeon6735_66_d_n.mk
endif
