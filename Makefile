#Directory
PROJ_DIR = .
OS_DIR = $(PROJ_DIR)/NXP/MCIMX6UL-EVK/Ping/OS3
APP_DIR = $(PROJ_DIR)/NXP/MCIMX6UL-EVK/Ping/
MICRIUM_SOFT_DIR = $(PROJ_DIR)/Micrium/Software
OUTPUT = $(PROJ_DIR)/output

#Include
INC+= -I $(MICRIUM_SOFT_DIR)/uC-TCPIP 
INC+= -I $(APP_DIR)
INC+= -I $(OS_DIR)
INC+= -I $(MICRIUM_SOFT_DIR)/uC-LIB
INC+= -I $(MICRIUM_SOFT_DIR)/uC-DHCPc
INC+= -I $(MICRIUM_SOFT_DIR)/uC-CPU
INC+= -I $(MICRIUM_SOFT_DIR)/uC-CPU/ARM-Cortex-A/ARMv7-A/GNU
INC+= -I $(MICRIUM_SOFT_DIR)/uC-Common
INC+= -I $(MICRIUM_SOFT_DIR)/uCOS-III/
INC+= -I $(MICRIUM_SOFT_DIR)/uCOS-III/Source
INC+= -I $(MICRIUM_SOFT_DIR)/uCOS-III/Ports/ARM-Cortex-A/ARMv7-A/GNU
INC+= -I $(PROJ_DIR)/NXP/BSP/MCIMX6UL-EVK

#Rules
%.o: %.c
	@mkdir -p $(OUTPUT)/obj
	$(CC) $(CFLAGS) -o $(OUTPUT)/obj/$(notdir $@) -c $<

%o: %.S
	@mkdir -p $(OUTPUT)/obj
	$(CC) $(CFLAGS) -o $(OUTPUT)/obj/$(notdir $@) -c $<

#Source
SRC= $(shell find . -name *.c)

SRCS+= $(MICRIUM_SOFT_DIR)/uC-CPU/ARM-Cortex-A/ARMv7-A/GNU/cpu_a.S
SRCS+= $$(MICRIUM_SOFT_DIR)/uCOS-III/Ports/ARM-Cortex-A/ARMv7-A/GNU/os_cpu_a_vfp-none.S


OBJS= $(SRC:.c=.o)
OBJSS= $(SRCS:.S=.o)

#Command
CC = arm-linux-gnueabi-gcc

CFLAGS = -march=armv7ve -mcpu=cortex-a7 -W -Wall -ansi $(INC)
LDFLAGS = -pthread
DEFAULT = main

all: $(DEFAULT)

main: $(OBJS)
	@mkdir -p $(OUTPUT)
	$(CC) $(LDFLAGS) $(CFLAGS) $(INC) -o main.elf $(OUTPUT)/obj/*

clean:
	$(shell rm -rf $(OUTPUT))


