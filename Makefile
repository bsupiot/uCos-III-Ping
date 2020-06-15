TOOLCHAIN = GNU
ARCH = ARM-Cortex-A
SUBARCH = ARMv7-A
PHY = Generic
MAC = MACNet

PWD = $(shell pwd)

#Directory

PROJ_DIR = .
MICRIUM_SOFT_DIR = $(PROJ_DIR)/Micrium/Software

UCOS_DIR = $(MICRIUM_SOFT_DIR)/uCOS-III
CPU_MODULE = $(MICRIUM_SOFT_DIR)/uC-CPU
TCPIP_MODULE = $(MICRIUM_SOFT_DIR)/uC-TCPIP
DHCP_MODULE = $(MICRIUM_SOFT_DIR)/uC-DHCPc
LIB_MODULE = $(MICRIUM_SOFT_DIR)/uC-LIB
COMMON_MODULE = $(MICRIUM_SOFT_DIR)/uC-Common

IPv4_DIR = $(TCPIP_MODULE)/IP/IPv4
IPv6_DIR = $(TCPIP_MODULE)/IP/IPv6
IF_DIR = $(TCPIP_MODULE)/IF
PHY_DIR = $(TCPIP_MODULE)/Dev/Ether/PHY/$(PHY)
MAC_DIR = $(TCPIP_MODULE)/Dev/Ether/$(MAC)

APP_DIR = $(PROJ_DIR)/NXP/MCIMX6UL-EVK/Ping
APP_OS_DIR = $(APP_DIR)/OS3
BSP_DIR = $(PROJ_DIR)/NXP/BSP

DRIVERS_DIR = $(PROJ_DIR)/drivers

KAL = $(COMMON_MODULE)/KAL/uCOS-III/kal.c
BSP_INT = $(BSP_DIR)/Interrupts/bsp_int_armv7a_gicv2.c

OUTPUT = $(PROJ_DIR)/output

#Include
INC+= -I $(TCPIP_MODULE) 
INC+= -I $(APP_DIR)
INC+= -I $(APP_OS_DIR)
INC+= -I $(LIB_MODULE)
INC+= -I $(DHCP_MODULE)
INC+= -I $(CPU_MODULE)
INC+= -I $(CPU_MODULE)/$(ARCH)/$(SUBARCH)/$(TOOLCHAIN)
INC+= -I $(COMMON_MODULE)
INC+= -I $(UCOS_DIR)
INC+= -I $(UCOS_DIR)/Source
INC+= -I $(UCOS_DIR)/Ports/$(ARCH)/$(SUBARCH)/$(TOOLCHAIN)
INC+= -I $(BSP_DIR)/MCIMX6UL-EVK
INC+= -I $(DRIVERS_DIR)
INC+= -I ./CORTEXA/Include
INC+= -I ./CMSIS/Include


#Rules
%.o: %.c
	echo $(SRC)
	@mkdir -p $(OUTPUT)/obj
	$(CC) $(CFLAGS) -o $(OUTPUT)/obj/$(notdir $@) -c $<

%.o: %.S
	@mkdir -p $(OUTPUT)/obj
	$(CC) $(CFLAGS) -o $(OUTPUT)/obj/$(notdir $@) -c $<

#Source	
SRC+= $(addprefix $(TCPIP_MODULE)/Source/, 	$(shell cd $(TCPIP_MODULE)/Source/;	ls | grep -e '\.c'))
SRC+= $(addprefix $(IF_DIR)/, 				$(shell cd $(IF_DIR);				ls | grep -e '\.c'))
SRC+= $(addprefix $(PHY_DIR)/, 				$(shell cd $(PHY_DIR);				ls | grep -e '\.c'))
SRC+= $(addprefix $(MAC_DIR)/, 				$(shell cd $(MAC_DIR);				ls | grep -e '\.c'))
SRC+= $(addprefix $(IPv4_DIR)/, 			$(shell cd $(IPv4_DIR);				ls | grep -e '\.c'))
SRC+= $(addprefix $(IPv6_DIR)/, 			$(shell cd $(IPv6_DIR);				ls | grep -e '\.c'))
SRC+= $(addprefix $(APP_DIR)/, 				$(shell cd $(APP_DIR); 				ls | grep -e '\.c'))
SRC+= $(addprefix $(APP_OS_DIR)/,			$(shell cd $(APP_OS_DIR);			ls | grep -e '\.c'))
SRC+= $(addprefix $(LIB_MODULE)/, 			$(shell cd $(LIB_MODULE); 			ls | grep -e '\.c'))
SRC+= $(addprefix $(DHCP_MODULE)/Source/, 	$(shell cd $(DHCP_MODULE)/Source;	ls | grep -e '\.c'))
SRC+= $(addprefix $(DHCP_MODULE)/OS/uCOS-III/, 		$(shell cd $(DHCP_MODULE)/OS/uCOS-III;		ls | grep -e '\.c'))
SRC+= $(addprefix $(CPU_MODULE)/, 			$(shell cd $(CPU_MODULE); 			ls | grep -e '\.c'))
SRC+= $(addprefix $(COMMON_MODULE)/, 		$(shell cd $(COMMON_MODULE); 		ls | grep -e '\.c'))
SRC+= $(addprefix $(UCOS_DIR)/, 			$(shell cd $(UCOS_DIR); 			ls | grep -e '\.c'))
SRC+= $(addprefix $(UCOS_DIR)/Source/, 		$(shell cd $(UCOS_DIR)/Source; 		ls | grep -e '\.c'))

SRC+= $(addprefix $(UCOS_DIR)/Ports/$(ARCH)/$(SUBARCH)/, 		$(shell cd $(UCOS_DIR)/Ports/$(ARCH)/$(SUBARCH); 	ls | grep -e '\.c'))
SRC+= $(addprefix $(BSP_DIR)/MCIMX6UL-EVK/, $(shell cd $(BSP_DIR)/MCIMX6UL-EVK; ls | grep -e '\.c'))
SRC+= $(addprefix $(DRIVERS_DIR)/uart/, $(shell cd $(DRIVERS_DIR)/uart; ls | grep -e '\.c'))
SRC+= $(KAL)
SRC+= $(BSP_INT)


SRCS+= $(MICRIUM_SOFT_DIR)/uC-CPU/ARM-Cortex-A/ARMv7-A/GNU/cpu_a.S
SRCS+= $(MICRIUM_SOFT_DIR)/uCOS-III/Ports/ARM-Cortex-A/ARMv7-A/GNU/os_cpu_a_vfp-none.S
SRCS+= ./startup.S


OBJS= $(SRC:.c=.o)
OBJSS= $(SRCS:.S=.o)

#Command
CC = arm-none-eabi-gcc

CFLAGS = -mcpu=cortex-a7 -W -Wall -ansi $(INC) -std=gnu89 -g -D CPU_MCIMX6G2CVK05
LDFLAGS = --specs=nosys.specs -T linker.ld -g
DEFAULT = main

all: $(DEFAULT)

main: $(OBJS) $(OBJSS)
	@mkdir -p $(OUTPUT)
	$(CC) $(LDFLAGS) $(CFLAGS) $(INC) -o main.elf $(OUTPUT)/obj/*

clean:
	$(shell rm -rf $(OUTPUT))
	$(shell rm -rf ./main.elf)


