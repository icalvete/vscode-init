# vscode-init Makefile
# ====================

PREFIX ?= $(HOME)/.local
BINDIR = $(PREFIX)/bin
CURDIR_ABS = $(shell pwd)

.PHONY: install uninstall help

help:
	@echo "vscode-init - Herramientas para VS Code y Claude Code"
	@echo ""
	@echo "Comandos disponibles:"
	@echo "  make install    Instala vscode-init y vscode-config"
	@echo "  make uninstall  Desinstala ambas herramientas"
	@echo ""
	@echo "Opciones:"
	@echo "  PREFIX=/path    Directorio de instalación (default: ~/.local)"
	@echo ""
	@echo "IMPORTANTE: La instalación crea symlinks al repositorio."
	@echo "            No borres ni muevas este directorio después de instalar."

install:
	@echo "Instalando vscode-init y vscode-config en $(BINDIR)..."
	@mkdir -p $(BINDIR)
	@ln -sf $(CURDIR_ABS)/bin/vscode-init $(BINDIR)/vscode-init
	@ln -sf $(CURDIR_ABS)/bin/vscode-config $(BINDIR)/vscode-config
	@chmod +x $(CURDIR_ABS)/bin/vscode-init
	@chmod +x $(CURDIR_ABS)/bin/vscode-config
	@echo ""
	@echo "Instalación completada."
	@echo ""
	@echo "IMPORTANTE: Este directorio contiene los scripts."
	@echo "            No lo borres ni lo muevas."
	@echo ""
	@echo "Uso:"
	@echo "  vscode-init --help"
	@echo "  vscode-config --help"

uninstall:
	@echo "Desinstalando vscode-init y vscode-config..."
	@rm -f $(BINDIR)/vscode-init
	@rm -f $(BINDIR)/vscode-config
	@echo "Desinstalación completada."
