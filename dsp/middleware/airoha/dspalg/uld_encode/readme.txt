ULD encode module usage guide

Brief:          This module is the ULD encode implementation for audio. It provides support for ULD encode.

Usage:          XT-XCC:  For ULD encode, make sure to include the following:
                      1) Add the following module.mk for libs and source file:
                         include $(SOURCE_DIR)/$(MIDDLEWARE_PROPRIETARY)/dspalg/uld_encode/module.mk
                      2) module.mk provides different options to enable or disable according to the profiles.
                         Please configure the related options on the specified XT-XCC/feature.mk.
                         AIR_AUDIO_ULD_ENCODE_ENABLE
                         AIR_AUDIO_ULD_ENCODE_USE_PIC_ENABLE
                      3) Add the header file path:
                         CFLAGS += -I$(SOURCE_DIR)/$(MIDDLEWARE_PROPRIETARY)/dspalg/uld_encode/inc
                      4) Add CODEC_ENCODER_ULD into the feature table in dsp_sdk.c to apply ULD encode in the specified scenario.

Dependency:     None.

Notice:         1) AIR_AUDIO_ULD_ENCODE_ENABLE must be set as "y" on the specified XT-XCC/feature.mk.

Relative doc:   None

Example project: None
