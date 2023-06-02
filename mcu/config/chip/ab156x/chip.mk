MIDDLEWARE_PROPRIETARY                = middleware/airoha
MTK_SYSLOG_VERSION_2                  ?= y
MTK_SYSLOG_SUB_FEATURE_STRING_LOG_SUPPORT = y
MTK_SYSLOG_SUB_FEATURE_BINARY_LOG_SUPPORT = y
MTK_SYSLOG_SUB_FEATURE_OFFLINE_DUMP_ACTIVE_MODE = y
MTK_SYSLOG_SUB_FEATURE_MSGID_TO_STRING_LOG_SUPPORT = n
MTK_DEBUG_PLAIN_LOG_ENABLE            ?= n
AIR_SYSLOG_STACK_MONITOR_ENABLE       := y
MTK_CPU_NUMBER_0                      ?= y
MTK_MUX_ENABLE                        ?= y
FPGA_ENV                              ?= n
MTK_EXCEPTION_CONFIG_BY_NVKEY         ?= y
MTK_AUDIO_LOOPBACK_TEST_ENABLE        ?= y
MTK_AVM_DIRECT                        ?= y
AIR_BT_CODEC_ENABLED                  ?= y
AIR_HWSRC_CLKSKEW_ENABLE              ?= y

ifeq ($(AIR_ECNR_CONFIG_TYPE),ECNR_1_OR_2_MIC)
AIR_ECNR_1_OR_2_MIC_ENABLE      = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),ECNR_1MIC_INEAR)
AIR_ECNR_1MIC_INEAR_ENABLE      = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),ECNR_2MIC_INEAR)
AIR_ECNR_2MIC_INEAR_ENABLE      = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),3RD_PARTY_AI_NR)
AIR_3RD_PARTY_NR_ENABLE         = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),3RD_PARTY_AI_NR_OFFLOAD)
AIR_3RD_PARTY_NR_ENABLE         = y
AIR_ECNR_PREV_PART_ENABLE       = y
AIR_ULL_ECNR_PREV_PART_ENABLE = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),3RD_PARTY_AI_NR_OFFLOAD_POST_EC)
AIR_3RD_PARTY_NR_ENABLE         = y
AIR_ECNR_POST_PART_ENABLE       = y
AIR_ULL_ECNR_POST_PART_ENABLE = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),3RD_PARTY_AI_NR_INEAR)
AIR_3RD_PARTY_NR_ENABLE         = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),3RD_PARTY_AI_NR_SHORT_BOOM_OO)
AIR_3RD_PARTY_NR_ENABLE         = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),3RD_PARTY_CUSTOMIZED)
AIR_3RD_PARTY_NR_ENABLE         = y
endif

ifeq ($(AIR_ECNR_CONFIG_TYPE),LD_NR)
AIR_LD_NR_ENABLE         = y
endif

ifneq ($(AIR_ECNR_CONFIG_TYPE),none)
AIR_AIRDUMP_ENABLE              = y
endif

AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE_ENABLE ?= y
AIR_SMT_SPK_TO_MIC_TEST_ENABLE ?= $(MTK_SMT_AUDIO_TEST)
AIR_UPLINK_RATE                       ?= none
AIR_UPLINK_RESOLUTION                 ?= none
AIR_DOWNLINK_RATE                     ?= none
AIR_MP3_TASK_DEDICATE_ENABLE = y
MTK_CAPID_IN_NVDM_AT_COMMAND_ENABLE   ?= y

# This option is used to support TFM
# Dependency: NA
AIR_LIMIT_TZ_ENABLE                   ?= n
# code run in S or NS world #s or ns
# This feature must be set for both DSP and MCU, otherwise, it will not work.
AIR_CPU_SECURITY_MODE                 ?= s

# This option is used to support fulldump
# Dependency:NA
AIR_FULLDUMP_ENABLE                   ?= y

# This option is used to support minidump
# Dependency:NA
AIR_MINIDUMP_ENABLE                   := y

# This option is used to support monitor systemhang
# Dependency: NA
# system hang debug: none, y, o1, o2 and mp
AIR_SYSTEM_HANG_TRACER_ENABLE         ?= y

# This option is used to support swla
# Dependency: NA
AIR_SWLA_ENABLE                       ?= y

# This option is used to support MTK_SUPPORT_HEAP_DEBUG
# Dependency: NA
AIR_SUPPORT_HEAP_DEBUG                ?= y

# This option is used to support MTK_HEAP_SIZE_GUARD_ENABLE
# Dependency: NA
AIR_HEAP_SIZE_GUARD_ENABLE            ?= n

# This option is used to support AIR_MEMORY_MONITOR_ENABL
# Dependency: NA
AIR_MEMORY_MONITOR_ENABLE             ?= n

# This option is used to support AIR_BOOTREASON_CHECK_ENABLE
# Dependency: NA
AIR_BOOTREASON_CHECK_ENABLE           ?= y

# This option is used to support AIR_SYSTEM_AT_COMMAND_ENABLE
# Dependency: NA
AIR_SYSTEM_AT_COMMAND_ENABLE          ?= n

# This option is used to support Non-Volatile Data Management feature.
# Dependency: HAL_FLASH_MODULE_ENABLED must be enabled when this option is set to y.
AIR_NVDM_ENABLE                       ?= y

# This option is used to determine whether to replace nvdm with nvkey,
# which has the advantage of allowing the memory layout owner to calculate the partition size required by NVDM.
# Dependency: AIR_NVDM_ENABLE must be enabled when this option is set to y.
AIR_REPLACE_NVDM_WITH_NVKEY           ?= y

# BT Relate
MTK_BT_DUO_ENABLE                   ?= y
MTK_BT_ENABLE                       ?= y
MTK_BLE_ONLY_ENABLE                 ?= n
MTK_BT_HFP_ENABLE                   ?= y
MTK_BT_HSP_ENABLE                   ?= y
MTK_BT_AVRCP_ENABLE                 ?= y
MTK_BT_AVRCP_ENH_ENABLE             ?= y
MTK_BT_A2DP_ENABLE                  ?= y
MTK_BT_PBAP_ENABLE                  ?= n
MTK_BT_SPP_ENABLE                   ?= y
MTK_BT_TIMER_EXTERNAL_ENABLE        ?= y
MTK_PORT_SERVICE_ENABLE             ?= y
MTK_PORT_SERVICE_BT_ENABLE          ?= y
MTK_MUX_BT_ENABLE                   ?= y


COM_CFLAGS += -DAIR_BTA_IC_PREMIUM_G2
AIR_BTA_IC_PREMIUM_G2 = y

ifeq ($(IC_TYPE),ab1565)
COM_CFLAGS += -DAIR_BTA_IC_PREMIUM_G2_TYPE_65
AIR_BTA_PMIC_G2_LP = y
COM_CFLAGS += -DAIR_BTA_PMIC_G2_LP
endif

ifeq ($(IC_TYPE),ab1568)
COM_CFLAGS += -DAIR_BTA_IC_PREMIUM_G2_TYPE_68
AIR_BTA_PMIC_G2_HP = y
COM_CFLAGS += -DAIR_BTA_PMIC_G2_HP
endif

ifeq ($(IC_TYPE),ab1565d)
COM_CFLAGS += -DAIR_BTA_IC_PREMIUM_G2_TYPE_65D
AIR_BTA_PMIC_G2_LP = y
COM_CFLAGS += -DAIR_BTA_PMIC_G2_LP
endif


AR      = $(BINPATH)/arm-none-eabi-ar
CC      = $(BINPATH)/arm-none-eabi-gcc
CXX     = $(BINPATH)/arm-none-eabi-g++
OBJCOPY = $(BINPATH)/arm-none-eabi-objcopy
SIZE    = $(BINPATH)/arm-none-eabi-size
OBJDUMP = $(BINPATH)/arm-none-eabi-objdump


ALLFLAGS = -mlittle-endian -mthumb -mcpu=cortex-m4
FPUFLAGS = -Wdouble-promotion -mfpu=fpv4-sp-d16 -mfloat-abi=hard
COM_CFLAGS += $(ALLFLAGS) $(FPUFLAGS) -ffunction-sections -fdata-sections -fno-builtin -Wimplicit-function-declaration
COM_CFLAGS += -Os -Wall -fno-strict-aliasing -fno-common -Wno-address-of-packed-member
ifneq ($(MTK_SOURCE_COMPILE_DEBUG_INFO_ENABLE),n)
   COM_CFLAGS += -gdwarf-2
endif
PRODUCT_VERSION                       = 0
COM_CFLAGS += -Wall -Wimplicit-function-declaration -Werror=uninitialized -Werror=return-type

# protect code that compares with NULL after pointer arithmetic from being optimized away
COM_CFLAGS += -fno-tree-vrp -fno-tree-dominator-opts
COM_CFLAGS += -Werror
COM_CFLAGS += -DPCFG_OS=2 -D_REENT_SMALL -Wno-switch
COM_CFLAGS += -DPRODUCT_VERSION=$(PRODUCT_VERSION)
COM_CFLAGS += -DCORE_CM4
COM_CFLAGS += -D$(TARGET)_BOOTING
ifeq ($(FPGA_ENV),y)
COM_CFLAGS += -DFPGA_ENV
endif
LDFLAGS += -Wl,--gc-sections -Wl,-wrap=printf
LDFLAGS += -u _printf_float
LDFLAGS += -Wl,-wrap=memcpy -Wl,-wrap=memset -Wl,-wrap=memclr

