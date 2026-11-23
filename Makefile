# The Complete Linux Shell & Bash Scripting Handbook — build commands
# Usage: make            build the PDF into build/
#        make watch      rebuild automatically while you edit
#        make regen      regenerate src/body.typ from markdown/body.md (needs pandoc)
#        make clean      delete the build/ folder

TYPST      ?= typst
FONT_FLAGS := --font-path fonts --ignore-system-fonts
MAIN       := src/main.typ
BUILD_DIR  := build
PDF        := $(BUILD_DIR)/linux-shell-bash-handbook.pdf

.PHONY: all pdf watch regen clean

all: pdf

pdf: $(PDF)

$(PDF): $(wildcard src/*.typ) $(wildcard fonts/*)
	@mkdir -p $(BUILD_DIR)
	$(TYPST) compile $(FONT_FLAGS) $(MAIN) $(PDF)
	@echo "Built $(PDF)"

watch:
	@mkdir -p $(BUILD_DIR)
	$(TYPST) watch $(FONT_FLAGS) $(MAIN) $(PDF)

regen:
	python3 scripts/build.py

clean:
	rm -rf $(BUILD_DIR)
