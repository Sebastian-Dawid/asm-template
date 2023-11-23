DB := lldb
SHELL := sh
ASM := nasm
LD := ld

BUILD_DIR = ./build
BINARY_NAME = main
ARGS =

.DEFAULT_GOAL := help

$(BUILD_DIR)/$(BINARY_NAME): $(BUILD_DIR)/$(BINARY_NAME).o
	$(LD) -m elf_x86_64 -static -o $(BUILD_DIR)/$(BINARY_NAME) $(BUILD_DIR)/$(BINARY_NAME).o

$(BUILD_DIR)/$(BINARY_NAME).o: $(BINARY_NAME).asm
	mkdir -p $(BUILD_DIR)
	$(ASM) -g -f elf64 -F dwarf -o $(BUILD_DIR)/$(BINARY_NAME).o $(BINARY_NAME).asm

.PHONY: clean run debug help

clean:
	rm -rf $(BUILD_DIR)

run: $(BUILD_DIR)/$(BINARY_NAME)
	$(BUILD_DIR)/$(BINARY_NAME) $(ARGS)

debug: $(BUILD_DIR)/$(BINARY_NAME)
	$(DB) $(BUILD_DIR)/$(BINARY_NAME)

help:
	@echo "Usage: make { clean | run | debug | help }"
	@echo "    clean - Remove build artifacts"
	@echo "    run   - Assemble, link and run the program"
	@echo "    debug - Assemble, link and run the program in the debugger"
	@echo "            The default debugger is 'lldb', but can be changed"
	@echo "            by setting 'make debug DB=<your preferred debugger>'"
	@echo "    help  - Show this message"
