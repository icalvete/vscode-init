# Tarea: Añadir soporte Claude Code a vscode-init

## Contexto

El proyecto `vscode-init` actualmente gestiona configuración de VS Code (backup/restore, telemetría, extensiones). Queremos expandirlo para soportar **Claude Code** como herramienta de desarrollo integrada.

## Objetivos

### 1. Extensiones a instalar

Añadir al script `vscode-config` la instalación de:

```bash
# Extensión oficial de Anthropic (obligatoria)
anthropic.claude-code

# Extensiones complementarias (sugeridas)
# - Mejor visualización de diffs
# - Mejor soporte para Markdown (CLAUDE.md)
# - Terminal mejorada (si se usa CLI)
```

Investigar qué extensiones potencian el uso de Claude Code y añadirlas como opcionales.

### 2. Configuración de VS Code para Claude Code

Crear template de settings específicos para Claude Code:

```json
{
  // Settings recomendados para Claude Code extension
  // - Atajos de teclado
  // - Configuración del panel
  // - Integración con terminal
}
```

### 3. Documentación práctica

Crear `docs/claude-code.md` con:

- **Requisitos previos**: Node.js 18+, suscripción Claude Pro/Max o API key
- **Instalación**: CLI + extensión
- **Configuración inicial**: Login, CLAUDE.md del proyecto
- **Flujo de trabajo básico**: Cómo usar el panel, @-mentions, diffs
- **Comandos útiles**: Slash commands más usados
- **Tips**: Checkpoints, MCP, custom commands

### 4. Proyecto de ejemplo

Crear `examples/sinatra-api/` con:

- Un proyecto Ruby + Sinatra básico (API REST de tareas)
- `CLAUDE.md` bien estructurado para el proyecto
- Instrucciones paso a paso de cómo desarrollarlo con Claude Code
- Demostrar: generación de código, tests, refactoring, commits

## Estructura de archivos a crear/modificar

```
vscode-init/
├── bin/
│   └── vscode-config              # MODIFICAR: añadir extensiones Claude Code
├── templates/
│   └── settings/
│       └── claude-code.json       # CREAR: settings recomendados
├── docs/
│   └── claude-code.md             # CREAR: guía de uso
├── examples/
│   └── sinatra-api/               # CREAR: proyecto de ejemplo
│       ├── CLAUDE.md
│       ├── README.md
│       └── (estructura del proyecto)
└── README.md                      # MODIFICAR: mencionar soporte Claude Code
```

## Comandos de referencia

```bash
# Instalar extensión via CLI
code --install-extension anthropic.claude-code

# Instalar Claude Code CLI (si no está)
curl -fsSL https://claude.ai/install.sh | bash

# Verificar
claude --version
```

## Notas adicionales

- La extensión Claude Code requiere el CLI instalado (es una UI sobre el CLI)
- Usa la suscripción de Claude (Pro/Max), no cobra extra
- MCP servers configurados en CLI funcionan en la extensión
- El proyecto hermano cursor-init está en `/home/icalvete/cursor-init` para referencia

## Entregables esperados

1. `vscode-config` actualizado con opción para instalar extensiones Claude Code
2. Template de configuración JSON
3. Documentación completa en `docs/claude-code.md`
4. Proyecto de ejemplo funcional
5. README actualizado
