.PHONY: all clean

####################################################################
# Definitions                                                      #
####################################################################
PROJECTNAME = portal

CA       = ca65
LD       = ld65
PREPROCESS = preprocessor/preprocess.py

RM       = rm -rf
L_SCRIPT = linker_config.cfg

BUILD_DIR = build
DBG_OUTPUT = symbols.txt

SRC = \
	main.asm \

METASRC = \
	metasrc/bounce_sound.json

OBJECTS = \
$(addprefix $(BUILD_DIR)/, $(notdir $(SRC:.asm=.o))) \
$(addprefix $(BUILD_DIR)/, $(notdir $(METASRC:.json=.o)))


SRC_PATHS = $(sort $(dir $(SRC)))
METASRC_PATHS = $(sort $(dir $(METASRC)))


vpath %.asm $(SRC_PATHS)
vpath %.json $(METASRC_PATHS)

####################################################################
# Rules                                                            #
####################################################################


all: clean
all: $(BUILD_DIR)
all: $(PROJECTNAME).nes
all: execute_tests 

$(BUILD_DIR):
	$(shell mkdir $(BUILD_DIR))


# Create asm source files from meta sources
%.asm: %.json
	$(PREPROCESS) -o $@ $<

# Create objects from asm source file
build/%.o: %.asm 
	$(PREPROCESS) --src -o $(BUILD_DIR)/$(notdir $<) $<
	$(CA) --debug-info -U -I $(shell pwd) -o $(BUILD_DIR)/$(notdir $@) $(BUILD_DIR)/$(notdir $<)

# Link
$(PROJECTNAME).nes: $(OBJECTS)
	$(LD) --dbgfile $(DBG_OUTPUT) -o $(PROJECTNAME).nes -C $(L_SCRIPT) $(OBJECTS)

clean:
	$(RM) $(BUILD_DIR)

execute_tests:
	/bin/bash 6502_test_executor/execute_tests.sh tests
