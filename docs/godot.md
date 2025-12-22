# Guía de vscode-init para Godot Engine

`vscode-init` soporta proyectos de **Godot Engine 4.x** con configuración optimizada para desarrollo de videojuegos con GDScript y C#.

## Características

- ✅ Detección automática de proyectos Godot (`project.godot`)
- ✅ Configuración VS Code para GDScript y C#
- ✅ Launch configurations para debugging
- ✅ Tasks para ejecutar y exportar
- ✅ Comandos custom de Claude Code para gamedev
- ✅ EditorConfig y .gitignore específicos

---

## Instalación

### Uso básico

```bash
# En proyecto Godot existente (detección automática)
vscode-init ~/proyectos/mi-juego

# En proyecto nuevo con flag explícito
vscode-init ~/proyectos/mi-juego --godot
```

### Instalación de extensiones

El comando ofrece instalar:

| Extensión | Descripción | Tipo |
|-----------|-------------|------|
| `geequlim.godot-tools` | LSP oficial de Godot (GDScript, debugging) | Obligatoria |
| `ms-dotnetcore.csharp` | Soporte C# (si usas C# en Godot) | Opcional |
| `ms-dotnettools.vscode-dotnet-runtime` | Runtime .NET | Opcional |
| `ggsimm.godot-shader-tools` | Syntax highlighting para shaders | Opcional |

---

## Estructura generada

```
mi-juego/
├── CLAUDE.md                    # Contexto Godot para Claude Code
├── .claude/
│   └── commands/
│       ├── godot-scene.md       # /godot-scene - Crear escenas
│       ├── godot-script.md      # /godot-script - Crear scripts
│       ├── godot-signal.md      # /godot-signal - Implementar signals
│       └── godot-export.md      # /godot-export - Exportar juego
├── .vscode/
│   ├── settings.json            # Configuración GDScript/C#
│   ├── launch.json              # Debug configurations
│   └── tasks.json               # Run/Export tasks
├── .editorconfig                # Tabs para GDScript, spaces para C#
└── .gitignore                   # Ignora .godot/, builds/, etc.
```

---

## Configuración aplicada

### settings.json

```json
{
  "files.associations": {
    "*.gd": "gdscript",
    "*.tscn": "godot-scene",
    "*.tres": "godot-resource"
  },
  "[gdscript]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": false,  // Godot usa tabs
    "editor.rulers": [100]
  },
  "godot_tools.gdscript_lsp_server_port": 6005,
  "files.exclude": {
    "**/.godot/": true,            // Archivos generados
    "**/.import/": true
  }
}
```

### launch.json

Dos configuraciones de debugging:

1. **GDScript Godot** - Ejecuta el proyecto completo
2. **Launch Current Scene** - Ejecuta solo la escena actual

Requiere que Godot esté abierto con el proyecto (el LSP debe estar corriendo en puerto 6007).

### tasks.json

Tareas disponibles:

- **Run Project**: F5 o `godot --path .`
- **Run Current Scene**: Ejecuta solo la escena abierta
- **Export Project (Linux)**: Exporta build para Linux

---

## Comandos custom de Claude Code

### `/godot-scene`

Crea una escena nueva con script adjunto siguiendo best practices.

**Ejemplo:**
```
/godot-scene
```

Claude preguntará:
- Nombre de la escena (ej: "Player", "Enemy")
- Tipo de nodo raíz (CharacterBody2D, Area2D, Control, etc.)
- Funcionalidad principal

Genera:
- Archivo .tscn con la escena
- Archivo .gd con script configurado
- Signals si son necesarios
- Variables @export para el inspector
- Lifecycle methods (_ready, _physics_process, etc.)

### `/godot-script`

Genera un script GDScript con todas las convenciones.

**Ejemplo:**
```
/godot-script
```

Genera script con:
- Type hints
- Signals tipados
- @export variables
- @onready node references
- Documentación ##
- Lifecycle methods según necesidad

### `/godot-signal`

Ayuda a implementar comunicación entre nodos via signals.

**Ejemplo:**
```
/godot-signal
```

Claude ayuda a:
- Definir signal en el emisor
- Conectar signal en el receptor
- Implementar handler function
- Documentar el flujo de comunicación

### `/godot-export`

Guía para configurar y exportar el juego.

**Ejemplo:**
```
/godot-export
```

