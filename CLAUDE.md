# vscode-init

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

Flags: `--ruby`, `--python`, `--javascript`, `--rails`, `--mcp-github`, `--mcp-postgres`

### vscode-config

Configura VS Code globalmente:

```bash
vscode-config setup              # Aplica configuración recomendada
vscode-config claude-code setup  # Instala extensión Claude Code
```

## Estructura del proyecto

```
vscode-init/
├── bin/
│   ├── vscode-init          # Inicializa proyectos
│   └── vscode-config        # Configura VS Code global
├── templates/
│   ├── claude-md/           # Templates CLAUDE.md (base, ruby, python, js, rails)
│   ├── commands/            # /document, /review
│   ├── mcp/                 # github.json, postgres.json
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

---

## Estado actual (eliminar cuando retomes)

**Última sesión**: vscode-init completado

- Implementado `bin/vscode-init` (~350 líneas bash)
- Creados todos los templates en `templates/`
- Actualizado `Makefile`, `README.md`, `docs/vscode-init.md`
- Tests pasados: básico, --rails --mcp-github, --ruby --python
- Cambios committeados y subidos a git

**Pendiente (opcional)**:
- Tutorial `examples/sinatra-api/` tiene imágenes añadidas pero puede necesitar revisión final
- Probar instalación limpia con `sudo make install`
