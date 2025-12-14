<p align="center">
  <img src="assets/vscode-logo.png" alt="VS Code Logo" width="128">
</p>

<h1 align="center">vscode-init</h1>

<p align="center">
  Configura VS Code con privacidad, seguridad y productividad en un comando.<br>
  Incluye soporte para <a href="#claude-code">Claude Code</a>.
</p>

---

## Instalación

```bash
# Requisito: jq
sudo apt install jq  # Ubuntu/Debian
brew install jq      # macOS

# Instalar vscode-config
git clone https://github.com/icalvete/vscode-init.git
cd vscode-init
sudo make install
```

## Uso rápido

```bash
# Configurar VS Code (privacidad + productividad)
vscode-config setup

# Ver qué está configurado
vscode-config show

# Backup / Restore
vscode-config backup ~/vscode-backup
vscode-config restore ~/vscode-backup
```

### ¿Qué hace `setup`?

- **Privacidad**: Desactiva telemetría de VS Code y extensiones populares
- **Seguridad**: Activa Workspace Trust, desactiva git autofetch
- **Productividad**: Auto-save, format on save, bracket colorization, sticky scroll

---

## Claude Code

Configura VS Code para usar [Claude Code](https://docs.anthropic.com/claude-code) de Anthropic.

```bash
# 1. Instalar Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash

# 2. Configurar VS Code
vscode-config claude-code setup

# 3. Verificar
vscode-config claude-code status
```

Instala la extensión oficial + extensiones complementarias (GitLens, ErrorLens, Markdown).

**Requisitos**: Node.js 18+, VS Code 1.98+, cuenta Claude Pro/Max o API key.

### Documentación

| Recurso | Descripción |
|---------|-------------|
| [docs/claude-code.md](docs/claude-code.md) | Guía completa: comandos, atajos, CLAUDE.md |
| [examples/sinatra-api/](examples/sinatra-api/) | Tutorial práctico paso a paso |

---

## Todos los comandos

```bash
vscode-config --help              # Ayuda
vscode-config setup               # Aplicar configuración recomendada
vscode-config show                # Ver configuración actual
vscode-config backup <dir>        # Backup de settings, keybindings, extensiones
vscode-config restore <dir>       # Restaurar desde backup
vscode-config extensions list     # Listar extensiones
vscode-config claude-code setup   # Configurar Claude Code
vscode-config claude-code status  # Verificar Claude Code
```

---

## Proyecto relacionado

[cursor-init](https://github.com/icalvete/cursor-init) - Lo mismo para Cursor IDE.

## Licencia

MIT
