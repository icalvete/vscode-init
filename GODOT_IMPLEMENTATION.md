# Implementación de Soporte Godot Engine en vscode-init

Este documento explica la implementación completa del soporte para Godot Engine 4.x en vscode-init.

---

## 📋 Resumen

Se ha añadido soporte completo para proyectos de **Godot Engine 4.x** con:
- ✅ Detección automática de proyectos Godot
- ✅ Configuración optimizada de VS Code
- ✅ Templates específicos para GDScript y C#
- ✅ 4 comandos custom de Claude Code
- ✅ Documentación completa

---

## 📁 Archivos Creados

### 1. Templates de configuración

#### `templates/godot/.vscode/settings.json`

Configuración específica de VS Code para Godot:

**Qué contiene:**
```json
{
  "files.associations": {
    "*.gd": "gdscript",           // Asocia .gd con GDScript
    "*.tscn": "godot-scene",      // Archivos de escena
    "*.tres": "godot-resource"    // Archivos de recursos
  },
  "[gdscript]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": false,  // IMPORTANTE: Godot usa TABS
    "editor.rulers": [100]         // Guía visual a 100 caracteres
  },
  "godot_tools.gdscript_lsp_server_port": 6005,  // Puerto LSP
  "files.exclude": {
    "**/.godot/": true,            // Oculta archivos generados
    "**/.import/": true            // Oculta imports
  }
}
```

**Por qué es necesario:**
- GDScript usa **tabs** en vez de spaces (convención de Godot)
- Los archivos `.godot/` y `.import/` son generados automáticamente y saturan el explorer
- El LSP de Godot corre en puerto 6005 cuando Godot está abierto

#### `templates/godot/.vscode/launch.json`

Configuraciones de debugging:

**Qué contiene:**
```json
{
  "configurations": [
    {
      "name": "GDScript Godot",
      "type": "godot",
      "launch_game_instance": true,   // Ejecuta el juego completo
      "port": 6007                     // Puerto debug
    },
    {
      "name": "Launch Current Scene",
      "launch_scene": true             // Solo escena actual (F6)
    }
  ]
}
```

**Por qué es necesario:**
- Permite debuggear GDScript desde VS Code
- Requiere que Godot esté abierto (LSP corriendo)
- El puerto 6007 es el estándar para debugging de Godot

#### `templates/godot/.vscode/tasks.json`

Tareas para ejecutar y exportar:

**Qué contiene:**
- **Run Project**: Ejecuta `godot --path .` (equivalente a F5 en Godot)
- **Run Current Scene**: Ejecuta solo la escena abierta
- **Export Project**: Exporta build usando `godot --headless --export-release`

**Por qué es útil:**
- Permite ejecutar el juego sin abrir Godot
- Automatiza exports desde VS Code
- Integra Godot en el workflow de VS Code

#### `templates/godot/.editorconfig`

Configuración universal de formateo:

**Qué contiene:**
```ini
[*.gd]
indent_style = tab       # GDScript usa tabs
indent_size = 4

[*.cs]
indent_style = space     # C# usa spaces
indent_size = 4
```

**Por qué es necesario:**
- Mantiene consistencia entre editores
- Respeta las convenciones de cada lenguaje
- Evita conflictos en control de versiones

#### `templates/godot/.gitignore`

Archivos a ignorar en Git:

**Qué contiene:**
```gitignore
.godot/              # Archivos generados (similar a node_modules)
.import/             # Sistema de import de Godot 3.x (legacy)
export_presets.cfg   # Puede contener paths absolutos
builds/              # Directorio de exports
*.translation        # Archivos de traducción compilados
.mono/               # Si usas C#
```

**Por qué es necesario:**
- `.godot/` puede ser varios GB en proyectos grandes
- `export_presets.cfg` tiene paths específicos de cada máquina
- Los builds se regeneran, no deben estar en Git

---

### 2. Template de extensiones

#### `templates/extensions/godot.txt`

Lista de extensiones recomendadas:

**Qué contiene:**
```
geequlim.godot-tools              # LSP oficial (OBLIGATORIA)
ms-dotnetcore.csharp              # C# support
ms-dotnettools.vscode-dotnet-runtime
ggsimm.godot-shader-tools         # Shaders
```