##
## AIR_MEMORY_MONITOR_ENABLE
## Brief:       This option is to debug memory corruption.
## Usage:       The valid values are y,n.
##              The setting will determine if memory monitor will be used.
##              However, the setting has no effect on the prebuilt library.
## Path:        kernel/service/memory_monitor
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_MEMORY_MONITOR_ENABLE),y)
# COM_CFLAGS += -fstack-protector-all
COM_CFLAGS += -DMTK_MEMORY_MONITOR_ENABLE
endif

##
## AIR_SYSTEM_HANG_TRACER_ENABLE
## Brief:       This option is to debug system hang issue.
## Usage:       The valid values are y, o1, o2.
##              The setting will determine which level of system hang tracer will be used.
##              However, the setting has no effect on the prebuilt library.
##              y    : wdt interrupt mode will be used in tracing system hang.
##              o1   : wdt interrupt mode will be used in tracing system hang.
##              o2   : wdt reset mode and rtc module will be used in tracing system hang.
## Path:        kernel/service/systmehang_tracer
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_SYSTEM_HANG_TRACER_ENABLE),y)
COM_CFLAGS += -DMTK_SYSTEM_HANG_TRACER_ENABLE
endif

ifeq ($(AIR_SYSTEM_HANG_TRACER_ENABLE),o1)
COM_CFLAGS += -DMTK_SYSTEM_HANG_TRACER_ENABLE
COM_CFLAGS += -DMTK_SYSTEM_HANG_TRACER_ENABLE_O1
endif

ifeq ($(AIR_SYSTEM_HANG_TRACER_ENABLE),o2)
COM_CFLAGS += -DMTK_SYSTEM_HANG_TRACER_ENABLE
COM_CFLAGS += -DMTK_SYSTEM_HANG_TRACER_ENABLE_O2
endif

ifeq ($(AIR_SYSTEM_HANG_TRACER_ENABLE),mp)
COM_CFLAGS += -DMTK_SYSTEM_HANG_TRACER_ENABLE
COM_CFLAGS += -DMTK_SYSTEM_HANG_TRACER_ENABLE_MP
endif

##
## AIR_SYSLOG_STACK_MONITOR_ENABLE
## Brief:       This option is used to monitor syslog call stack.
## Usage:       Enable the feature by configuring it as y.
##              y : enable syslog stack monitor
##              n : disable syslog stack monitor
## Path:        kernel/service/syslog
## Dependency:  None
## Notice:      None
## Related doc :None
##
ifeq ($(AIR_SYSLOG_STACK_MONITOR_ENABLE),y)
COM_CFLAGS += -DAIR_SYSLOG_STACK_MONITOR_ENABLE
endif

##
## MTK_DEBUG_PLAIN_LOG_ENABLE
## Brief:       This option is used to force log display with plain style.
## Usage:       Enable the feature by configuring it as y.
##              y : log display with plain style
##              n : log display with race style, need pc logging tool support
## Path:        kernel/service/syslog
## Dependency:  None
## Notice:      None
## Related doc :None
##
ifeq ($(MTK_DEBUG_PLAIN_LOG_ENABLE),y)
COM_CFLAGS += -DMTK_DEBUG_PLAIN_LOG_ENABLE
endif

##
## AIR_SYSLOG_BUFFER_EXPAND_ENABLE
## Brief:       This option is used to increase syslog buffer.
## Usage:       Enable the feature by configuring it as y.
##              y : larger syslog buffer
##              n : default syslog buffer
## Path:        kernel/service/syslog
## Dependency:  None
## Notice:      None
## Related doc :None
##
ifeq ($(AIR_SYSLOG_BUFFER_EXPAND_ENABLE),y)
COM_CFLAGS += -DAIR_SYSLOG_BUFFER_EXPAND_ENABLE
endif

##
## AIR_BOOTREASON_CHECK_ENABLE
## Brief:       This option is to check boot reason and get the information about the last crash.
## Usage:       The valid values are n, y.
##              n   : no effect
##              y   : enable boot reason check feature.
## Path:        kernel/service/bootreason_check
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_BOOTREASON_CHECK_ENABLE),y)
COM_CFLAGS += -DMTK_BOOTREASON_CHECK_ENABLE
endif


##
## AIR_DEBUG_LEVEL
## Brief:       This option is to configure system log debug level.
## Usage:       The valid values are empty, error, warning, info, debug, and none.
##              The setting will determine whether a debug log will be compiled.
##              However, the setting has no effect on the prebuilt library.
##              empty   : All debug logs are compiled.
##              error   : Only error logs are compiled.
##              warning : Only warning and error logs are compiled.
##              info    : Only info, warning, and error logs are compiled.
##              debug   : All debug logs are compiled.
##              none    : All debugs are disabled.
## Path:        kernel/service
## Dependency:  None
## Notice:      None
## Realted doc: Please refer to doc/Airoha_IoT_SDK_for_BT_Audio_155x_API_Reference_Manual.html
##
AIR_DEBUG_LEVEL ?= $(MTK_DEBUG_LEVEL)

ifeq ($(AIR_DEBUG_LEVEL),)
COM_CFLAGS += -DMTK_DEBUG_LEVEL_DEBUG
COM_CFLAGS += -DMTK_DEBUG_LEVEL_INFO
COM_CFLAGS += -DMTK_DEBUG_LEVEL_WARNING
COM_CFLAGS += -DMTK_DEBUG_LEVEL_ERROR
endif

ifeq ($(AIR_DEBUG_LEVEL),error)
COM_CFLAGS += -DMTK_DEBUG_LEVEL_ERROR
endif

ifeq ($(AIR_DEBUG_LEVEL),warning)
COM_CFLAGS += -DMTK_DEBUG_LEVEL_WARNING
COM_CFLAGS += -DMTK_DEBUG_LEVEL_ERROR
endif

ifeq ($(AIR_DEBUG_LEVEL),info)
COM_CFLAGS += -DMTK_DEBUG_LEVEL_INFO
COM_CFLAGS += -DMTK_DEBUG_LEVEL_WARNING
COM_CFLAGS += -DMTK_DEBUG_LEVEL_ERROR
endif

ifeq ($(AIR_DEBUG_LEVEL),debug)
COM_CFLAGS += -DMTK_DEBUG_LEVEL_DEBUG
COM_CFLAGS += -DMTK_DEBUG_LEVEL_INFO
COM_CFLAGS += -DMTK_DEBUG_LEVEL_WARNING
COM_CFLAGS += -DMTK_DEBUG_LEVEL_ERROR
endif

ifeq ($(AIR_DEBUG_LEVEL),printf)
COM_CFLAGS += -DMTK_DEBUG_LEVEL_PRINTF
endif

ifeq ($(AIR_DEBUG_LEVEL),none)
COM_CFLAGS += -DMTK_DEBUG_LEVEL_NONE
endif

##
## MTK_SAVE_LOG_TO_FLASH_ENABLE
## Brief:       This option is used to enable log saving to flash feature.
## Usage:       Enable the feature by configuring it as y.
##              y : save runtime log content to flash
##              n : transfer runtime log over logging port
## Path:        kernel/service/syslog
## Dependency:  flash driver
## Notice:      Reserve flash blocks to store runtime log
## Related doc :None
##
ifeq ($(MTK_SAVE_LOG_TO_FLASH_ENABLE),y)
    CFLAGS += -DMTK_SAVE_LOG_TO_FLASH_ENABLE
endif
##

##
## AIR_MINIDUMP_ENABLE
## Brief:       This option is used to enable minidump feature.
## Usage:       Enable the feature by configuring it as y.
##              y : minidump
##              n : no minidump
## Path:        kernel/service/exception
## Dependency:  flash driver
## Notice:      Reserve flash blocks to store runtime log
## Related doc :None
##
AIR_MINIDUMP_ENABLE ?=$(MTK_MINIDUMP_ENABLE)
ifeq ($(AIR_MINIDUMP_ENABLE),y)
    COM_CFLAGS += -DMTK_MINIDUMP_ENABLE
endif
##

##
## AIR_FULLDUMP_ENABLE
## Brief:       This option is used to enable fulldump feature.
## Usage:       Enable the feature by configuring it as y.
##              y : fulldump enable
##              n : fulldump disable
## Path:        kernel/service/exception
## Dependency:  syslog
## Notice:      Output dump information by UART or USB
## Related doc :None
##
ifeq ($(AIR_FULLDUMP_ENABLE),y)
    COM_CFLAGS += -DMTK_FULLDUMP_ENABLE
endif
##


##
## MTK_SYSTEM_HANG_CHECK_ENABLE
## Brief:       This option is to enable system hang issue debug feature .
## Usage:       Enable the feature by configuring it as y.
## Path:        kernel/rtos/FreeRTOS/Source/portable/GCC/ARM_CM4F
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_SYSTEM_HANG_CHECK_ENABLE),y)
COM_CFLAGS         += -DMTK_SYSTEM_HANG_CHECK_ENABLE
endif

##
## MTK_HAL_PLAIN_LOG_ENABLE
## Brief:       This option is to enable hal plain log.
## Usage:       Enable the feature by configuring it as y.
## Path:        mcu/driver/chip/ab156x/src/hal_log.c
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_HAL_PLAIN_LOG_ENABLE),y)
COM_CFLAGS         += -DMTK_HAL_PLAIN_LOG_ENABLE
endif

##
## MTK_NO_PSRAM_ENABLE
## Brief:       This option is to enable/disable PSRAM.
## Usage:       If the value is "y", the MTK_HAL_PLAIN_LOG_ENABLE will be defined, PSRAM will be initialized
##              in the initialization phase the option to "y" include the driver/chip/mtxxxx/module.mk.
## Path:        driver/chip/mtxxxx
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_NO_PSRAM_ENABLE),y)
CFLAGS         += -DMTK_NO_PSRAM_ENABLE
endif

