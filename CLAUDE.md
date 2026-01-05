# CLAUDE.md

Este archivo proporciona contexto a Claude Code (claude.ai/code) para trabajar en este repositorio.

## Descripción

Herramienta para configurar Visual Studio Code con opciones seguras y productivas, con soporte para Claude Code.

## Proyectos relacionados

- [cursor-init](https://github.com/icalvete/cursor-init) - Proyecto hermano para Cursor IDE
  - Ubicación local: `/home/icalvete/cursor-init`
  - Comparte la misma filosofía y estructura

## Comandos disponibles

### vscode-init

Inicializa proyectos con configuración para Claude Code:

```bash
vscode-init ~/proyecto --ruby --rails --mcp-github
```

Genera: `CLAUDE.md`, `.claude/commands/`, `.claude/mcp.json`, `.vscode/settings.json`

Flags: `--ruby`, `--python`, `--javascript`, `--rails`, `--godot`, `--arduino`, `--mcp-github`, `--mcp-postgres`

**Detección automática:**
- Godot (si encuentra `project.godot`)
- Arduino (si encuentra archivos `.ino`)

### vscode-config

Configura VS Code globalmente:

```bash
vscode-config setup              # Aplica configuración recomendada
vscode-config claude-code setup  # Instala extensión Claude Code
```

## Comandos de desarrollo

```bash
# Instalar
sudo make install
make install PREFIX=~/.local

# Probar
./bin/vscode-init /tmp/test --ruby
./bin/vscode-config show
./bin/vscode-config claude-code status
```

## Estructura del proyecto

```
vscode-init/
├── bin/
│   ├── vscode-init          # Inicializa proyectos (~375 líneas bash)
│   └── vscode-config        # Configura VS Code global (~1030 líneas bash)
├── templates/
│   ├── claude-md/           # Templates CLAUDE.md (base, ruby, python, js, rails, arduino)
│   ├── commands/            # /document, /review, /explain, /security
│   ├── extensions/          # Listas de extensiones (base, ruby, python, js, php, arduino)
│   ├── keybindings/         # Atajos de teclado (claude-code.json)
│   ├── mcp/                 # github.json, postgres.json
│   ├── settings/            # Settings de Claude Code
│   └── vscode/              # Settings por lenguaje
├── docs/
│   ├── vscode-init.md
│   └── claude-code.md
├── examples/
│   └── sinatra-api/         # Tutorial paso a paso
├── Makefile
└── README.md
```

## Referencias útiles

- Settings de VS Code: `~/.config/Code/User/settings.json` (Linux)
- Extensiones: `~/.vscode/extensions/`
- Keybindings: `~/.config/Code/User/keybindings.json`
