# The Complete Linux Shell & Bash Scripting Handbook — build commands
# Usage: make            build the PDF into build/ (scratch, not committed)
#        make book       build the PDF and copy it into book/ (the published copy)
#        make watch      rebuild automatically while you edit
#        make regen      regenerate src/body.typ from markdown/body.md (needs pandoc)
#        make clean      delete the build/ folder

TYPST      ?= typst
FONT_FLAGS := --font-path fonts --ignore-system-fonts
MAIN       := src/main.typ
BUILD_DIR  := build
PDF        := $(BUILD_DIR)/linux-shell-bash-handbook.pdf
BOOK_DIR   := book

.PHONY: all pdf book watch regen clean

all: pdf

pdf: $(PDF)

$(PDF): $(wildcard src/*.typ) $(wildcard fonts/*)
	@mkdir -p $(BUILD_DIR)
	$(TYPST) compile $(FONT_FLAGS) $(MAIN) $(PDF)
	@echo "Built $(PDF)"

book: $(PDF)
	@mkdir -p $(BOOK_DIR)
	cp $(PDF) $(BOOK_DIR)/
	@echo "Updated $(BOOK_DIR)/$(notdir $(PDF))"

watch:
	@mkdir -p $(BUILD_DIR)
	$(TYPST) watch $(FONT_FLAGS) $(MAIN) $(PDF)

regen:
	python3 scripts/build.py

clean:
	rm -rf $(BUILD_DIR)