##
## AIR_PROMPT_SOUND_ENABLE
## Brief:       This option is to enable prompt sound feature.
## Usage:       If the value is "y",  the AIR_PROMPT_SOUND_ENABLE and MTK_AUDIO_MIXER_SUPPORT compile options will be defined.
## Path:        middleware/airoha/audio/audio_mixer/
## Dependency:  Must enable HAL_AUDIO_MODULE_ENABLED feature.mk under the project GCC folder..
## Notice:      None.
## Relative doc:None
##
ifeq ($(AIR_PROMPT_SOUND_ENABLE),y)
  CFLAGS += -DAIR_PROMPT_SOUND_ENABLE
  CFLAGS += -DMTK_AUDIO_MIXER_SUPPORT
endif

##
## AIR_PROMPT_CODEC_TYPE
## Brief:       This option is to configure voice prompt decoder codec type.
## Usage:       The valid values are none, mp3, wav, opus(specific), all.
##              The setting will determine whether a debug log will be compiled.
##              all     : Support all decoder codec types, mp3/pcm/wav/opus.
##              mp3     : Support MP3 voice prompt files, default selection.
##              wav     : Support WAV voice prompt files, a-law/u-law/ms-adpcm/ima-adpcm/pure pcm.
##              opus    : Support OPUS voice prompt files, 1 channel, 48 KHz, 20 ms frame size and CELT elementary stream.
##              none    : Unused codec. It can still be used to play pure pcm.
## Path:        middleware/airoha/audio/prompt_control
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_PROMPT_CODEC_TYPE),mp3)
AIR_MP3_DECODER_ENABLE = y
endif

ifeq ($(AIR_PROMPT_CODEC_TYPE),wav)
AIR_WAV_DECODER_ENABLE = y
endif

ifeq ($(AIR_PROMPT_CODEC_TYPE),opus)
AIR_OPUS_DECODER_ENABLE = y
endif

ifeq ($(AIR_PROMPT_CODEC_TYPE),all)
AIR_MP3_DECODER_ENABLE = y
AIR_WAV_DECODER_ENABLE = y
AIR_OPUS_DECODER_ENABLE = y
endif

##
## AIR_SYSTEM_AT_COMMAND_ENABLE
## Brief:       This option is to enable and disable at commands for system service, include show task information, heap infomation, and force system crash to get memory dump
## Usage:       Please use AT+SYSTEM=? to get detail info for this atcmd
## Path:        mcu\middleware\airoha\atci\at_command\at_command_system.c
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_SYSTEM_AT_COMMAND_ENABLE),y)
COM_CFLAGS += -DMTK_SYSTEM_AT_COMMAND_ENABLE
endif

##
## AIR_OS_CPU_UTILIZATION_ENABLE
## Brief:       This option is to enable and disable cpu utilization function.
## Usage:       Please use AT+UTILIZATION=? to get detail info for this atcmd
## Path:        mcu\middleware\airoha\atci\at_command\at_command_system.c
## Dependency:  None
## Notice:      None
## Realted doc: None
##
ifeq ($(AIR_OS_CPU_UTILIZATION_ENABLE),y)
COM_CFLAGS         += -DMTK_OS_CPU_UTILIZATION_ENABLE
endif

##
## MTK_AVM_DIRECT
## Brief:       MTK_AVM_DIRECT is a option for Bluetooth Audio.
## Usage:       If the value is "y", the option MTK_AVM_DIRECT will be defined.
## Path:        middleware/airoha/sink
## Dependency:  Must enable the MTK_AVM_DIRECT for bluetooth audio.
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_AVM_DIRECT),y)
COM_CFLAGS         += -DMTK_AVM_DIRECT
endif

##
## MTK_AWS_MCE_ENABLE
## Brief:       MTK_AWS_MCE_ENABLE is an option for Bluetooth Audio to enable Airoha Wireless Stereo with Multicast Extention.
## Usage:       If the value is "y", the option MTK_AWS_MCE_ENABLE will be defined.
## Path:        middleware/airoha/sink
## Dependency:  MTK_AVM_DIRECT
## Notice:      None
## Relative doc:None
##

##
## MTK_MUX_AWS_MCE_ENABLE
## Brief:       MTK_MUX_AWS_MCE_ENABLE is an option for Bluetooth Audio to enable Airoha Wireless Stereo with Multicast Extention via MUX service.
## Usage:       If the value is "y", the option MTK_MUX_AWS_MCE_ENABLE will be defined.
## Path:        kernel/service/mux
## Dependency:  MTK_AWS_MCE_ENABLE
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_AWS_MCE_ENABLE),y)
COM_CFLAGS         += -DMTK_AWS_MCE_ENABLE
ifeq ($(MTK_MUX_AWS_MCE_ENABLE),y)
COM_CFLAGS         += -DMTK_MUX_AWS_MCE_ENABLE
endif
endif

##
## AIR_USB_ENABLE
## Brief:       This option is to enable and disable USB module.
## Usage:       If the value is "y", the MTK_USB_DEMO_ENABLED compile option will be defined. You must include following module in your Makefile before setting.
##              the option to "y"
##              include the /middleware/airoha/usb/module.mk
## Path:        middleware/airoha/usb
## Dependency:  HAL_USB_MODULE_ENABLED must also defined in hal_feature_config.h under project inc folder.
##
AIR_USB_ENABLE  ?=  $(MTK_USB_DEMO_ENABLED)
ifeq ($(AIR_USB_ENABLE),y)
CFLAGS         += -DMTK_USB_DEMO_ENABLED
endif

##
## MTK_PORT_SERVICE_ENABLE
## Brief:       This option is to enable port service feature.
## Usage:       Enable the feature by configuring it as y.
## Path:        middleware/airoha/port_service
## Dependency:  NVDM module must be enabled.
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_PORT_SERVICE_ENABLE),y)
  CFLAGS += -DMTK_PORT_SERVICE_ENABLE
  CFLAGS += -DMTK_PORT_SERVICE_SLIM_ENABLE
endif

##
## MTK_PORT_SERVICE_BT_ENABLE
## Brief:       This option is to enable port service feature via spp or ble profile in mt2523.
## Usage:       Enable the feature by configuring it as y.
## Path:        middleware/airoha/port_service/src
## Dependency:  Must enable the MTK_PORT_SERVICE_ENABLE for port service feature.
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_PORT_SERVICE_ENABLE),y)
ifeq ($(MTK_PORT_SERVICE_BT_ENABLE),y)
  CFLAGS += -DMTK_PORT_SERVICE_BT_ENABLE
endif
endif

##
## MTK_AIRUPDATE_ENABLE
## Brief:       This option is to enable port service feature via airupdate profile in AB155X.
## Usage:       Enable the feature by configuring it as y.
## Path:        middleware/airoha/bt_air/airupdate/src
## Dependency:  Must enable the MTK_PORT_SERVICE_ENABLE and MTK_PORT_SERVICE_BT_ENABLE for port service feature.
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_PORT_SERVICE_ENABLE),y)
ifeq ($(MTK_PORT_SERVICE_BT_ENABLE),y)
ifeq ($(MTK_AIRUPDATE_ENABLE),y)
  CFLAGS += -DMTK_AIRUPDATE_ENABLE
endif
endif
endif

##
## MTK_BT_A2DP_AAC_ENABLE
## Brief:       This option is to enable Middleware BT A2DP AAC decoder function under gva/driver/board/mt25x3_hdk/bt_codec folder.
## Usage:       If the value is "y", the MTK_BT_A2DP_AAC_ENABLE compile option will be defined, the sources and header files under gva/driver/board/mt25x3_hdk/bt_codec/src and gva/driver/board/mt25x3_hdk/bt_codec/inc/ will be included by gva/driver/board/mt25x3_hdk/bt_codec/module.mk.
## Path:        gva/driver/board/mt25x3_hdk/bt_codec
## Dependency:  DSP, HAL_AUDIO_MODULE_ENABLED.
## Notice:      None.
## Relative doc:None
##
ifeq ($(MTK_BT_A2DP_AAC_ENABLE),y)
CFLAGS   += -DMTK_BT_A2DP_AAC_ENABLE
endif

##
## MTK_HAL_EXT_32K_ENABLE
## Brief:       This option is to determine to use external 32k crystal.
## Usage:       Enable the feature by configuring it as y.
## Path:        driver/chip/mtxxxx
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_HAL_EXT_32K_ENABLE),y)
COM_CFLAGS         += -DMTK_HAL_EXT_32K_ENABLE
endif

##
## MTK_FOTA_ENABLE
## Brief:       This option is to enable and disable FOTA.
## Usage:       If the value is "y", the MTK_FOTA_ENABLE compile option will be defined. You must also include the \middleware\airoha\fota\module.mk in your Makefile before setting the option to "y".
## Path:        middleware/airoha/fota
## Dependency:  HAL_FLASH_MODULE_ENABLED and HAL_WDT_MODULE_ENABLED must also defined in the hal_feature_config.h  under the project inc folder. If MTK_FOTA_CLI_ENABLE defined in the module.mk is "y", please also include the middleware/airoha/tftp/module.mk.
## Notice:      Please use the driver/CMSIS/Device/airoha/$(IC_CONFIG)/linkerscript/gcc/full_bin_fota/flash.ld for gcc build environment.
##              Please use the driver/CMSIS/Device/airoha/$(IC_CONFIG)/linkerscript/rvct/full_bin_fota/flash.sct for KEIL build environment.
##              Please use the driver/CMSIS/Device/airoha/$(IC_CONFIG)/linkerscript/iar/full_bin_fota/flash.icf for IAR build environment.
## Relative doc:Please refer to the firmware update developer's guide under the doc folder for more detail.
##
#ifeq ($(MTK_FOTA_ENABLE),y)
#CFLAGS += -DMTK_FOTA_ENABLE
#endif

