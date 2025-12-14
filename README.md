<p align="center">
  <img src="assets/vscode-logo.png" alt="VS Code Logo" width="128">
</p>

<h1 align="center">vscode-init</h1>

<p align="center">
  Herramienta para configurar Visual Studio Code con opciones seguras y productivas.
</p>

<p align="center">
  <a href="#instalación">Instalación</a> •
  <a href="#uso">Uso</a> •
  <a href="#qué-configura-vscode-config-setup">Configuración</a> •
  <a href="#licencia">Licencia</a>
</p>

---

## Instalación

```bash
# Clonar el repositorio
git clone https://github.com/icalvete/vscode-init.git
cd vscode-init

# Instalar (requiere sudo para /usr/local/bin)
sudo make install

# O instalar en ~/.local/bin (sin sudo)
make install PREFIX=~/.local
```

### Requisitos

- **jq**: Para manipular archivos JSON
  ```bash
  # Ubuntu/Debian
  sudo apt install jq

  # macOS
  brew install jq

  # Fedora
  sudo dnf install jq
  ```

## Uso

```bash
# Ver ayuda
vscode-config --help

# Aplicar configuración recomendada
vscode-config setup

# Ver configuración actual
vscode-config show

# Backup de configuración
vscode-config backup ~/vscode-backup

# Restaurar configuración
vscode-config restore ~/vscode-backup

# Gestionar extensiones
vscode-config extensions list
vscode-config extensions backup ~/extensions.txt
vscode-config extensions restore ~/extensions.txt
```

## ¿Qué configura `vscode-config setup`?

### Privacidad

| Setting | Valor | Descripción |
|---------|-------|-------------|
| `telemetry.telemetryLevel` | `off` | Desactiva toda telemetría de VS Code |
| `telemetry.enableTelemetry` | `false` | Setting legacy, aún respetado |
| `workbench.enableExperiments` | `false` | Desactiva experimentos A/B de Microsoft |
| `workbench.settings.enableNaturalLanguageSearch` | `false` | Desactiva búsqueda que usa Bing |
| `enable-crash-reporter` | `false` | Desactiva envío de crash reports (argv.json) |

**Extensiones populares** - También desactiva telemetría de:
- RedHat (Java, XML, YAML)
- GitLens
- AWS Toolkit
- Terraform
- Julia, Lua

### Seguridad

| Setting | Valor | Descripción |
|---------|-------|-------------|
| `security.workspace.trust.enabled` | `true` | Activa Workspace Trust |
| `security.workspace.trust.untrustedFiles` | `prompt` | Pregunta antes de abrir archivos no confiables |
| `git.autofetch` | `false` | Evita ejecución automática de git fetch |
| `git.confirmSync` | `true` | Confirma antes de sincronizar |
| `terminal.integrated.enablePersistentSessions` | `false` | No persiste sesiones de terminal |

### Productividad

| Setting | Valor | Descripción |
|---------|-------|-------------|
| `files.autoSave` | `afterDelay` | Guarda automáticamente cada segundo |
| `editor.formatOnSave` | `true` | Formatea al guardar |
| `editor.bracketPairColorization.enabled` | `true` | Colorea pares de brackets (nativo, rápido) |
| `editor.stickyScroll.enabled` | `true` | Muestra contexto de función al hacer scroll |
| `editor.minimap.enabled` | `false` | Más espacio para código |
| `editor.smoothScrolling` | `true` | Scroll suave |
| `files.insertFinalNewline` | `true` | Añade newline al final |
| `files.trimTrailingWhitespace` | `true` | Elimina espacios trailing |
| `search.smartCase` | `true` | Búsqueda case-sensitive inteligente |

## Estructura del proyecto

```
vscode-init/
├── bin/
│   └── vscode-config     # Script principal
├── templates/
│   └── settings/         # Templates de configuración (futuro)
├── docs/                  # Documentación adicional
├── LICENSE               # MIT
├── Makefile              # Instalación
└── README.md
```

## Diferencias con cursor-init

Este proyecto es hermano de [cursor-init](https://github.com/icalvete/cursor-init) para Cursor IDE.

| Característica | cursor-init | vscode-init |
|----------------|-------------|-------------|
| Agent Mode / MCP | Sí | No (VS Code no lo tiene) |
| Rules por proyecto | Sí | No |
| Telemetría | Cursor telemetry | Microsoft telemetry |
| Backup/Restore | Sí | Sí |
| Extensiones | Sí | Sí |

## Rutas de configuración

### Linux
- Settings: `~/.config/Code/User/settings.json`
- Keybindings: `~/.config/Code/User/keybindings.json`
- Snippets: `~/.config/Code/User/snippets/`
- Extensiones: `~/.vscode/extensions/`
- Runtime args: `~/.config/Code/argv.json`

### macOS
- Settings: `~/Library/Application Support/Code/User/settings.json`
- Keybindings: `~/Library/Application Support/Code/User/keybindings.json`
- Snippets: `~/Library/Application Support/Code/User/snippets/`
- Extensiones: `~/.vscode/extensions/`

## Extensiones recomendadas

Algunas extensiones útiles que complementan esta configuración:

```bash
# Productividad general
code --install-extension usernamehw.errorlens
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension eamodio.gitlens

# Formatters
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint

# Themes
code --install-extension dracula-theme.theme-dracula
code --install-extension PKief.material-icon-theme
```

## Licencia

MIT License - ver [LICENSE](LICENSE)

## Proyecto relacionado

- [cursor-init](https://github.com/icalvete/cursor-init) - Configuración para Cursor IDE
