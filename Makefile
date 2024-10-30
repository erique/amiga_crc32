# make && vamos crc32_test && echo -n "crc32     = " && crc32 crc.bin

VBCC	?= ./tools/vbcc
NDK 	?= ./tools/ndk32

export PATH := $(VBCC)/bin:$(PATH)
export VBCC

AS		= vasmm68k_mot
CC		= vc
LD		= vlink

ASFLAGS		:= -quiet -Fhunk -kick1hunks -nosym -m68060 -showopt -I$(NDK)/Include_I
CFLAGS		:= +kick13 -O3 -size -cpu=68060 -c99 -k -sc  -I$(NDK)/Include_H -warnings-as-errors

TARGET		:= crc32_test
OBJECTS		:= main.o crc_c.o crc_asm.o
INCLUDE 	:= $(wildcard *.h) $(wildcard *.s)

.EXPORT_ALL_VARIABLES:

.PHONY: all clean

all: $(TARGET)
	ls -al $(TARGET)

clean:
	rm -f $(TARGET) $(OBJECTS) $(OBJECTS:.o=.asm) *.txt crc.bin

$(TARGET) : $(OBJECTS) Makefile
	@echo $@
	@PATH="$(PATH)" $(CC) $(CFLAGS) $(OBJECTS) -o $@

%.o: %.c $(INCLUDE) Makefile
	@echo $@
	@PATH="$(PATH)" $(CC) $(CFLAGS) -c $< -o $@

%.o: %.s Makefile
	@echo $@
	@PATH="$(PATH)" $(AS) $< -o $@ -L $<.txt $(ASFLAGS)
