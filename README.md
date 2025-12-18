<p align="center">
  <img src="assets/vscode-logo.png" alt="VS Code Logo" width="128">
</p>

<h1 align="center">vscode-init</h1>

<p align="center">
  Configura VS Code con privacidad, seguridad y productividad en un comando.<br>
  Incluye soporte para <a href="#claude-code">Claude Code</a>.<br>
  <em>Templates optimizados para mínimo consumo de tokens.</em>
</p>

---

## ¿Qué hace?

Este proyecto incluye dos herramientas:

### vscode-init

Inicializa proyectos con configuración para Claude Code:

```bash
vscode-init ~/proyectos/mi-app --ruby --rails --mcp-github
```

Genera: `CLAUDE.md`, comandos personalizados (`/document`, `/review`), y settings de VS Code.

### vscode-config

Configura VS Code globalmente de forma segura y productiva:

- **Desactiva telemetría** de VS Code y extensiones populares
- **Activa protecciones** como Workspace Trust y confirmaciones de git
- **Mejora productividad** con auto-save, format on save, sticky scroll
- **Instala Claude Code** con extensiones complementarias

```bash
vscode-config setup
```

---

## Instalación

```bash
# 1. Instalar dependencia
sudo apt install jq      # Ubuntu/Debian
brew install jq          # macOS

# 2. Clonar en tu home e instalar
cd ~
git clone https://github.com/icalvete/vscode-init.git
cd vscode-init
make install
```

> **Importante**: La instalación crea symlinks a este directorio. No lo borres ni lo muevas después de instalar.

---

## Inicializar proyectos (vscode-init)

```bash
# Proyecto básico
vscode-init ~/proyectos/mi-app

# Con lenguaje
vscode-init ~/proyectos/mi-app --ruby
vscode-init ~/proyectos/mi-app --python
vscode-init ~/proyectos/mi-app --javascript

# Con framework
vscode-init ~/proyectos/mi-app --rails

# Con MCP
vscode-init ~/proyectos/mi-app --mcp-github
vscode-init ~/proyectos/mi-app --mcp-postgres

# Combinaciones
vscode-init ~/proyectos/mi-app --rails --mcp-github
```

### Estructura generada

```
mi-proyecto/
├── CLAUDE.md              # Contexto del proyecto
├── .claude/
│   ├── commands/          # /document, /review
│   └── mcp.json           # Si usas --mcp-*
└── .vscode/
    └── settings.json      # Settings del lenguaje
```

Ver [docs/vscode-init.md](docs/vscode-init.md) para más detalles.

---

## Configurar VS Code (vscode-config)

### Configuración básica

```bash
# Aplicar configuración recomendada (privacidad + productividad)
vscode-config setup

# Ver qué está configurado actualmente
vscode-config show
```

### Backup y restore

```bash
# Guardar configuración actual
vscode-config backup ~/vscode-backup

# Restaurar (settings, keybindings, snippets, extensiones)
vscode-config restore ~/vscode-backup
```

### Extensiones

`vscode-init` ofrece instalar extensiones según el lenguaje del proyecto:

- **Base:** Remote SSH, ErrorLens, Prettier, Markdown, SonarLint, Docker
- **Ruby:** Ruby LSP, Solargraph, RuboCop, ERB
- **Python:** Python, Pylance, Debugpy, Black, Pylint, Jupyter (5 extensiones)
- **JavaScript:** ESLint, Prettier
- **PHP:** Intelephense, Xdebug

