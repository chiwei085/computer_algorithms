TYPST ?= typst
BUILD_DIR := build
SOURCE_DIRS := exams homeworks

TYP_SOURCES := $(shell find $(SOURCE_DIRS) -type f -name '*.typ' | sort)
PDF_TARGETS := $(patsubst %.typ,$(BUILD_DIR)/%.pdf,$(TYP_SOURCES))

.PHONY: all clean list

all: $(PDF_TARGETS)

$(BUILD_DIR)/%.pdf: %.typ
	@mkdir -p $(@D)
	$(TYPST) compile --root . $< $@

list:
	@printf '%s\n' $(PDF_TARGETS)

clean:
	rm -rf $(BUILD_DIR)
