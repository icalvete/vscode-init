# CLAUDE.md

Este archivo proporciona contexto a Claude Code (claude.ai/code) para trabajar en este repositorio.

## Descripción

vscode-init proporciona dos herramientas bash para configurar Visual Studio Code con opciones de privacidad, seguridad y productividad optimizadas para Claude Code:

1. **vscode-init** - Inicializa proyectos con templates específicos por lenguaje, comandos personalizados y configuraciones MCP
2. **vscode-config** - Gestiona configuración global de VS Code (telemetría, workspace trust, auto-save, extensiones)

## Proyecto relacionado

- **cursor-init** (`/home/icalvete/cursor-init`) - Proyecto hermano para Cursor IDE que comparte la misma filosofía y estructura

## Comandos de desarrollo

### Probar cambios

```bash
# Probar vscode-init directamente (sin instalar)
./bin/vscode-init /tmp/test-project --ruby
./bin/vscode-init /tmp/test-godot --godot
./bin/vscode-init /tmp/test-arduino --arduino --board esp32dev

# Probar vscode-config
./bin/vscode-config show
./bin/vscode-config claude-code status
```

### Instalación

```bash
# Instalar en /usr/local/bin (requiere sudo)
sudo make install

# Instalar en directorio de usuario (sin sudo)
make install PREFIX=~/.local

# Desinstalar
make uninstall
```

**Importante:** La instalación crea symlinks a este directorio del repositorio. No muevas ni borres este directorio después de instalar.

## Arquitectura

### vscode-init (bin/vscode-init)

Script principal (~678 líneas) que inicializa proyectos. Funciones clave:

- **parse_args()** - Parsea flags de línea de comandos (`--ruby`, `--python`, `--arduino`, etc.)
- **copy_base()** - Crea CLAUDE.md desde `templates/claude-md/base.md`
- **copy_language()** - Añade secciones específicas de lenguaje a CLAUDE.md
- **copy_vscode_settings()** - Copia/mergea `templates/vscode/{lang}.json` en `.vscode/settings.json`
- **copy_godot_templates()** - Maneja la estructura compleja de templates de Godot (.vscode/, .editorconfig, .gitignore)
- **init_platformio()** - Inicializa proyectos PlatformIO para Arduino (ejecuta `pio project init`, crea src/main.cpp)
- **setup_mcp()** - Configura servidores Model Context Protocol (GitHub, PostgreSQL)
- **show_summary()** - Muestra resumen de instalación y ofrece instalar extensiones específicas del lenguaje

**Lógica de detección automática:**
- Godot: Detecta archivo `project.godot`
- Arduino: Detecta archivos `*.ino`
- C/C++: Detecta `CMakeLists.txt` o `Makefile`

### vscode-config (bin/vscode-config)

Gestor de configuración global de VS Code (~1128 líneas). Funciones clave:

- **cmd_setup()** - Aplica configuración de privacidad/seguridad/productividad a `~/.config/Code/User/settings.json`
  - Desactiva telemetría (VS Code + extensiones populares: RedHat, Julia, GitLens, AWS, Terraform)
  - Activa workspace trust, desactiva git autofetch
  - Activa auto-save, format-on-save, bracket colorization, sticky scroll
  - Modifica `argv.json` para desactivar crash reporter
- **cmd_claude_code_setup()** - Instala extensión Claude Code + extensiones complementarias
  - Obligatorias: `anthropic.claude-code`, `usernamehw.errorlens`, `esbenp.prettier-vscode`, `yzhang.markdown-all-in-one`
  - Opcionales: `eamodio.gitlens`, `streetsidesoftware.code-spell-checker`, path-intellisense, remote-ssh
  - Instala keybindings desde `templates/keybindings/claude-code.json`
- **cmd_backup()/cmd_restore()** - Hace backup de settings.json, keybindings.json, snippets, lista de extensiones
- **set_setting()/get_setting()** - Usa `jq` para leer/escribir configuraciones JSON

### Sistema de templates

