# vscode-init

Herramienta para configurar Visual Studio Code con opciones seguras y productivas.

## Proyectos relacionados

- [cursor-init](https://github.com/icalvete/cursor-init) - Proyecto hermano para Cursor IDE
  - Ubicación local: `/home/icalvete/cursor-init`
  - Comparte la misma filosofía y estructura

## Contexto

Este proyecto adapta los conceptos de `cursor-config` (de cursor-init) a Visual Studio Code:

- `vscode-config`: Gestión de configuración global de VS Code
  - Backup/restore de settings, keybindings, snippets
  - Configuración de privacidad recomendada (telemetría)
  - Gestión de extensiones

## Estructura objetivo (basada en cursor-init)

```
vscode-init/
├── bin/
│   └── vscode-config        # Script principal
├── templates/
│   └── settings/            # Templates de configuración
├── docs/                    # Documentación
├── LICENSE                  # MIT
├── Makefile                 # Instalación
└── README.md
```

## Diferencias con cursor-init

- VS Code no tiene Agent Mode, MCP, ni Rules → no hay `vscode-init` (solo `vscode-config`)
- Enfocado en: telemetría, settings de privacidad, backup/restore, extensiones
- Sin templates de lenguajes (VS Code no usa .cursor/rules/)

## Referencias útiles

- Settings de VS Code: `~/.config/Code/User/settings.json` (Linux)
- Extensiones: `~/.vscode/extensions/`
- Keybindings: `~/.config/Code/User/keybindings.json`