##
## AIR_RACE_CMD_ENABLE
## Brief:       This option is to enable RACE CMD.
## Usage:       Enable the feature by configuring it as y.
## Path:                middleware/airoha/race_cmd
## Dependency:  None
## Notice:      None
## Relative doc:None
##
AIR_RACE_CMD_ENABLE  ?=  $(MTK_RACE_CMD_ENABLE)
ifeq ($(AIR_RACE_CMD_ENABLE),y)
CFLAGS         += -DMTK_RACE_CMD_ENABLE
endif

##
## AIR_SMART_CHARGER_ENABLE
## Brief:       This option is to enable smart charger feature.
## Usage:       Enable the feature by configuring it as y.
## Path:                middleware/airoha/smart_charger, earbuds_ref_design/src/apps/app_smart_charger
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_SMART_CHARGER_ENABLE),y)
CFLAGS         += -DAIR_SMART_CHARGER_ENABLE
endif

##
## AIR_1WIRE_ENABLE
## Brief:       This option is to enable smart charger 1WIRE.
## Usage:       Enable the feature by configuring it as y.
## Path:                middleware/airoha/smart_charger
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_1WIRE_ENABLE),y)
CFLAGS         += -DAIR_1WIRE_ENABLE
endif

##
## MTK_RACE_RELAY_CMD_ENABLE
## Brief:       This option is to enable RACE RELAY CMD.
## Usage:       Enable the feature by configuring it as y.
## Path:                middleware/airoha/race_cmd
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_RACE_RELAY_CMD_ENABLE),y)
CFLAGS         += -DMTK_RACE_RELAY_CMD_ENABLE
endif


##
## AIR_AMP_DC_COMPENSATION_ENABLE
## Brief:       This option is to enable AMP DC COMPENSATION.
## Usage:       Enable the feature by configuring it as y.
## Path:                middleware/airoha/sink/src
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_AMP_DC_COMPENSATION_ENABLE),y)
CFLAGS         += -DMTK_AMP_DC_COMPENSATION_ENABLE
endif

##
## DC_COMPENSATION_PARA_ENABLE
## Brief:       Internal use.
## Usage:       Enable the feature by configuring it as y.
## Path:                middleware/MTK/sink/src
## Dependency:  None
## Notice:      This option is to enable parameters of DC compensation of ab1568.
## Relative doc:None
##
AIR_DC_COMPENSATION_PARA_ENABLE  ?= y
ifeq ($(AIR_DC_COMPENSATION_PARA_ENABLE),y)
CFLAGS         += -DDC_COMPENSATION_PARA_ENABLE
endif

##
## AIR_MBEDTLS_CONFIG_FILE
## Brief:       This option is to configure mbedTLS features.
## Usage:       If the value is "*.h", mbedTLS module will use *.h as the configuration file. For example, if its value is "config-vendor-fota-race-cmd.h",
##              config-vendor-fota-race-cmd.h will be used as the configuration file. AIR_MBEDTLS_CONFIG_FILE compile option will be defined. You must also
##              include the /middleware/third_party/mbedtls/module.mk in your Makefile before setting the option to "*.h".
## Path:        middleware/third_party/mbedtls
## Dependency:  LWIP module must be enabled.
## Relative doc:Please refer to internet and open source software guide under the doc folder for more detail.
##
ifneq ($(AIR_MBEDTLS_CONFIG_FILE),)
CFLAGS += -DMBEDTLS_CONFIG_FILE=\\\"$(AIR_MBEDTLS_CONFIG_FILE)\\\"
endif

##
## AIR_ANC_ENABLE
## Brief:       This option is to enable ANC feature.
## Usage:       If the value is "y",  the AIR_ANC_ENABLE option will be defined.
## Path:        middleware/airoha/audio/anc_control_protected/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_ANC_ENABLE),y)
CFLAGS += -DMTK_ANC_ENABLE
CFLAGS += -DMTK_ANC_V2
CFLAGS += -DHAL_AUDIO_ANC_ENABLE
ifeq ($(AIR_BTA_IC_PREMIUM_G3),y)
CFLAGS += -DAIR_ANC_V3
endif
endif

##
## MTK_HYBRID_ANC_ENABLE
## Brief:       This option is to enable support for ANC hybrid mode.
## Usage:       If the value is "y",  the MTK_HYBRID_ANC_ENABLE option will be defined.
## Path:        middleware/airoha/audio/anc_control/
## Dependency:  AIR_ANC_ENABLE
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_ANC_ENABLE),y)
ifeq ($(MTK_HYBRID_ANC_ENABLE),y)
CFLAGS += -DMTK_HYBRID_ANC_ENABLE
endif
endif

## AIR_HYBRID_PT_ENABLE
## Brief:       This option is to enable Hybrid Passthru.
## Usage:       Enable Hybrid Passthru feature by configuring it as y.
##              y : enable Hybrid Passthru feature.
##              n : not enable Hybrid Passthru feature.
## Path:        dsp/prebuilt/middleware/airoha/dspfw/anc/$(IC_TYPE)
## Dependency:  None.
## Notice:      None.
## Realted doc: None.
##
ifeq ($(AIR_HYBRID_PT_ENABLE),y)
CFLAGS += -DAIR_HYBRID_PT_ENABLE
endif

##
## MTK_ANC_BACKUP_STATUS_ENABLE
## Brief:       This option is to enable backup ANC status after power off.
## Usage:       If the value is "y",  the MTK_ANC_BACKUP_STATUS_ENABLE option will be defined.
## Path:        middleware/airoha/audio/anc_control/
## Dependency:  AIR_ANC_ENABLE
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_ANC_ENABLE),y)
ifeq ($(MTK_ANC_BACKUP_STATUS_ENABLE),y)
CFLAGS += -DMTK_ANC_BACKUP_STATUS_ENABLE
endif
endif

##
## MTK_ANC_HOWLING_TURN_OFF_ANC
## Brief:       This option is to disable ANC when howling occurs and meet tolerance condition.
## Usage:       If the value is "y",  the MTK_ANC_HOWLING_TURN_OFF_ANC option will be defined.
## Path:        middleware/airoha/audio/anc_control/
## Dependency:  AIR_ANC_ENABLE
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_ANC_ENABLE),y)
ifeq ($(MTK_ANC_HOWLING_TURN_OFF_ANC),y)
CFLAGS += -DMTK_ANC_HOWLING_TURN_OFF_ANC
endif
endif

##
## AIR_PEQ_ENABLE
## Brief:       This option is to enable PEQ feature.
## Usage:       If the value is "y",  the AIR_PEQ_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
AIR_PEQ_ENABLE ?= $(MTK_PEQ_ENABLE)
ifeq ($(AIR_PEQ_ENABLE),y)
CFLAGS += -DMTK_PEQ_ENABLE
endif

##
## AIR_LINE_IN_PEQ_ENABLE
## Brief:       This option is to enable LINEIN PEQ feature.
## Usage:       If the value is "y",  the AIR_LINE_IN_PEQ_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
AIR_LINE_IN_PEQ_ENABLE ?= $(MTK_LINEIN_PEQ_ENABLE)
ifeq ($(AIR_LINE_IN_PEQ_ENABLE),y)
CFLAGS += -DMTK_LINEIN_PEQ_ENABLE
endif

##
## AIR_ADAPTIVE_EQ_ENABLE
## Brief:       This option is to enable adaptive eq feature.
## Usage:       If the value is "y",  the AIR_ADAPTIVE_EQ_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_ADAPTIVE_EQ_ENABLE),y)
CFLAGS += -DAIR_ADAPTIVE_EQ_ENABLE
endif

##
## AIR_LINE_IN_INS_ENABLE
## Brief:       This option is to enable LINEIN INS feature.
## Usage:       If the value is "y",  the AIR_LINE_IN_INS_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
AIR_LINE_IN_INS_ENABLE ?= $(MTK_LINEIN_INS_ENABLE)
ifeq ($(AIR_LINE_IN_INS_ENABLE),y)
CFLAGS += -DMTK_LINEIN_INS_ENABLE
endif

##
## MTK_AUDIO_LOOPBACK_TEST_ENABLE
## Brief:       This option is to enable AUDIO LOOPBACK TEST feature.
## Usage:       If the value is "y",  the MTK_AUDIO_LOOPBACK_TEST_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_AUDIO_LOOPBACK_TEST_ENABLE),y)
CFLAGS += -DMTK_AUDIO_LOOPBACK_TEST_ENABLE
endif

##
## AIR_AUDIO_EXT_DAC_ENABLE
## Brief:       This option is to determine to use external dac.
## Usage:       Enable the feature by configuring it as y.
## Path:        driver/chip/ab156x
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_AUDIO_EXT_DAC_ENABLE),y)
CFLAGS += -DAIR_AUDIO_EXT_DAC_ENABLE
endif

##
## AIR_BT_CODEC_ENABLED
## Brief:       This option is to enable audio with BT profile. Include A2DP,HFP,LEaudio.
## Usage:       If the value is "y",  the AIR_BT_CODEC_ENABLED option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_BT_CODEC_ENABLED),y)
CFLAGS += -DAIR_BT_CODEC_ENABLED
CFLAGS += -DAIR_HFP_FEATURE_MODE_ENABLE
endif

##
## AIR_RECORD_ENABLE
## Brief:       This option is to enable RECORD middleware feature.
## Usage:       If the value is "y",  the AIR_RECORD_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_RECORD_ENABLE),y)
CFLAGS += -DAIR_RECORD_ENABLE
endif

