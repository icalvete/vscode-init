# vscode-init Makefile
# ====================

PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin

.PHONY: install uninstall help

help:
	@echo "vscode-init - Herramienta de configuración para VS Code"
	@echo ""
	@echo "Comandos disponibles:"
	@echo "  make install    Instala vscode-config en $(BINDIR)"
	@echo "  make uninstall  Desinstala vscode-config"
	@echo ""
	@echo "Opciones:"
	@echo "  PREFIX=/path    Directorio de instalación (default: /usr/local)"
	@echo ""
	@echo "Ejemplos:"
	@echo "  sudo make install"
	@echo "  make install PREFIX=~/.local"

install:
	@echo "Instalando vscode-config en $(BINDIR)..."
	@mkdir -p $(BINDIR)
	@cp bin/vscode-config $(BINDIR)/vscode-config
	@chmod +x $(BINDIR)/vscode-config
	@echo "Instalación completada."
	@echo ""
	@echo "Uso: vscode-config --help"

uninstall:
	@echo "Desinstalando vscode-config..."
	@rm -f $(BINDIR)/vscode-config
	@echo "Desinstalación completada."