Ver [documentación completa de extensiones](docs/vscode-init.md#extensiones-recomendadas).

**Comandos de gestión:**

```bash
# Ver extensiones instaladas
vscode-config extensions list

# Exportar lista
vscode-config extensions backup ~/mis-extensiones.txt

# Instalar desde lista
vscode-config extensions restore ~/mis-extensiones.txt
```

---

## Claude Code

Soporte integrado para [Claude Code](https://docs.anthropic.com/claude-code), el asistente de programación de Anthropic.

### Instalación

```bash
# 1. Instalar Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash

# 2. Autenticarse
claude login

# 3. Configurar VS Code (extensión + settings + extensiones útiles)
vscode-config claude-code setup

# 4. Verificar que todo está listo
vscode-config claude-code status
```

### ¿Qué instala `claude-code setup`?

| Extensión | Descripción |
|-----------|-------------|
| `anthropic.claude-code` | Extensión oficial de Claude Code |
| `usernamehw.errorlens` | Errores inline - Claude los ve y puede arreglarlos |
| `esbenp.prettier-vscode` | Formateo automático de código |
| `yzhang.markdown-all-in-one` | Para editar CLAUDE.md cómodamente |

**Opcionales** (se preguntan durante setup):
- `eamodio.gitlens` - Historial git avanzado y blame
- `streetsidesoftware.code-spell-checker` - Corrector ortográfico
- `christian-kohler.path-intellisense` - Autocompletado de rutas
- `ms-vscode-remote.remote-ssh` - Desarrollo remoto por SSH
- `ms-vscode-remote.remote-ssh-edit` - Editar configuración SSH
- `ms-vscode.remote-explorer` - Explorador de conexiones remotas

### Requisitos

- Node.js 18+
- VS Code 1.98+
- Cuenta Claude Pro/Max o API key de Anthropic

### Documentación

- **[Guía de Claude Code](docs/claude-code.md)** - Comandos, atajos, cómo usar CLAUDE.md
- **[Tutorial práctico](examples/sinatra-api/)** - Ejemplo paso a paso con Sinatra

---

## Configuración aplicada

### Privacidad

| Setting | Efecto |
|---------|--------|
| `telemetry.telemetryLevel: off` | Desactiva telemetría de VS Code |
| `workbench.enableExperiments: false` | Sin experimentos A/B de Microsoft |
| `enable-crash-reporter: false` | Sin crash reports |
| Extensiones | Telemetría desactivada en RedHat, GitLens, AWS, Terraform |

### Seguridad

| Setting | Efecto |
|---------|--------|
| `security.workspace.trust.enabled: true` | Pregunta antes de ejecutar código |
| `git.autofetch: false` | Git no ejecuta comandos automáticamente |
| `git.confirmSync: true` | Confirma antes de push/pull |

### Productividad

| Setting | Efecto |
|---------|--------|
| `files.autoSave: afterDelay` | Guarda automáticamente cada segundo |
| `editor.formatOnSave: true` | Formatea al guardar |
| `editor.stickyScroll.enabled: true` | Contexto de función visible |
| `editor.bracketPairColorization.enabled: true` | Brackets coloreados |
| `files.trimTrailingWhitespace: true` | Limpia espacios al final |

---

## Todos los comandos

```
vscode-config --help                  Muestra ayuda
vscode-config setup                   Aplica configuración recomendada
vscode-config show                    Muestra configuración actual

vscode-config backup <dir>            Guarda settings, keybindings, extensiones
vscode-config restore <dir>           Restaura desde backup

vscode-config extensions list         Lista extensiones instaladas
vscode-config extensions backup <f>   Exporta lista de extensiones
vscode-config extensions restore <f>  Instala extensiones desde lista

vscode-config claude-code setup       Configura VS Code para Claude Code
vscode-config claude-code status      Verifica instalación de Claude Code
```

---

## Archivos de configuración

| Archivo | Ubicación (Linux) |
|---------|-------------------|
| Settings | `~/.config/Code/User/settings.json` |
| Keybindings | `~/.config/Code/User/keybindings.json` |
| Snippets | `~/.config/Code/User/snippets/` |
| Runtime | `~/.config/Code/argv.json` |

En **macOS**: `~/Library/Application Support/Code/User/`

---

## Proyecto relacionado

**[cursor-init](https://github.com/icalvete/cursor-init)** - Lo mismo para Cursor IDE.

---

## Licencia

MIT - ver [LICENSE](LICENSE)