**templates/claude-md/**: Secciones CLAUDE.md específicas por lenguaje
- `base.md` - Base mínima con placeholder `{PROJECT_NAME}`
- Módulos de lenguaje: `ruby.md`, `python.md`, `javascript.md`, `php.md`, `rails.md`, `godot.md`, `arduino.md`, `cpp.md`

**templates/vscode/**: Settings de VS Code específicos por lenguaje (formato JSON)
- Controla formateadores, linters, asociaciones de archivos, language servers

**templates/commands/**: Comandos personalizados de Claude Code (slash commands)
- `document.md`, `review.md`, `explain.md`, `security.md`
- Específicos de Godot: `godot-scene.md`, `godot-script.md`, `godot-signal.md`, `godot-export.md`
- Genérico: `project-info.md`

**templates/extensions/**: Listas de extensiones (un ID por línea, comentarios con `#`)
- `base.txt`, `ruby.txt`, `python.txt`, `javascript.txt`, `php.txt`, `godot.txt`, `arduino.txt`, `cpp.txt`

**templates/mcp/**: Configuraciones de servidores MCP
- `github.json` - Acceso a API de GitHub (requiere `GITHUB_TOKEN`)
- `postgres.json` - Acceso a base de datos PostgreSQL (requiere `POSTGRES_URL`)

**templates/keybindings/**: Atajos de teclado de VS Code
- `claude-code.json` - Ctrl+Alt+C (abrir Claude), Ctrl+Escape (toggle focus), Alt+K (@ mention)

**templates/godot/**: Estructura completa de proyecto Godot
- `.vscode/settings.json`, `.vscode/launch.json`, `.vscode/tasks.json`
- `.editorconfig`, `.gitignore`

### Detalles clave de implementación

**Merge de JSON:** Ambos scripts usan `jq -s '.[0] * .[1]'` para mergear archivos JSON en lugar de sobrescribir. Esto permite:
- Añadir configuración de lenguaje a .vscode/settings.json existente
- Mergear múltiples servidores MCP en un solo mcp.json
- Combinar keybindings sin perder personalizaciones del usuario

**Resolución de symlinks:** Ambos scripts resuelven symlinks usando un bucle while para encontrar el directorio real de templates:
```bash
while [[ -L "$SCRIPT_PATH" ]]; do
    SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
    SCRIPT_PATH="$(readlink "$SCRIPT_PATH")"
    [[ "$SCRIPT_PATH" != /* ]] && SCRIPT_PATH="$SCRIPT_DIR/$SCRIPT_PATH"
done
```

**Flujo de instalación de extensiones:**
1. Lee IDs de extensión desde `templates/extensions/{lang}.txt`
2. Verifica qué extensiones están ya instaladas con `code --list-extensions`
3. Muestra listas separadas de instaladas vs faltantes
4. Solo pregunta por instalar las faltantes

**Integración con PlatformIO:** Para proyectos Arduino, el script intenta ejecutar `pio project init` para crear platformio.ini, pero maneja gracefully la ausencia de PlatformIO mostrando instrucciones de instalación.

## Tareas comunes

### Añadir un nuevo lenguaje

1. Crear `templates/claude-md/{language}.md` con convenciones específicas del lenguaje
2. Crear `templates/vscode/{language}.json` con settings de VS Code
3. Crear `templates/extensions/{language}.txt` con IDs de extensiones
4. Añadir parseo de flag en función `parse_args()` de vscode-init
5. Añadir copiado de lenguaje en función `main()`
6. Actualizar README.md y docs/vscode-init.md

### Modificar settings aplicados por `vscode-config setup`

Editar función `cmd_setup()` en bin/vscode-config. Usar helper `set_setting()`:
```bash
set_setting '."path.to.setting"' '"value"'  # String
set_setting '."path.to.setting"' 'true'     # Boolean
set_setting '."path.to.setting"' '42'       # Number
```

### Añadir nuevos templates

Colocar templates en el directorio apropiado:
- Secciones CLAUDE.md → `templates/claude-md/`
- Settings de VS Code → `templates/vscode/`
- Comandos personalizados → `templates/commands/`
- Configs MCP → `templates/mcp/`

## Notas importantes

- **Dependencias:** Ambos scripts requieren `jq` para manipulación de JSON
- **Manejo de rutas:** vscode-init resuelve `~` y rutas relativas a rutas absolutas antes de procesar
- **Checks de seguridad:** vscode-init previene inicialización en `$HOME` o `/` para evitar accidentes
- **Creación de backups:** vscode-config crea automáticamente backups con timestamp antes de modificar settings
- **Output con colores:** Los scripts usan códigos ANSI (GREEN, YELLOW, RED, BLUE) con funciones helper: `ok()`, `info()`, `warn()`, `error()`