##
## MTK_RECORD_INTERLEAVE_ENABLE
## Brief:       This option is to enable RECORD 2-mic interleave.
## Usage:       If the value is "y",  the MTK_RECORD_INTERLEAVE_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_RECORD_INTERLEAVE_ENABLE),y)
CFLAGS += -DMTK_RECORD_INTERLEAVE_ENABLE
endif

##
## AIR_ANC_FIT_DETECTION_ENABLE
## Brief:       This option is the type of record format selected middleware feature.
## Usage:       If the value is "y",  the AIR_ANC_FIT_DETECTION_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
AIR_ANC_FIT_DETECTION_ENABLE ?= $(MTK_LEAKAGE_DETECTION_ENABLE)
ifeq ($(AIR_ANC_FIT_DETECTION_ENABLE),y)
ifeq ($(MTK_AWS_MCE_ENABLE),y)
ifeq ($(AIR_ANC_ENABLE),y)
CFLAGS += -DMTK_LEAKAGE_DETECTION_ENABLE
endif
endif
endif

##
## AIR_MP3_CODEC_TASK_DEDICATE_ENABLE
## Brief:       This option is to define MP3 task is always been created.
## Usage:       If the value is "n",  the AIR_MP3_CODEC_TASK_DEDICATE_ENABLE option will not be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_MP3_CODEC_TASK_DEDICATE_ENABLE),n)
else
CFLAGS += -DAIR_MP3_TASK_DEDICATE_ENABLE
endif

##
## AIR_MP3_STEREO_SUPPORT_ENABLE
## Brief:       This option is to define MP3 CODEC support stereo format.
## Usage:       If the value is "y",  the AIR_MP3_STEREO_SUPPORT_ENABLE option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_MP3_STEREO_SUPPORT_ENABLE),n)
else
CFLAGS += -DAIR_MP3_STEREO_SUPPORT_ENABLE
endif

##
## AIR_AIRDUMP_ENABLE
## Brief:       This option is to enable HFP airdump.
## Usage:       If the value is "n",  the AIR_AIRDUMP_ENABLE option will not be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_AIRDUMP_ENABLE),y)
CFLAGS += -DAIR_AIRDUMP_ENABLE
endif

##
## AIR_USER_TRIGGER_FF_ENABLE
## Brief:       This option is for user triggered adaptive FF.
## Usage:       If the value is "n",  the AIR_USER_TRIGGER_FF_ENABLE option will not be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_USER_TRIGGER_FF_ENABLE),y)
ifeq ($(AIR_ANC_ENABLE),y)
CFLAGS += -DAIR_USER_TRIGGER_FF_ENABLE
CFLAGS += -DMTK_USER_TRIGGER_FF_ENABLE
CFLAGS += -DMTK_USER_TRIGGER_ADAPTIVE_FF_V2
endif
endif

##
## AIR_PEQ_WRITE_NVKEY_ENABLE
## Brief:       This option is used to enable PEQ sound_mode request write nvk.
## Usage:       This is an option that is distinguished by chip option.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_PEQ_WRITE_NVKEY_ENABLE),y)
CFLAGS  += -DAIR_PEQ_WRITE_NVKEY_ENABLE
endif

##
## AIR_DUAL_CHIP_MIXING_MODE
## Brief:       This option is used to set the type of dual chip mixing mode.
## Usage:       If this value is "master", the DAIR_DUAL_CHIP_MIXING_MODE_ROLE_MASTER_ENABLE will be defiend. If the value is "slave", the AIR_DUAL_CHIP_MIXING_MODE_ROLE_SLAVE_ENABLE will be defiend
## Path:        None
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_DUAL_CHIP_MIXING_MODE),master)
AIR_DUAL_CHIP_MIXING_MODE_ROLE_MASTER_ENABLE = y
AIR_WIRED_AUDIO_ENABLE = y
AIR_AUDIO_DETACHABLE_MIC_ENABLE = y
endif
ifeq ($(AIR_DUAL_CHIP_MIXING_MODE),slave)
AIR_DUAL_CHIP_MIXING_MODE_ROLE_SLAVE_ENABLE = y
AIR_WIRED_AUDIO_ENABLE = y
endif

ifeq ($(AIR_DUAL_CHIP_MIXING_MODE_ROLE_MASTER_ENABLE),y)
CFLAGS  += -DAIR_DUAL_CHIP_MIXING_MODE_ROLE_MASTER_ENABLE
CFLAGS  += -DAIR_AUDIO_HW_LOOPBACK_ENABLE
CFLAGS  += -DAIR_DUAL_CHIP_NR_ON_MASTER_ENABLE
endif

ifeq ($(AIR_DUAL_CHIP_MIXING_MODE_ROLE_SLAVE_ENABLE),y)
CFLAGS  += -DAIR_DUAL_CHIP_MIXING_MODE_ROLE_SLAVE_ENABLE
CFLAGS  += -DAIR_HWSRC_RX_TRACKING_ENABLE
CFLAGS  += -DAIR_HWSRC_TX_TRACKING_ENABLE
CFLAGS  += -DAIR_DUAL_CHIP_I2S_ENABLE
CFLAGS  += -DAIR_AUDIO_HW_LOOPBACK_ENABLE
endif

##
## MTK_UI_SHELL_MAX_ACTIVITY_COUNT
## Brief:       This option is to set the max activity count in activity stack.
## Usage:       If the value is set in feature option, the macro MTK_UI_SHELL_MAX_ACTIVITY_COUNT will be defined to the value.
## Path:        middleware/airoha/ui_shell
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_UI_SHELL_MAX_ACTIVITY_COUNT),)
CFLAGS += -DMTK_UI_SHELL_MAX_ACTIVITY_COUNT=40
else
CFLAGS += -DMTK_UI_SHELL_MAX_ACTIVITY_COUNT=$(MTK_UI_SHELL_MAX_ACTIVITY_COUNT)
endif

##
## AIR_UPLINK_RATE
## Brief:       This option is to choose the uplink rate.
## Usage:       The valid values are none, 48k.
##              The setting will determine which rate of uplink rate will be used.
##              none    : uplink rate will be handled by scenario itself.
##              48k     : uplink rate will be fixed in 48k Hz.
## Path:        middleware\airoha\audio\bt_codec
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_UPLINK_RATE),48k)
CFLAGS += -DAIR_UL_FIX_SAMPLING_RATE_48K
endif

##
## AIR_UPLINK_RESOLUTION
## Brief:       This option is to fix the uplink DMA resolution.
## Usage:       The valid values are none, 32bit.
##              The setting will determine which resolution of uplink DMA will be used.
##              none    : uplink resolution will be handled by scenario itself.
##              32bit   : uplink resolution will be fixed at 32-bit.
## Path:        middleware\airoha\audio\bt_codec
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_UPLINK_RESOLUTION),32bit)
CFLAGS += -DAIR_UL_FIX_RESOLUTION_32BIT
endif

##
## AIR_DOWNLINK_RATE
## Brief:       This option is to choose the downlink rate.
## Usage:       The valid values are none, 48k, 96k.
##              The setting will determine which rate of downlink rate will be used.
##              none    : downlink rate will be handled by scenario itself.
##              48k     : downlink rate will be fixed in 48k Hz.
##              96k     : downlink rate will be fixed in 96k Hz.
## Path:        middleware\airoha\audio\bt_codec
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_DOWNLINK_RATE),48k)
CFLAGS += -DFIXED_SAMPLING_RATE_TO_48KHZ
endif

ifeq ($(AIR_DOWNLINK_RATE),96k)
CFLAGS += -DAIR_FIXED_DL_SAMPLING_RATE_TO_96KHZ
endif

###############################################################################
##
## The following makefile options are not configurable or only for internal user. They may be removed in the future.

##
## AIR_HEAP_SIZE_GUARD_ENABLE
## Brief:       Internal use.
##
ifeq ($(AIR_HEAP_SIZE_GUARD_ENABLE),y)
ALLFLAGS       += -Wl,-wrap=pvPortMalloc -Wl,-wrap=vPortFree
COM_CFLAGS     += -DMTK_HEAP_SIZE_GUARD_ENABLE
endif

##
## AIR_SUPPORT_HEAP_DEBUG
## Brief:       Internal use.
## Notice:      AIR_SUPPORT_HEAP_DEBUG is a option to show heap status (alocatted or free), and will print debug info if any heap crash or heap use overflow, It's for RD internal development and debug. Default should be disabled.
##
ifeq ($(AIR_SUPPORT_HEAP_DEBUG),y)
COM_CFLAGS         += -DMTK_SUPPORT_HEAP_DEBUG
endif

##
## AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE_ENABLE
## Brief:       Internal use. Enable this option to support multiple microphone.
## Usage:       If the value is "n",  the HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE option will not be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE_ENABLE),y)
CFLAGS += -DHAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
CFLAGS += -DAIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
endif

##
## AIR_AUDIO_MULTIPLE_STREAM_OUT_ENABLE
## Brief:       Internal use.
## Notice:      AIR_AUDIO_MULTIPLE_STREAM_OUT_ENABLE is a option to enable multiple stream out.
##
ifeq ($(AIR_AUDIO_MULTIPLE_STREAM_OUT_ENABLE),y)
CFLAGS += -DAIR_AUDIO_MULTIPLE_STREAM_OUT_ENABLE
endif


