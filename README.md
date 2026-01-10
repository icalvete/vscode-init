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

Inicializa proyectos con configuración para Claude Code y soporte para múltiples lenguajes:

#### Lenguajes y frameworks soportados

<table>
  <tr>
    <th>Lenguaje/Framework</th>
    <th>Características</th>
  </tr>
  <tr>
    <td><img src="assets/icons/ruby.svg" width="20" height="20" align="center"> <strong>Ruby</strong></td>
    <td>Ruby LSP, RuboCop, convenciones YARD</td>
  </tr>
  <tr>
    <td><img src="assets/icons/rails.svg" width="20" height="20" align="center"> <strong>Ruby on Rails</strong></td>
    <td>ERB templates, Rails best practices</td>
  </tr>
  <tr>
    <td><img src="assets/icons/python.svg" width="20" height="20" align="center"> <strong>Python</strong></td>
    <td>Pylance, Black, Pylint, Jupyter notebooks</td>
  </tr>
  <tr>
    <td><img src="assets/icons/javascript.svg" width="20" height="20" align="center"> <strong>JavaScript</strong></td>
    <td>ESLint, JSDoc, modern ES6+ patterns</td>
  </tr>
  <tr>
    <td><img src="assets/icons/php.svg" width="20" height="20" align="center"> <strong>PHP</strong></td>
    <td>Intelephense, PSR-12, PHPDoc</td>
  </tr>
  <tr>
    <td><img src="assets/icons/cpp.svg" width="20" height="20" align="center"> <strong>C/C++</strong></td>
    <td>CMake, C++17/20, smart pointers, RAII</td>
  </tr>
  <tr>
    <td><img src="assets/icons/godot.svg" width="20" height="20" align="center"> <strong>Godot Engine</strong></td>
    <td>GDScript, C#, scene management patterns</td>
  </tr>
  <tr>
    <td><img src="assets/icons/arduino.svg" width="20" height="20" align="center"> <strong>Arduino/IoT</strong></td>
    <td>PlatformIO, C/C++, embedded patterns</td>
  </tr>
</table>

**Ejemplo de uso:**

```bash
vscode-init ~/proyectos/mi-app --ruby --rails --mcp-github
```

**Genera:**
- `CLAUDE.md` con contexto del proyecto y convenciones específicas del lenguaje
- Comandos personalizados: `/document`, `/review`, `/project-info`, `/security`
- Settings de VS Code optimizados para cada lenguaje
- Configuración MCP opcional (GitHub, PostgreSQL)

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

## Instalación y configuración inicial

### 1. Instalar vscode-init

```bash
# Instalar dependencia
sudo apt install jq      # Ubuntu/Debian
brew install jq          # macOS

# Clonar en tu home e instalar
cd ~
git clone https://github.com/icalvete/vscode-init.git
cd vscode-init
make install
```

> **Importante**: La instalación crea symlinks a este directorio. No lo borres ni lo muevas después de instalar.

### 2. Configurar VS Code (setup inicial)

**Después de instalar, configura VS Code globalmente:**

```bash
# Aplicar configuración recomendada (privacidad + productividad)
vscode-config setup
```

Esto configura:
- ✅ Telemetría desactivada (VS Code + extensiones populares)
- ✅ Workspace Trust y confirmaciones de git activadas
- ✅ Auto-save, format on save, sticky scroll
- ✅ Mejoras de productividad

**Ver configuración actual:**
```bash
vscode-config show
```

### 3. Backup y restore (opcional)

```bash
# Guardar tu configuración actual (antes de hacer cambios)
vscode-config backup ~/vscode-backup

# Restaurar desde backup (settings, keybindings, snippets, extensiones)
vscode-config restore ~/vscode-backup
```

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

# Con game engine
vscode-init ~/proyectos/mi-juego --godot

# Con embedded/IoT
vscode-init ~/proyectos/mi-sensor --arduino

# Con MCP
vscode-init ~/proyectos/mi-app --mcp-github
vscode-init ~/proyectos/mi-app --mcp-postgres

# Combinaciones
vscode-init ~/proyectos/mi-app --rails --mcp-github

