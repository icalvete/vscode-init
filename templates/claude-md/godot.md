## Godot Engine 4.x

### Engine Version
Godot 4.x

### Languages
- **GDScript** (primary)
- **C#** (optional)

### Architecture Patterns

#### Scene Tree
- Use scene composition over inheritance
- Keep scenes focused and reusable
- Signal-based communication between nodes
- Root node types: Node2D (2D games), Node3D (3D games), Control (UI)

#### GDScript Conventions
- **Variables/functions:** snake_case
- **Classes:** PascalCase
- **Private members:** prefix with underscore `_private_var`
- **Type hints:** always use them `var speed: float = 200.0`
- **Exports:** `@export var health: int = 100`
- **Node references:** use `@onready var sprite = $Sprite2D`

#### Signals
- Name signals in past tense: `enemy_died`, `item_collected`
- Prefer signals over direct node references
- Document signal parameters with comments

### File Organization
```
project/
├── scenes/          # .tscn scene files
│   ├── player/
│   ├── enemies/
│   └── ui/
├── scripts/         # .gd script files
│   ├── player/
│   ├── enemies/
│   └── systems/
├── resources/       # .tres resource files
├── assets/
│   ├── sprites/
│   ├── audio/
│   ├── fonts/
│   └── shaders/
└── addons/          # Third-party plugins
```

### Node Lifecycle Methods
```gdscript
func _ready():
    # Called when node enters scene tree (initialization)

func _process(delta):
    # Called every frame (variable time)
    # Use for: input, animations, non-physics logic

func _physics_process(delta):
    # Called every physics tick (fixed timestep, 60 FPS default)
    # Use for: movement, physics, collisions
```

### Common Patterns

#### Signal Connection
```gdscript
# In _ready():
button.pressed.connect(_on_button_pressed)
enemy.died.connect(_on_enemy_died)

func _on_button_pressed():
    print("Button clicked")

func _on_enemy_died(enemy_name: String):
    print(enemy_name, " died")
```

#### Node References
```gdscript
# Prefer @onready over hardcoded paths
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var animation: AnimationPlayer = $AnimationPlayer

# Access parent or children
var parent_node = get_parent()
var child = get_node("ChildName")
```

#### Input Handling
```gdscript
func _process(delta):
    # Check continuous input
    if Input.is_action_pressed("move_right"):
        position.x += speed * delta

func _input(event):
    # Check discrete input events
    if event.is_action_pressed("jump"):
        jump()
```

#### Movement (CharacterBody2D)
```gdscript
extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
    # Gravity
    if not is_on_floor():
        velocity.y += gravity * delta

    # Jump
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    # Movement
    var direction = Input.get_axis("move_left", "move_right")
    velocity.x = direction * speed

    move_and_slide()
```

### C# Conventions (si se usa)
- **Namespace:** match project name
- **Classes:** PascalCase
- **Methods/properties:** PascalCase (C# standard)
- **Private fields:** `_camelCase` with underscore
- **Async methods:** suffix with `Async`

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

### Testing
- Use **GUT** (Godot Unit Test) addon for unit tests
- Manual testing: F5 (run project), F6 (run current scene)
- Debug with breakpoints and `print()` statements

### Performance
- Use object pooling for frequently spawned objects (bullets, particles)
- Minimize `_process` calls, prefer signals for event-driven logic
- Profile with Godot's built-in profiler: Debug → Profiler
- Use `@tool` for editor scripts that run in editor

### Common Godot Commands
- F5: Run project
- F6: Run current scene
- F7: Step into (debugging)
- F10: Step over (debugging)
- Ctrl+D: Duplicate selected nodes
- Ctrl+Shift+D: Duplicate scene