##
## LINE_IN_PURE_FOR_AMIC_CLASS_G_HQA
## Brief:       Internal use.
## Usage:       If the value is "y",  the LINE_IN_PURE_FOR_AMIC_CLASS_G_HQA option will be defined.
## Path:        middleware/airoha/audio/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(LINE_IN_PURE_FOR_AMIC_CLASS_G_HQA),y)
CFLAGS += -DLINE_IN_PURE_FOR_AMIC_CLASS_G_HQA
endif

##
## MTK_SUPPORT_HEAP_DEBUG_ADVANCED
## Brief:       Internal use.
## Notice:      MTK_SUPPORT_HEAP_DEBUG_ADVANCED is a option to show heap allocater with 5-nested callgraph info, and will print debug info if any heap crash or heap use overflow, It's for RD internal development and debug. Default should be disabled.
##
ifeq ($(MTK_SUPPORT_HEAP_DEBUG_ADVANCED),y)
COM_CFLAGS         += -DMTK_SUPPORT_HEAP_DEBUG_ADVANCED
COM_CFLAGS         += -funwind-tables
#LDFLAGS            += -Wl,--no-merge-exidx-entries
endif

##
## MTK_BUILD_SMT_LOAD
## Brief:       Internal use.
##
ifeq ($(MTK_BUILD_SMT_LOAD),y)
COM_CFLAGS += -DMTK_BUILD_SMT_LOAD
endif

#
# IC_CONFIG
# DO NOT USE, software not available.
#

##
## MTK_CPU_NUMBER_0
## Brief:       Internal use.
##
ifeq ($(MTK_CPU_NUMBER_0),y)
COM_CFLAGS += -DMTK_CPU_NUMBER_0
COM_CFLAGS += -DMTK_MAX_CPU_NUMBER_2
endif

##
## MTK_EXCEPTION_CONFIG_BY_NVKEY
## Brief:       Internal use. the exception mode can be configured by config tool if this feature is enabled
## Usage:     If the value is "y", the MTK_EXCEPTION_CONFIG_BY_NVKEY compile option will be defined.
## Path:       kernel/service/exception_handler
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_EXCEPTION_CONFIG_BY_NVKEY),y)
COM_CFLAGS += -DMTK_EXCEPTION_CONFIG_BY_NVKEY
endif

##
## MTK_CODE_COVERAGE_ENABLE
## Brief:       Internal use.
##
ifeq ($(MTK_CODE_COVERAGE_ENABLE),y)
AR = $(BINPATH)/arm-none-eabi-cov-ar
CC = $(BINPATH)/arm-none-eabi-cov-gcc
CXX= $(BINPATH)/arm-none-eabi-cov-g++
export GCOV_DIR=$(SOURCE_DIR)
endif

##
## AIR_SWLA_ENABLE
## Brief:       Internal use.
## Usage:     If the value is "y", the AIR_SWLA_ENABLE compile option will be defined. You must also include the gva\kernel\service\module.mk in your Makefile before setting the option to "y".
## Path:       kernel/service
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_SWLA_ENABLE),y)
COM_CFLAGS += -DMTK_SWLA_ENABLE
COM_CFLAGS += -DPRODUCT_VERSION_STR=\"$(PRODUCT_VERSION)\"
endif


##
## MTK_CONFIG_MIC_INTERFACE_ENABLE
## Brief:       Internal use. This option is to support config tool setting MIC interface
## Usage:       If the value is "y",  the MTK_CONFIG_MIC_INTERFACE_ENABLE option will be defined.
## Path:        driver/chip/mt2833/src/hal_audio.c
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(MTK_CONFIG_MIC_INTERFACE_ENABLE),y)
CFLAGS += -DMTK_CONFIG_MIC_INTERFACE_ENABLE
endif

##
## MTK_SENSOR_SOURCE_ENABLE
## Brief:       Internal use.
## Notice:      MTK_SENSOR_SOURCE_ENABLE is a option to support Sensor Source.
##
ifeq ($(MTK_SENSOR_SOURCE_ENABLE),y)
CFLAGS += -DMTK_SENSOR_SOURCE_ENABLE
endif


##
## MTK_AUDIO_PLC_ENABLE
## Brief:       Internal use. This option is to enable Adudio plc.
## Usage:       If the value is "y",  the MTK_AUDIO_PLC_ENABLE option will be defined.
## Path:        middleware/airoha/audio/bt_codec/src/bt_a2dp_codec.c
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_AUDIO_PLC_ENABLE),y)
CFLAGS += -DMTK_AUDIO_PLC_ENABLE
endif

##
## ENABLE_HWSRC_CLKSKEW
## Brief:       Internal use.
## Notice:      ENABLE_HWSRC_CLKSKEW is a option for hwsrc clk skew. Default should always be enabled.
##
ifeq ($(AIR_HWSRC_CLKSKEW_ENABLE),y)
CFLAGS += -DENABLE_HWSRC_CLKSKEW
endif

##
## AIR_HWSRC_IN_STREAM_ENABLE
## Brief:       Internal use.
## Notice:      ENABLE_HWSRC_CLKSKEW is a option for hwsrc clk skew. Default should always be enabled.
##
ifeq ($(AIR_HWSRC_IN_STREAM_ENABLE),y)
CFLAGS += -DAIR_HWSRC_IN_STREAM_ENABLE
endif

##
## MTK_BATTERY_BC1P2_DISABLE
## Brief:       Internal use.
## Notice:      MTK_BATTERY_BC1P2_DISABLE is a option for BC1P2. It would be set according HW IC.
##
ifeq ($(MTK_BATTERY_BC1P2_DISABLE),y)
CFLAGS += -DMTK_BATTERY_BC1P2_DISABLE
endif

##
## AIR_ECNR_1_OR_2_MIC_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ECNR_1_OR_2_MIC_ENABLE is a option for 1 or 2. Default should not be enabled.
##
ifeq ($(AIR_ECNR_1_OR_2_MIC_ENABLE),y)
CFLAGS += -DAIR_ECNR_1_OR_2_MIC_ENABLE
endif

##
## AIR_ECNR_1MIC_INEAR_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ECNR_1MIC_INEAR_ENABLE is a option for 1+1 inear enhancement. Default should not be enabled.
##
ifeq ($(AIR_ECNR_1MIC_INEAR_ENABLE),y)
CFLAGS += -DAIR_ECNR_1MIC_INEAR_ENABLE
endif


##
## AIR_ECNR_2MIC_INEAR_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ECNR_2MIC_INEAR_ENABLE is a option for 1+1 inear enhancement. Default should not be enabled.
##
ifeq ($(AIR_ECNR_2MIC_INEAR_ENABLE),y)
CFLAGS += -DAIR_ECNR_2MIC_INEAR_ENABLE
endif


##
## AIR_3RD_PARTY_NR_ENABLE
## Brief:       Internal use.
## Notice:      AIR_3RD_PARTY_NR_ENABLE is a option for AIR_3RD_PARTY_NR_ENABLE. Default should not be enabled.
##
ifeq ($(AIR_3RD_PARTY_NR_ENABLE),y)
CFLAGS += -DAIR_3RD_PARTY_NR_ENABLE
endif


##
## AIR_ECNR_PREV_PART_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ECNR_PREV_PART_ENABLE is a option to support split ECNR function.
##
ifeq ($(AIR_ECNR_PREV_PART_ENABLE),y)
CFLAGS += -DAIR_ECNR_PREV_PART_ENABLE
endif

##
## AIR_ULL_ECNR_PREV_PART_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ULL_ECNR_PREV_PART_ENABLE is a option to support split ECNR function.
##
ifeq ($(AIR_ULL_ECNR_PREV_PART_ENABLE),y)
CFLAGS += -DAIR_ULL_ECNR_PREV_PART_ENABLE
endif

##
## AIR_ECNR_POST_PART_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ECNR_POST_PART_ENABLE is a option to support split ECNR function.
##
ifeq ($(AIR_ECNR_POST_PART_ENABLE),y)
CFLAGS += -DAIR_ECNR_POST_PART_ENABLE
endif

##
## AIR_ULL_ECNR_POST_PART_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ULL_ECNR_POST_PART_ENABLE is a option to support split ECNR function.
##
ifeq ($(AIR_ULL_ECNR_POST_PART_ENABLE),y)
CFLAGS += -DAIR_ULL_ECNR_POST_PART_ENABLE
endif

##
## AIR_BT_UL_BLE_SWB_ENABLE
## Brief:       Internal use.
## Notice:      AIR_BT_UL_BLE_SWB_ENABLE is a option for AIR_BT_UL_BLE_SWB_ENABLE. Default should not be enabled.
##
ifeq ($(AIR_BT_BLE_UL_SWB_ENABLE),y)
AIR_BT_BLE_SWB_ENABLE = y
AIR_BT_ULL_SWB_ENABLE = y
ifeq ($(AIR_BT_BLE_SWB_ENABLE),y)
CFLAGS += -DAIR_BT_BLE_SWB_ENABLE
endif
ifeq ($(AIR_BT_ULL_SWB_ENABLE),y)
CFLAGS += -DAIR_BT_ULL_SWB_ENABLE
endif
endif

##
## MTK_SLT_AUDIO_HW
## Brief:       Internal use.
## Notice:      MTK_SLT_AUDIO_HW is a option for MTK_SLT_AUDIO_HW. Default should not be enabled.
##
ifeq ($(MTK_SLT_AUDIO_HW),y)
CFLAGS += -DMTK_SLT_AUDIO_HW
endif

##
## MTK_BT_DEVICE_MANAGER_DB_EXTENSION
## Brief:       This option is to enable bluetooth device manager data base extension.
## Usage:       None
## Path:        middleware/airoha/bluetooth_service/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
CFLAGS += -DMTK_BT_DEVICE_MANAGER_DB_EXTENSION

