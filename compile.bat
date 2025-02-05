@echo off
pdflatex --shell-escape main
pdflatex --shell-escape main
del *.gnuplot
del *.table
del *.aux
del *.log