Ayuda con:
- Configurar export presets
- Comando CLI para exportar
- Platform-specific settings
- Distribution checklist

---

## Convenciones de código

Las convenciones están en `CLAUDE.md` generado:

### GDScript

```gdscript
# Nomenclatura
var player_health: int = 100      # snake_case
const MAX_SPEED: float = 200.0    # SCREAMING_SNAKE_CASE
class_name PlayerController       # PascalCase

# Exports para inspector
@export var speed: float = 200.0
@export_range(0, 100) var health: int = 100

# Node references
@onready var sprite: Sprite2D = $Sprite2D

# Signals (past tense)
signal health_changed(new_value: int)
signal died

# Lifecycle
func _ready():
    pass  # Initialization

func _physics_process(delta):
    pass  # Physics/movement
```

### C# (opcional)

```csharp
using Godot;

public partial class Player : CharacterBody2D
{
    [Export] public float Speed { get; set; } = 200.0f;

    private Sprite2D _sprite;

    public override void _Ready()
    {
        _sprite = GetNode<Sprite2D>("Sprite2D");
    }
}
```

---

## Workflow con Claude Code

### 1. Crear nueva escena

```
/godot-scene

> Scene name: Enemy
> Root node type: CharacterBody2D
> Functionality: Flying enemy that shoots projectiles
```

Claude genera `scenes/enemies/enemy.tscn` y `scripts/enemies/enemy.gd`.

### 2. Implementar comportamiento

```
@enemy.gd implement movement that follows the player and shoots every 2 seconds
```

Claude implementa:
- Movement logic en `_physics_process`
- Timer para disparar
- Signal `projectile_fired`

### 3. Conectar signals

```
/godot-signal

> What event: Enemy shoots projectile
> Emitter: Enemy
> Receiver: ProjectileManager
> Data: spawn position, direction
```

Claude implementa toda la conexión.

### 4. Debugging

Usa las launch configurations:

1. Abre Godot con tu proyecto
2. En VS Code: F5 o Run → Start Debugging
3. Coloca breakpoints en .gd files
4. El debugger se conecta al Godot LSP (puerto 6007)

---

## Tips y mejores prácticas

### Performance

- Usa object pooling para bullets/particles
- Minimiza `_process`, prefiere signals
- Profile con Debug → Profiler en Godot

### Arquitectura

- Scene composition > inheritance
- Signals > direct references (`get_node()`)
- Separar logic en scenes/scripts/resources

### Organización

```
project/
├── scenes/
│   ├── player/
│   ├── enemies/
│   └── ui/
├── scripts/
│   ├── player/
│   ├── enemies/
│   └── systems/
├── resources/      # .tres files
└── assets/
    ├── sprites/
    ├── audio/
    └── shaders/
```

---

## Troubleshooting

### LSP no funciona

**Problema:** Autocompletado no aparece en GDScript

**Solución:**
1. Abre Godot con el proyecto
2. Verifica que el LSP está corriendo: Editor → Editor Settings → Network → Language Server → Port (debe ser 6005 o 6007)
3. Reinicia VS Code

### Debugging no conecta

**Problema:** Breakpoints no funcionan

**Verificar:**
1. Godot está abierto con el proyecto
2. Puerto correcto en launch.json (6007)
3. Extensión `geequlim.godot-tools` instalada

### Tabs vs Spaces

**Problema:** GDScript se formatea con spaces en vez de tabs

**Solución:**
- Verifica `.editorconfig` está presente
- En VS Code: Settings → "Detect Indentation" = false para GDScript

---

## Exportar juego

### Via VS Code Task

```
Ctrl+Shift+P → Tasks: Run Task → Export Project (Linux)
```

### Via comando

```bash
godot --headless --export-release "Linux/X11" builds/game.x86_64
```

### Plataformas soportadas

- Linux/X11
- Windows Desktop
- macOS
- Web (HTML5)
- Android
- iOS (requiere macOS + Xcode)

---

## Referencias

- [Godot Docs](https://docs.godotengine.org/en/stable/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [godot-vscode-plugin](https://github.com/godotengine/godot-vscode-plugin)
- [Godot Best Practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html)

---

## Proyecto relacionado

- [cursor-init](https://github.com/icalvete/cursor-init) - Proyecto hermano para Cursor IDE (también soporta Godot)