##
## AIR_AUDIO_HW_IO_CONFIG_ENHANCE_ENABLE
## Brief:       Internal use.
## Notice:      AIR_AUDIO_HW_IO_CONFIG_ENHANCE_ENABLE is a option for hardware IO config enhance version. Default should be enabled.
##
AIR_AUDIO_HW_IO_CONFIG_ENHANCE_ENABLE ?= $(MTK_AUDIO_HW_IO_CONFIG_ENHANCE)
ifeq ($(AIR_AUDIO_HW_IO_CONFIG_ENHANCE_ENABLE),y)
CFLAGS += -DMTK_AUDIO_HW_IO_CONFIG_ENHANCE
endif

##
## MTK_AUDIO_DUMP_BY_SPDIF_ENABLE
## Brief:       Internal use.
## Notice:      MTK_AUDIO_DUMP_BY_SPDIF_ENABLE is an option to support audio dump over SPDIF interface.
ifeq ($(MTK_AUDIO_DUMP_BY_SPDIF_ENABLE),y)
CFLAGS += -DMTK_AUDIO_DUMP_BY_SPDIF_ENABLE
endif

##
## AIR_AUDIO_GAIN_SETTING_ENHANCE_ENABLE
## Brief:       Internal use.
## Notice:      AIR_AUDIO_GAIN_SETTING_ENHANCE_ENABLE is a option for analog gain and digital gain enhance version. Default should be enabled.
##
AIR_AUDIO_GAIN_SETTING_ENHANCE_ENABLE ?= $(MTK_AUDIO_GAIN_SETTING_ENHANCE)
ifeq ($(AIR_AUDIO_GAIN_SETTING_ENHANCE_ENABLE),y)
CFLAGS += -DMTK_AUDIO_GAIN_SETTING_ENHANCE
endif

##
## AIR_AUDIO_DETACHABLE_MIC_ENABLE
## Brief:       Internal use. This option is for voice detachable mic.
## Usage:       If the value is "n",  the AIR_AUDIO_DETACHABLE_MIC_ENABLE option will not be defined.
## Path:        middleware/airoha/audio_manager/
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_AUDIO_DETACHABLE_MIC_ENABLE),y)
CFLAGS += -DAIR_AUDIO_DETACHABLE_MIC_ENABLE
endif


##
## AIR_WIRED_AUDIO_ENABLE
## Brief:       Internal use. This option is for voice detachable mic.
## Usage:       If the value is "n",  the AIR_WIRED_AUDIO_ENABLE option will not be defined.
## Path:        middleware/airoha/audio/audio_transmitter
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_WIRED_AUDIO_ENABLE), y)
  CFLAGS  += -DAIR_WIRED_AUDIO_ENABLE
endif

##
## MTK_ANC_SURROUND_MONITOR_ENABLE
## Brief:       Internal use.
## Notice:      MTK_ANC_SURROUND_MONITOR_ENABLE is a option to support ANC surround monitor functions.
##
ifeq ($(AIR_ANC_ENABLE),y)
ifeq ($(MTK_ANC_SURROUND_MONITOR_ENABLE),y)
CFLAGS += -DMTK_ANC_SURROUND_MONITOR_ENABLE
endif
endif

##
## AIR_ANC_WIND_DETECTION_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ANC_WIND_DETECTION_ENABLE is a option to support wind detection to suppress noise when ANC on.
##
ifeq ($(AIR_ANC_ENABLE),y)
ifeq ($(AIR_ANC_WIND_NOISE_DETECTION_ENABLE),y)
CFLAGS += -DAIR_ANC_WIND_DETECTION_ENABLE
MTK_ANC_SURROUND_MONITOR_ENABLE = y
CFLAGS += -DMTK_ANC_SURROUND_MONITOR_ENABLE
endif
endif

##
## AIR_ANC_USER_UNAWARE_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ANC_USER_UNAWARE_ENABLE is a option to get better noise cancellation when ANC on.
##
ifeq ($(AIR_ANC_ENABLE),y)
ifeq ($(AIR_ANC_USER_UNAWARE_ENABLE),y)
MTK_ANC_SURROUND_MONITOR_ENABLE = y
AIR_AUDIO_TRANSMITTER_ENABLE = y
CFLAGS += -DAIR_ANC_USER_UNAWARE_ENABLE
CFLAGS += -DMTK_ANC_SURROUND_MONITOR_ENABLE
CFLAGS += -DAIR_AUDIO_TRANSMITTER_ENABLE
endif
endif

## AIR_ANC_ENVIRONMENT_DETECTION_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ANC_ENVIRONMENT_DETECTION_ENABLE
##
ifeq ($(AIR_ANC_ENABLE),y)
ifeq ($(AIR_ANC_ENVIRONMENT_DETECTION_ENABLE),y)
MTK_ANC_SURROUND_MONITOR_ENABLE = y
AIR_AUDIO_TRANSMITTER_ENABLE = y
CFLAGS += -DAIR_ANC_ENVIRONMENT_DETECTION_ENABLE
CFLAGS += -DMTK_ANC_SURROUND_MONITOR_ENABLE
CFLAGS += -DAIR_AUDIO_TRANSMITTER_ENABLE
endif
endif

##
## AIR_LIMIT_TZ_ENABLE
## Brief:       Internal use. This option is to switch all in security or limit trust zone.
## Usage:       The valid values are y,n.
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_LIMIT_TZ_ENABLE),y)
COM_CFLAGS += -DAIR_LIMIT_TZ_ENABLE
endif

##
## AIR_HWSRC_TX_TRACKING_ENABLE
## Brief:       Internal use.
## Notice:      AIR_HWSRC_TX_TRACKING_ENABLE is a option to enable i2s slave tx hwsrc tracking mode.
##
ifeq ($(AIR_HWSRC_TX_TRACKING_ENABLE),y)
CFLAGS += -DAIR_HWSRC_TX_TRACKING_ENABLE
endif

##
## AIR_HWSRC_RX_TRACKING_ENABLE
## Brief:       Internal use.
## Notice:      AIR_HWSRC_RX_TRACKING_ENABLE is a option to enable i2s slave rx hwsrc tracking mode.
##
ifeq ($(AIR_HWSRC_RX_TRACKING_ENABLE),y)
CFLAGS += -DAIR_HWSRC_RX_TRACKING_ENABLE
endif

##
## AIR_DUAL_CHIP_I2S_ENABLE
## Brief:       Internal use.
## Notice:      AIR_DUAL_CHIP_I2S_ENABLE is a option to enable i2s of dual chip.
##
ifeq ($(AIR_DUAL_CHIP_I2S_ENABLE),y)
CFLAGS += -DAIR_DUAL_CHIP_I2S_ENABLE
endif

##
## AIR_AUDIO_HW_LOOPBACK_ENABLE
## Brief:       Internal use.
## Notice:      AIR_AUDIO_HW_LOOPBACK_ENABLE is a option to enable hordware loopback function.
##
ifeq ($(AIR_AUDIO_HW_LOOPBACK_ENABLE),y)
CFLAGS += -DAIR_AUDIO_HW_LOOPBACK_ENABLE
endif

##
## AIR_DUAL_CHIP_NR_ON_MASTER_ENABLE
## Brief:       Internal use.
## Notice:      AIR_DUAL_CHIP_NR_ON_MASTER_ENABLE is a option to enabled MASTER NR.
##
ifeq ($(AIR_DUAL_CHIP_NR_ON_MASTER_ENABLE),y)
CFLAGS += -DAIR_DUAL_CHIP_NR_ON_MASTER_ENABLE
endif

##
## AIR_CPU_SECURITY_MODE
## Brief:       Internal use. This option is determine build in security world or none security world.
## Usage:       The valid values are s,ns.
## Dependency:  None
## Notice:      None
##
ifeq ($(AIR_CPU_SECURITY_MODE),s)
COM_CFLAGS += -DAIR_CPU_IN_SECURITY_MODE
else
#COM_CFLAGS += -DAIR_CPU_IN_NON_SECURITY_MODE
endif

##
## AIR_GAMING_MODE_DONGLE_LINE_IN_ENABLE
## Brief:       Internal use.
## Notice:      AIR_GAMING_MODE_DONGLE_LINE_IN_ENABLE is a option to to enable i2s in on dongle.
## Dependency:  AIR_GAMING_MODE_DONGLE_ENABLE
ifeq ($(AIR_GAMING_MODE_DONGLE_LINE_IN_ENABLE), y)
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_LINE_IN_ENABLE
endif

##
## AIR_GAMING_MODE_DONGLE_LINE_OUT_ENABLE
## Brief:       Internal use.
## Notice:      AIR_GAMING_MODE_DONGLE_LINE_OUT_ENABLE is a option to to enable i2s in on dongle.
## Dependency:  AIR_GAMING_MODE_DONGLE_ENABLE
ifeq ($(AIR_GAMING_MODE_DONGLE_LINE_OUT_ENABLE), y)
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_LINE_OUT_ENABLE
endif

##
## AIR_GAMING_MODE_DONGLE_I2S_IN_ENABLE
## Brief:       Internal use.
## Notice:      AIR_GAMING_MODE_DONGLE_I2S_IN_ENABLE is a option to to enable i2s in on dongle.
## Dependency:  AIR_GAMING_MODE_DONGLE_ENABLE
ifeq ($(AIR_GAMING_MODE_DONGLE_I2S_IN_ENABLE), y)
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_I2S_IN_ENABLE
endif


##
## AIR_REPLACE_NVDM_WITH_NVKEY
## Brief:       Internal use.
## Notice:      AIR_REPLACE_NVDM_WITH_NVKEY is a option to enable replace nvdm items with nvkey items.
## Dependency:  AIR_NVDM_ENABLE
ifeq ($(AIR_REPLACE_NVDM_WITH_NVKEY), y)
COM_CFLAGS += -DAIR_REPLACE_NVDM_WITH_NVKEY
endif