# Detección automática
vscode-init ~/proyectos/mi-juego-existente  # Si hay project.godot
vscode-init ~/proyectos/mi-sketch-existente # Si hay archivos .ino
```

### Estructura generada

```
mi-proyecto/
├── CLAUDE.md              # Contexto del proyecto
├── .claude/
│   ├── commands/          # /document, /review, /project-info
│   └── mcp.json           # Si usas --mcp-*
└── .vscode/
    └── settings.json      # Settings del lenguaje
```

Ver [docs/vscode-init.md](docs/vscode-init.md) para más detalles.

---

## Extensiones por lenguaje

`vscode-init` ofrece instalar extensiones según el lenguaje del proyecto:

- **Base:** Remote SSH, ErrorLens, Prettier, Markdown, Rainbow CSV, Docker
- **Ruby:** Ruby LSP, Solargraph, RuboCop, ERB
- **Python:** Python, Pylance, Debugpy, Black, Pylint, Jupyter (5 extensiones)
- **JavaScript:** ESLint, Prettier
- **PHP:** Intelephense, Xdebug
- **C/C++:** C/C++ Extension Pack, CMake Tools, CMake language
- **Arduino:** PlatformIO IDE, C/C++ Tools, Serial Monitor

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
- `streetsidesoftware.code-spell-checker` - Corrector ortográfico (deshabilitada por defecto)
- `christian-kohler.path-intellisense` - Autocompletado de rutas
- `ms-vscode-remote.remote-ssh` - Desarrollo remoto por SSH
- `ms-vscode-remote.remote-ssh-edit` - Editar configuración SSH
- `ms-vscode.remote-explorer` - Explorador de conexiones remotas

**Atajos de teclado incluidos:**
- `Ctrl+Alt+C` - Abrir Claude Code rápidamente
- `Ctrl+Escape` - Toggle focus entre editor y Claude
- `Alt+K` - Insertar @ mention

Ver todos los atajos en [templates/keybindings/claude-code.json](templates/keybindings/claude-code.json).

### Requisitos

- Node.js 18+
- VS Code 1.98+
- Cuenta Claude Pro/Max o API key de Anthropic

### Documentación

- **[Guía de Claude Code](docs/claude-code.md)** - Comandos, atajos, cómo usar CLAUDE.md
- **[Guía de Godot Engine](docs/godot.md)** - Desarrollo de videojuegos con Godot 4.x
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

### Ubicaciones principales

| Archivo | Ubicación (Linux) | Qué contiene |
|---------|-------------------|--------------|
| **settings.json** | `~/.config/Code/User/settings.json` | Configuración global de VS Code: telemetría, auto-save, format on save, settings de extensiones |
| **keybindings.json** | `~/.config/Code/User/keybindings.json` | Atajos de teclado personalizados (incluye Ctrl+Alt+C para Claude Code) |
| **snippets/** | `~/.config/Code/User/snippets/` | Snippets de código personalizados por lenguaje |
| **argv.json** | `~/.config/Code/argv.json` | Configuración de runtime: locale, flags de Chromium, proxy |

En **macOS**: `~/Library/Application Support/Code/User/`

### Archivos por proyecto

Cada proyecto inicializado con `vscode-init` contiene:

| Archivo | Ubicación | Qué contiene |
|---------|-----------|--------------|
| **CLAUDE.md** | `proyecto/CLAUDE.md` | Contexto del proyecto: lenguaje, convenciones, comandos útiles, patterns específicos |
| **settings.json** | `proyecto/.vscode/settings.json` | Settings específicos del proyecto: formateo, linting, configuración del lenguaje |
| **commands/** | `proyecto/.claude/commands/` | Comandos personalizados: `/document`, `/review`, `/explain`, `/security` |
| **mcp.json** | `proyecto/.claude/mcp.json` | Configuración MCP (GitHub, PostgreSQL) si se usa `--mcp-*` |

---

## Proyecto relacionado

**[cursor-init](https://github.com/icalvete/cursor-init)** - Lo mismo para Cursor IDE.

---

## Licencia

MIT - ver [LICENSE](LICENSE)