**Por qué cada una:**
- **godot-tools**: Autocompletado, debugging, syntax highlighting para GDScript
- **csharp**: Solo si usas C# en Godot (detección automática de .cs files)
- **shader-tools**: Syntax highlighting para shaders GLSL de Godot

---

### 3. Template CLAUDE.md

#### `templates/claude-md/godot.md`

Contexto de Godot para Claude Code:

**Qué contiene:**

1. **Convenciones de nomenclatura:**
   - snake_case para variables/funciones
   - PascalCase para clases
   - SCREAMING_SNAKE_CASE para constantes

2. **Patrones de arquitectura:**
   - Scene composition > inheritance
   - Signals para comunicación
   - @onready para referencias a nodos

3. **Lifecycle methods:**
   - `_ready()` - Inicialización
   - `_process(delta)` - Frame a frame
   - `_physics_process(delta)` - Física (60 FPS fijo)

4. **Ejemplos de código:**
   - Movement con CharacterBody2D
   - Signal connections
   - Input handling
   - C# examples (si se usa)

**Por qué es necesario:**
- Claude Code lee CLAUDE.md para entender el contexto del proyecto
- Sin esto, Claude no conoce las convenciones de Godot
- Incluye ejemplos prácticos que Claude puede replicar

---

### 4. Comandos custom de Claude Code

#### `/godot-scene` (`templates/commands/godot-scene.md`)

**Qué hace:**
Crea una escena nueva (.tscn) con su script (.gd) adjunto.

**Flujo:**
1. Usuario ejecuta `/godot-scene`
2. Claude pregunta:
   - Nombre de la escena (ej: "Player")
   - Tipo de nodo raíz (CharacterBody2D, Area2D, etc.)
   - Funcionalidad principal
3. Claude genera:
   - Archivo `.tscn` con la estructura de nodos
   - Archivo `.gd` con script configurado
   - Signals si son necesarios
   - @export variables para el inspector

**Ejemplo de output:**
```gdscript
extends CharacterBody2D
## Player character controller

signal health_changed(new_health: int)
signal died

@export var speed: float = 200.0
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
    pass
```

#### `/godot-script` (`templates/commands/godot-script.md`)

**Qué hace:**
Genera un script GDScript standalone con todas las best practices.

**Incluye:**
- Type hints obligatorios
- Signals tipados
- @export para inspector
- @onready para node references
- Documentación ## (doc comments)
- Lifecycle methods según necesidad

**Cuándo usarlo:**
- Crear componentes reutilizables
- Scripts que no son scenes (resources, autoloads, etc.)
- Sistemas globales (GameManager, ScoreManager)

#### `/godot-signal` (`templates/commands/godot-signal.md`)

**Qué hace:**
Ayuda a implementar comunicación entre nodos via signals.

**Flujo:**
1. Claude pregunta:
   - Qué evento disparar
   - Quién emite el signal
   - Quién recibe el signal
   - Qué datos pasar
2. Claude genera:
   - Definición del signal en emisor
   - Código de emisión (`signal_name.emit()`)
   - Conexión en `_ready()` del receptor
   - Handler function en receptor

**Ejemplo:**
```gdscript
# En Enemy.gd (emisor)
signal died(enemy_name: String, score: int)

func take_damage(amount: int):
    health -= amount
    if health <= 0:
        died.emit(name, score_value)

# En ScoreManager.gd (receptor)
func _ready():
    for enemy in get_tree().get_nodes_in_group("enemies"):
        enemy.died.connect(_on_enemy_died)

func _on_enemy_died(enemy_name: String, score: int):
    total_score += score
```

#### `/godot-export` (`templates/commands/godot-export.md`)

**Qué hace:**
Guía para configurar y exportar el juego.

**Incluye:**
- Configurar export presets en Godot
- Comandos CLI para export headless
- Platform-specific settings
- Distribution checklist

**Plataformas soportadas:**
```bash
# Linux
godot --headless --export-release "Linux/X11" builds/game.x86_64

# Windows
godot --headless --export-release "Windows Desktop" builds/game.exe

# Web
godot --headless --export-release "Web" builds/index.html
```

---

### 5. Modificaciones en bin/vscode-init

#### Variables añadidas (línea 37)

```bash
FLAG_GODOT=false
```

#### Parser de argumentos (línea 344-347)

```bash
--godot)
    FLAG_GODOT=true
    shift
    ;;
```

