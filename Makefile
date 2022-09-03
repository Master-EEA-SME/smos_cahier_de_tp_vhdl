MKFILE_PATH = $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR = $(dir $(MKFILE_PATH))
LTX ?= pdflatex
LTX_FLAGS ?= -synctex=1 -interaction=nonstopmode -file-line-error -recorder
PDF_FILE ?= smos_cahier_de_tp_vhdl
TEX_FILE ?= $(MKFILE_DIR)/main.tex

GH ?= gh
GIT ?= git
RELEASE_FILES ?= $(MKFILE_DIR)/$(PDF_FILE).pdf

all: build

build:
	$(LTX) $(LTX_FLAGS) -jobname="$(PDF_FILE)" $(TEX_FILE)

clean:
	find $(MKFILE_DIR) \
        -name "*.aux" -type f -delete -o \
        -name "*.fls" -type f -delete -o \
        -name "*.log" -type f -delete -o \
        -name "*.out" -type f -delete -o \
        -name "*.pdf" -type f -delete

deploy_release:
	$(GH) release create $(TAG) $(RELEASE_FILES) --target $(BRANCH)

remove_release:
	$(GH) release delete $(TAG)
	git push --delete origin $(TAG)