##
## AIR_ADVANCED_PASSTHROUGH_ENABLE
## Brief:       Internal use.
## Notice:      AIR_ADVANCED_PASSTHROUGH_ENABLE is a option to support advanced passthrough when ANC on.
##
ifeq ($(AIR_ADVANCED_PASSTHROUGH_ENABLE),y)
AIR_PSAP_LIB = $(SOURCE_DIR)/prebuilt/$(MIDDLEWARE_PROPRIETARY)/psap/
ifneq ($(wildcard $(AIR_PSAP_LIB)),)
CFLAGS += -DAIR_ADVANCED_PASSTHROUGH_ENABLE
AIR_UL_FIX_SAMPLING_RATE_48K = y
CFLAGS += -DAIR_UL_FIX_SAMPLING_RATE_48K
else
AIR_ADVANCED_PASSTHROUGH_ENABLE := n
endif
endif

# This option is to choose the type of dongle afe in type. Default setting is line in + i2s slv in.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
#                  NONE                : not support afe in.
#                  LINE_IN             : Only support line in.
#                  I2S_MST_IN          : Only support i2s master in.
#                  I2S_SLV_IN          : Only support i2s slave in.
#                  LINE_IN_I2S_MST_IN  : Support line in and i2s master in, but cann't playback at the same time.
#                  LINE_IN_I2S_SLV_IN  : Support line in and i2s slave in, but cann't playback at the same time.
ifeq ($(AIR_ULL_AUDIO_V2_DONGLE_ENABLE),y)
ifeq ($(AIR_DONGLE_AFE_IN_TYPE), NONE)
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), LINE_IN)
AIR_GAMING_MODE_DONGLE_V2_LINE_IN_ENABLE := y
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_LINE_IN_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), I2S_MST_IN)
AIR_GAMING_MODE_DONGLE_V2_I2S_MST_IN_ENABLE := y
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_I2S_MST_IN_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), I2S_SLV_IN)
AIR_GAMING_MODE_DONGLE_V2_I2S_SLV_IN_ENABLE := y
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_I2S_SLV_IN_ENABLE
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_I2S_SLV_IN_TRACKING_VDMA_MODE_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), LINE_IN_I2S_MST_IN)
AIR_GAMING_MODE_DONGLE_V2_LINE_IN_ENABLE := y
AIR_GAMING_MODE_DONGLE_V2_I2S_MST_IN_ENABLE := y
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_LINE_IN_ENABLE
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_I2S_MST_IN_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), LINE_IN_I2S_SLV_IN)
AIR_GAMING_MODE_DONGLE_V2_LINE_IN_ENABLE := y
AIR_GAMING_MODE_DONGLE_V2_I2S_SLV_IN_ENABLE := y
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_LINE_IN_ENABLE
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_I2S_SLV_IN_ENABLE
COM_CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_I2S_SLV_IN_TRACKING_VDMA_MODE_ENABLE
endif
endif

ifeq ($(AIR_LE_AUDIO_DONGLE_ENABLE),y)
ifeq ($(AIR_DONGLE_AFE_IN_TYPE), NONE)
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), LINE_IN)
AIR_BLE_AUDIO_DONGLE_LINE_IN_ENABLE := y
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_LINE_IN_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), I2S_MST_IN)
AIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE := y
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), I2S_SLV_IN)
AIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE := y
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_I2S_IN_TRACKING_VDMA_MODE_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), LINE_IN_I2S_MST_IN)
AIR_BLE_AUDIO_DONGLE_LINE_IN_ENABLE := y
AIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE  := y
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_LINE_IN_ENABLE
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_IN_TYPE), LINE_IN_I2S_SLV_IN)
AIR_BLE_AUDIO_DONGLE_LINE_IN_ENABLE := y
AIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE  := y
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_LINE_IN_ENABLE
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_I2S_IN_ENABLE
COM_CFLAGS += -DAIR_BLE_AUDIO_DONGLE_I2S_IN_TRACKING_VDMA_MODE_ENABLE
endif
endif

##
## AIR_SILENCE_DETECTION_ENABLE
## Brief:       Internal use.
## Notice:      AIR_SILENCE_DETECTION_ENABLE is a option to enabled silence detection feature.
##
ifeq ($(AIR_AUDIO_SILENCE_DETECTION_ENABLE),y)
AIR_SILENCE_DETECTION_ENABLE = y
CFLAGS += -DAIR_SILENCE_DETECTION_ENABLE
endif
ifeq ($(AIR_SILENCE_DETECTION_ENABLE),y)
CFLAGS += -DAIR_SILENCE_DETECTION_ENABLE
endif

# This option is to choose the type of dongle afe out type. Default setting is line out + i2s slv out.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
#                  NONE                : not support afe out.
#                  LINE_OUT             : Only support line out.
#                  I2S_MST_OUT          : Only support i2s master out.
#                  I2S_SLV_OUT          : Only support i2s slave out.
#                  LINE_OUT_I2S_MST_OUT  : Support line in and i2s master out at the same time.
#                  LINE_OUT_I2S_SLV_OUT  : Support line in and i2s slave out at the same time.
ifeq ($(AIR_DONGLE_AFE_OUT_TYPE), NONE)
endif

ifeq ($(AIR_DONGLE_AFE_OUT_TYPE), LINE_OUT)
CFLAGS += -DAIR_DONGLE_LINE_OUT_ENABLE
ifeq ($(AIR_ULL_AUDIO_V2_DONGLE_ENABLE),y)
AIR_GAMING_MODE_DONGLE_V2_LINE_OUT_ENABLE := y
CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_LINE_OUT_ENABLE
endif
endif

ifeq ($(AIR_DONGLE_AFE_OUT_TYPE), I2S_MST_OUT)
CFLAGS += -DAIR_DONGLE_I2S_MST_OUT_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_OUT_TYPE), I2S_SLV_OUT)
CFLAGS += -DAIR_DONGLE_I2S_SLV_OUT_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_OUT_TYPE), LINE_OUT_I2S_MST_OUT)
CFLAGS += -DAIR_DONGLE_LINE_OUT_ENABLE
ifeq ($(AIR_ULL_AUDIO_V2_DONGLE_ENABLE),y)
AIR_GAMING_MODE_DONGLE_V2_LINE_OUT_ENABLE := y
CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_LINE_OUT_ENABLE
endif
CFLAGS += -DAIR_DONGLE_I2S_MST_OUT_ENABLE
endif

ifeq ($(AIR_DONGLE_AFE_OUT_TYPE), LINE_OUT_I2S_SLV_OUT)
CFLAGS += -DAIR_DONGLE_LINE_OUT_ENABLE
ifeq ($(AIR_ULL_AUDIO_V2_DONGLE_ENABLE),y)
AIR_GAMING_MODE_DONGLE_V2_LINE_OUT_ENABLE := y
CFLAGS += -DAIR_GAMING_MODE_DONGLE_V2_LINE_OUT_ENABLE
endif
CFLAGS += -DAIR_DONGLE_I2S_SLV_OUT_ENABLE
endif

##
## AIR_BT_AUDIO_DONGLE_ENABLE
## Brief:       Internal use.
## Notice:      AIR_BT_AUDIO_DONGLE_ENABLE is a option to to enable bt source dongle.
## Dependency:  AIR_BT_SOURCE_ENABLE should be set to y.
ifeq ($(AIR_BT_AUDIO_DONGLE_ENABLE), y)
COM_CFLAGS += -DAIR_BT_AUDIO_DONGLE_ENABLE
COM_CFLAGS += -DAIR_BT_AUDIO_DONGLE_USB_ENABLE
endif

##
## AIR_RECORD_ADVANCED_ENABLE
## Brief:       Internal use. This option is for advanced record.
## Usage:       If the value is "n",  the AIR_RECORD_ADVANCED_ENABLE option will not be defined.
## Path:        middleware/airoha/audio/audio_transmitter
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_RECORD_ADVANCED_ENABLE), y)
  CFLAGS  += -DAIR_RECORD_ADVANCED_ENABLE
endif

##
## AIR_LD_NR_ENABLE
## Brief:       Internal use. This option is for advanced record.
## Usage:       If the value is "n",  the AIR_LD_NR_ENABLE option will not be defined.
## Path:        middleware/airoha/audio_manager
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_LD_NR_ENABLE), y)
  CFLAGS  += -DAIR_LD_NR_ENABLE
endif

##
## AIR_CUSTOMIZED_BL_REGION_ENABLE
## Brief:       Internal use. This option is to enable customized region in bootloader
## Usage:       Enable the feature by configuring it as y
## Dependency:  None
## Notice:      None
## Relative doc:None
##
ifeq ($(AIR_CUSTOMIZED_BL_REGION_ENABLE),y)
CFLAGS += -DAIR_CUSTOMIZED_BL_REGION_ENABLE
endif

###############################################################################

#Incldue Path
COM_CFLAGS += -I$(SOURCE_DIR)/middleware/third_party/mbedtls/include
COM_CFLAGS += -I$(SOURCE_DIR)/middleware/third_party/mbedtls/configs

# Include the skip warning header file.
COM_CFLAGS += -I$(SOURCE_DIR)/config/chip/ab156x
# Include the third party header file.
COM_CFLAGS += -I$(SOURCE_DIR)/config/chip/ab156x/inc

CFLAGS     += -std=gnu99 $(COM_CFLAGS)
CXXFLAGS   += -std=c++11 $(COM_CFLAGS)