#### Detección automática (línea 439-442)

```bash
if [[ -f "$TARGET_DIR/project.godot" ]]; then
    info "Proyecto Godot detectado (project.godot encontrado)"
    FLAG_GODOT=true
fi
```

**Por qué:**
- Si el usuario ejecuta `vscode-init` en un proyecto Godot existente, se detecta automáticamente
- No necesita usar `--godot` explícitamente

#### Función copy_godot_templates() (línea 171-218)

**Qué hace:**
1. Copia todos los .json de `.vscode/` haciendo merge si ya existen
2. Copia `.editorconfig` si no existe
3. Merge `.gitignore` con reglas de Godot

**Por qué una función separada:**
- Godot tiene una estructura más compleja que otros lenguajes
- Necesita copiar múltiples archivos de configuración
- Debe hacer merge inteligente para no sobrescribir configuración existente

#### Lógica en main() (línea 477-481)

```bash
if [[ "$FLAG_GODOT" == true ]]; then
    copy_language "$TARGET_DIR" "godot"      # Añade sección a CLAUDE.md
    copy_godot_templates "$TARGET_DIR"       # Copia configuración completa
fi
```

#### Help actualizado (línea 60, 65-66, 72)

```bash
--godot         Añade configuración para Godot Engine 4.x

Detección automática:
  - Godot: si encuentra project.godot

vscode-init ~/proyectos/mi-juego --godot
```

---

### 6. Documentación

#### `docs/godot.md`

Guía completa de 300+ líneas con:

