# Especificación: Extensión de vscode-init para Godot

## Contexto

Extender el proyecto `vscode-init` para soportar proyectos de **Godot Engine 4.x** (motor de desarrollo de videojuegos).

## Objetivo

Permitir inicializar proyectos Godot con configuración optimizada de VSCode, extensiones necesarias, y comandos custom de Claude Code específicos para gamedev.

---

## Requisitos Técnicos

### 1. Extensión de VSCode requerida

**Obligatoria:**
- `godotengine.godot-tools` - Language Server Protocol (LSP) para GDScript, debugging remoto, autocompletado

**Opcionales pero recomendadas:**
- `geequlim.godot-tools` - Alternativa/complemento con features adicionales
- `neikeq.godot-csharp-vscode` - Solo si se soporta C# en Godot

### 2. Settings de VSCode específicos (`.vscode/settings.json`)

```json
{
  // Asociación de archivos Godot
  "files.associations": {
    "*.gd": "gdscript",
    "*.tscn": "godot-scene",
    "*.tres": "godot-resource",
    "*.godot": "godot-project"
  },

  // GDScript formatting
  "editor.formatOnSave": true,
  "[gdscript]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": false,  // Godot usa tabs por defecto
    "editor.detectIndentation": false,
    "editor.rulers": [100]
  },

  // Godot LSP configuration
  "godot_tools.gdscript_lsp_server_port": 6005,
  "godot_tools.editor_path": "", // Path al ejecutable de Godot (auto-detect o manual)

  // Exclude patterns para performance
  "files.exclude": {
    "**/.godot/": true,
    "**/.import/": true
  },
  "search.exclude": {
    "**/.godot/": true,
    "**/.import/": true,
    "**/addons/": false  // Queremos buscar en addons
  }
}
```

### 3. Estructura de template Godot

Crear en `templates/godot/`:

```
templates/godot/
├── .vscode/
│   ├── settings.json          (configuración específica Godot)
│   ├── launch.json            (debug configuration)
│   └── tasks.json             (build tasks opcionales)
├── .claude/
│   ├── commands/
│   │   ├── godot-scene.md     (comando para crear escenas)
│   │   ├── godot-script.md    (comando para crear scripts)
│   │   └── godot-signal.md    (comando para trabajar con signals)
│   └── custom_commands.json
├── CLAUDE.md                   (contexto específico de Godot)
└── .editorconfig               (opcional, para consistencia)
```

### 4. Contenido de CLAUDE.md para Godot

```markdown
# Godot Project Context

## Engine Version
Godot 4.x

## Project Type
[Game genre: platformer/puzzle/rpg/etc]

## Language
GDScript (primary) / C# (if applicable)

## Architecture Patterns

### Scene Tree
- Use scene composition over inheritance
- Keep scenes focused and reusable
- Signal-based communication between nodes

### GDScript Conventions
- Use snake_case for variables/functions
- Use PascalCase for class names
- Prefix private members with underscore: `_private_var`
- Type hints: `var speed: float = 200.0`
- Use @export for inspector-visible variables

### Signals
- Prefer signals over direct node references
- Name signals in past tense: `enemy_died`, `item_collected`
- Document signal parameters

### File Organization
```
project/
├── scenes/          # .tscn files
│   ├── player/
│   ├── enemies/
│   └── ui/
├── scripts/         # .gd files
│   ├── player/
│   ├── enemies/
│   └── systems/
├── resources/       # .tres files
├── assets/
│   ├── sprites/
│   ├── audio/
│   └── fonts/
└── addons/          # Third-party plugins
```

## Common Godot Patterns

### Node Lifecycle
```gdscript
func _ready():
    # Initialization when node enters scene tree

func _process(delta):
    # Called every frame (variable time)

func _physics_process(delta):
    # Called every physics tick (fixed time)
```

### Signal Connection
```gdscript
# In _ready():
button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
    # Handler
```

### Node References
```gdscript
# Prefer @onready over hardcoded paths
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
```

## Testing
- Use GUT (Godot Unit Test) addon for unit tests
- Manual testing via F5 (run project) / F6 (run current scene)

## Performance Considerations
- Use object pooling for frequently spawned objects
- Minimize `_process` calls, use signals when possible
- Profile with Godot's built-in profiler (Debug → Profiler)
```

### 5. Comandos custom de Claude (.claude/commands/)

**godot-scene.md:**
```markdown
---
name: /godot-scene
description: Create a new Godot scene with script
---

Create a new Godot scene (.tscn) and accompanying GDScript (.gd) with:
- Proper node hierarchy
- Signal definitions if needed
- Exported variables for inspector
- Lifecycle methods (_ready, _process, etc.)

Ask for:
- Scene name
- Root node type (Node2D, CharacterBody2D, Control, etc.)
- Main functionality
```

**godot-script.md:**
```markdown
---
name: /godot-script
description: Create a GDScript with Godot best practices
---

Generate a GDScript following conventions:
- Type hints
- Proper naming (snake_case)
- Signal definitions
- @export variables
- Lifecycle methods
- Documentation comments

Ask for:
- Script purpose
- Node type it extends
- Required functionality
```

**godot-signal.md:**
```markdown
---
name: /godot-signal
description: Help implement signal-based communication
---

Implement signal pattern between nodes:
- Define signal in emitter
- Connect in receiver
- Handle parameters
- Document the communication flow

Ask for:
- What event to signal
- Data to pass
- Which nodes communicate
```

### 6. Launch configuration (`.vscode/launch.json`)

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "GDScript Godot",
      "type": "godot",
      "request": "launch",
      "project": "${workspaceFolder}",
      "port": 6007,
      "address": "127.0.0.1",
      "launch_game_instance": true,
      "launch_scene": false
    }
  ]
}
```

---

## Integración con vscode-init

### Modificaciones necesarias en vscode-init:

1. **bin/vscode-init:**
   - Detectar tipo de proyecto Godot (buscar `project.godot`)
   - Opción CLI: `vscode-init --godot` o autodetección

2. **Instalación de extensiones:**
   - Añadir `godotengine.godot-tools` a la lista de extensiones instalables
   - Configurar en `vscode-config` para instalación global si el usuario hace gamedev

3. **Templates:**
   - Copiar estructura `templates/godot/` al proyecto destino
   - Merge de settings si ya existe `.vscode/settings.json`

4. **Documentación:**
   - Añadir sección en README sobre uso con Godot
   - Ejemplos de comandos custom para gamedev

---

## Criterios de Aceptación

- [ ] `vscode-init` detecta proyectos Godot (presencia de `project.godot`)
- [ ] Instala extensión `godotengine.godot-tools`
- [ ] Genera `.vscode/settings.json` con configuración Godot
- [ ] Crea estructura de templates en `.claude/commands/`
- [ ] Genera `CLAUDE.md` con contexto de Godot
- [ ] Comandos `/godot-scene`, `/godot-script`, `/godot-signal` funcionales
- [ ] Documentación actualizada en README
- [ ] Compatible con proyectos Godot 4.x

---

## Notas Adicionales

- Godot 4.x usa `.godot/` para archivos generados (similar a `node_modules/`)
- GDScript usa tabs por defecto (no spaces)
- El LSP de Godot debe estar corriendo (Godot abierto) para autocompletado completo
- C# en Godot requiere .NET SDK, considerar detección y setup separado

---

## Referencias

- Godot LSP: https://github.com/godotengine/godot-vscode-plugin
- GDScript Style Guide: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html
- Godot Best Practices: https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html
