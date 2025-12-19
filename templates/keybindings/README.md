# Keybindings Templates

Atajos de teclado recomendados para VS Code.

## claude-code.json

Atajos para Claude Code que mejoran la productividad:

| Atajo | Comando | Descripción |
|-------|---------|-------------|
| `Ctrl+Alt+C` | Abrir Claude Code | Abre Claude Code en sidebar (atajo rápido) |
| `Ctrl+Escape` | Toggle focus | Alterna entre editor y Claude Code |
| `Alt+K` | @ mention | Inserta @ para mencionar archivos |

### Instalación manual

Copia el contenido de `claude-code.json` a tu `~/.config/Code/User/keybindings.json` (Linux) o `~/Library/Application Support/Code/User/keybindings.json` (macOS).

O usa el comando:

```bash
# Linux
cat templates/keybindings/claude-code.json >> ~/.config/Code/User/keybindings.json

# macOS
cat templates/keybindings/claude-code.json >> ~/Library/Application\ Support/Code/User/keybindings.json
```

**Nota:** Si ya tienes keybindings personalizados, copia solo los atajos que necesites para evitar duplicados.

### Instalación automática

El comando `vscode-config claude-code setup` instalará estos atajos automáticamente.
