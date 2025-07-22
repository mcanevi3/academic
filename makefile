# Detect the OS
OS := $(shell uname 2>/dev/null || echo Windows)

TEXFILE = main
LATEX = pdflatex
TEXOPTS = -interaction=nonstopmode -halt-on-error

.PHONY: all clean
# Default rule: build the PDF
all: clean main

main:
	$(LATEX) $(TEXOPTS) $(TEXFILE)

# Clean rule
clean:
ifeq ($(OS),Windows)
	@if exist $(TEXFILE).aux del /f $(TEXFILE).aux
	@if exist $(TEXFILE).out del /f $(TEXFILE).out
	@if exist $(TEXFILE).log del /f $(TEXFILE).log
	@if exist $(TEXFILE).toc del /f $(TEXFILE).toc
	@if exist $(TEXFILE).lof del /f $(TEXFILE).lof
	@if exist $(TEXFILE).lot del /f $(TEXFILE).lot
else
	@echo "Cleaning Unix/Mac..."
	@rm -f $(TEXFILE).aux $(TEXFILE).out $(TEXFILE).log $(TEXFILE).toc $(TEXFILE).lof $(TEXFILE).lot
endif