**Secciones:**
1. Características y uso básico
2. Estructura generada
3. Configuración aplicada (settings, launch, tasks)
4. Comandos custom explicados
5. Convenciones de código (GDScript + C#)
6. Workflow con Claude Code
7. Tips y mejores prácticas
8. Troubleshooting
9. Exportar juego
10. Referencias

**Por qué es importante:**
- Documenta todos los templates creados
- Explica el workflow completo
- Incluye soluciones a problemas comunes
- Tiene ejemplos de código funcionales

#### Actualizaciones en README.md

```markdown
# Con game engine
vscode-init ~/proyectos/mi-juego --godot

# Detección automática (si hay project.godot)
vscode-init ~/proyectos/mi-juego-existente
```

```markdown
- **[Guía de Godot Engine](docs/godot.md)** - Desarrollo de videojuegos con Godot 4.x
```

#### Actualizaciones en CLAUDE.md

```markdown
Flags: `--ruby`, `--python`, `--javascript`, `--rails`, `--godot`, `--mcp-github`, `--mcp-postgres`

**Detección automática:** Godot (si encuentra `project.godot`)
```

---

## 🎯 Cómo usar la implementación

### Caso 1: Proyecto Godot nuevo

```bash
# Crear directorio y proyecto
mkdir ~/proyectos/mi-juego
cd ~/proyectos/mi-juego

# Crear project.godot vacío (o hacerlo desde Godot)
touch project.godot

# Inicializar con vscode-init
vscode-init . --godot
```

**Resultado:**
- CLAUDE.md con contexto de Godot
- .vscode/ con settings, launch, tasks
- .editorconfig, .gitignore
- .claude/commands/ con 4 comandos Godot
- Oferta de instalar `geequlim.godot-tools`

### Caso 2: Proyecto Godot existente

```bash
# Simplemente ejecutar vscode-init
cd ~/proyectos/mi-juego-existente
vscode-init .
```

**Resultado:**
- Detecta automáticamente `project.godot`
- Aplica toda la configuración Godot
- Hace merge con archivos existentes (no sobrescribe)

### Caso 3: Usar comandos custom

Abre Claude Code (`Ctrl+Alt+C`) y:

```
/godot-scene

> Scene name: Player
> Root node type: CharacterBody2D
> Functionality: Top-down movement with 8 directions
```

Claude genera:
```gdscript
extends CharacterBody2D
## Player character with 8-directional movement

@export var speed: float = 300.0

func _physics_process(delta):
    var input_vector = Input.get_vector(
        "move_left", "move_right",
        "move_up", "move_down"
    )

    velocity = input_vector.normalized() * speed
    move_and_slide()
```

---

## 🔧 Detalles técnicos importantes

### Tabs vs Spaces

**Problema:**
- GDScript usa **tabs** (convención oficial de Godot)
- Otros lenguajes en vscode-init usan **spaces**

**Solución:**
- `.editorconfig` define tabs para `*.gd`
- settings.json define `"editor.insertSpaces": false` para `[gdscript]`
- C# usa spaces (convención C#)

### Merge de archivos JSON

La función `copy_godot_templates` usa `jq` para hacer merge:

```bash
jq -s '.[0] * .[1]' existing.json template.json > merged.json
```

**Por qué:**
- No sobrescribe configuración existente del usuario
- Añade solo las keys específicas de Godot
- Si no hay `jq`, copia directamente (con warning)

### Puerto LSP vs Debug

**Puertos usados:**
- **6005**: GDScript LSP Server (autocompletado)
- **6007**: Godot Debug Server (debugging)

**Por qué dos puertos:**
- El LSP es para el language server (autocomplete, go-to-definition)
- El debug server es para breakpoints y stepping
- Son servicios diferentes que Godot expone

### Detección automática

**Orden de detección:**
1. Parse argumentos CLI
2. **Detectar `project.godot`** (si existe, `FLAG_GODOT=true`)
3. Ejecutar lógica de inicialización

**Ventaja:**
- Usuario puede ejecutar `vscode-init .` en proyecto Godot existente
- No necesita recordar `--godot`
- Es opt-out, no opt-in

---

## 📊 Resumen de archivos

### Archivos creados: 14

```
templates/godot/
├── .vscode/
│   ├── settings.json        [1]
│   ├── launch.json          [2]
│   └── tasks.json           [3]
├── .editorconfig            [4]
└── .gitignore               [5]

templates/extensions/
└── godot.txt                [6]

templates/claude-md/
└── godot.md                 [7]

templates/commands/
├── godot-scene.md           [8]
├── godot-script.md          [9]
├── godot-signal.md          [10]
└── godot-export.md          [11]

docs/
└── godot.md                 [12]

Actualizados:
├── bin/vscode-init          [13]
├── README.md                [14]
└── CLAUDE.md                [15]
```

### Líneas de código añadidas

```
bin/vscode-init:      ~60 líneas
templates/*:          ~150 líneas (JSON/config)
templates/commands:   ~280 líneas (comandos)
templates/claude-md:  ~150 líneas
docs/godot.md:        ~320 líneas
README/CLAUDE:        ~10 líneas
────────────────────────────────
TOTAL:                ~970 líneas
```

---

## ✅ Criterios de aceptación (completados)

- [x] `vscode-init` detecta proyectos Godot (presencia de `project.godot`)
- [x] Instala extensión `geequlim.godot-tools`
- [x] Genera `.vscode/settings.json` con configuración Godot
- [x] Crea estructura de templates en `.claude/commands/`
- [x] Genera `CLAUDE.md` con contexto de Godot
- [x] Comandos `/godot-scene`, `/godot-script`, `/godot-signal`, `/godot-export` funcionales
- [x] Documentación actualizada en README
- [x] Compatible con proyectos Godot 4.x
- [x] Soporte para GDScript y C#
- [x] EditorConfig y .gitignore específicos

---

## 🚀 Próximos pasos (opcional)

Posibles mejoras futuras:

1. **Detectar C# automáticamente:**
   - Si hay archivos .cs, instalar extensiones C# automáticamente

2. **Templates de escenas comunes:**
   - `templates/godot/scenes/player.tscn`
   - `templates/godot/scenes/ui.tscn`

3. **GUT (Godot Unit Test) integration:**
   - Configurar addon GUT
   - Comando `/godot-test` para generar tests

4. **Export presets template:**
   - Template básico de `export_presets.cfg`
   - Configuración para Linux/Windows/Web

5. **Shader templates:**
   - Comandos para crear shaders
   - Templates de shaders comunes (outline, dissolve, etc.)

---

## 📚 Referencias utilizadas

- [Godot Docs](https://docs.godotengine.org/en/stable/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [godot-vscode-plugin](https://github.com/godotengine/godot-vscode-plugin)
- [Godot Best Practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html)
- [EditorConfig](https://editorconfig.org/)

---

**Implementación completada el:** 2025-12-22
**Versión de vscode-init:** 1.1.0 (con soporte Godot)
**Versión de Godot soportada:** 4.x
