# Guía de vscode-init

`vscode-init` inicializa proyectos con configuración lista para usar con Claude Code.

## Instalación

```bash
git clone https://github.com/icalvete/vscode-init.git
cd vscode-init
sudo make install

# O sin sudo (instala en ~/.local/bin)
make install PREFIX=~/.local
```

## Uso básico

```bash
# Crear proyecto básico
vscode-init ~/proyectos/mi-app

# Con lenguaje específico
vscode-init ~/proyectos/mi-app --ruby
vscode-init ~/proyectos/mi-app --python
vscode-init ~/proyectos/mi-app --javascript

# Con framework
vscode-init ~/proyectos/mi-app --rails

# Con MCP
vscode-init ~/proyectos/mi-app --mcp-github
vscode-init ~/proyectos/mi-app --mcp-postgres

# Combinaciones
vscode-init ~/proyectos/mi-app --rails --mcp-github --mcp-postgres
vscode-init ~/proyectos/mi-app --ruby --python  # Lenguajes combinables
```

## Opciones disponibles

| Opción | Descripción |
|--------|-------------|
| `--ruby` | Convenciones Ruby (YARD, rubocop) |
| `--python` | Convenciones Python (PEP8, docstrings) |
| `--javascript` | Convenciones JavaScript (JSDoc, ESLint) |
| `--rails` | Ruby on Rails (implica --ruby) |
| `--mcp-github` | Configura MCP para GitHub API |
| `--mcp-postgres` | Configura MCP para PostgreSQL |
| `--help` | Muestra ayuda |

## Estructura generada

```
mi-proyecto/
├── CLAUDE.md                # Contexto del proyecto
├── .claude/
│   ├── commands/            # Comandos personalizados
│   │   ├── document.md      # /document
│   │   └── review.md        # /review
│   └── mcp.json             # Configuración MCP (si se usa --mcp-*)
└── .vscode/
    └── settings.json        # Settings del lenguaje
```

## CLAUDE.md

El archivo `CLAUDE.md` es el contexto que Claude Code lee automáticamente. Incluye:

- Nombre del proyecto
- Convenciones del lenguaje seleccionado
- Comandos útiles
- Estructura del proyecto

### Ejemplo con --ruby --rails

```markdown
# mi-proyecto

Proyecto configurado con vscode-init para Claude Code.

## Ruby

### Convenciones de código
- Clases: PascalCase
- Métodos/variables: snake_case
...

## Ruby on Rails

### Arquitectura MVC
- Controllers: Thin, máximo 5-7 líneas por action
...
```

## Comandos personalizados

### /document

Documenta código siguiendo las convenciones del proyecto:
- Ruby: YARD
- Python: Google-style docstrings
- JavaScript: JSDoc

### /review

Realiza code review local (sin GitHub):
- Analiza cambios uncommitted
- Busca problemas de seguridad, performance, legibilidad
- Sugiere mejoras concretas

## MCP (Model Context Protocol)

### GitHub

```bash
vscode-init ~/proyecto --mcp-github
```

Genera `.claude/mcp.json`:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "TU_TOKEN_AQUI"
      }
    }
  }
}
```

**Importante**: Edita el archivo y añade tu token de GitHub.

### PostgreSQL

```bash
vscode-init ~/proyecto --mcp-postgres
```

Genera configuración para conectar Claude a tu base de datos.

**Importante**: Edita `POSTGRES_URL` con tu conexión real.

## Lenguajes combinables

Puedes usar varios lenguajes en el mismo proyecto:

```bash
vscode-init ~/fullstack --ruby --javascript
```

Esto genera un CLAUDE.md con secciones para ambos lenguajes.

## Después de inicializar

1. `cd mi-proyecto`
2. `code .`
3. Abre Claude Code: `Ctrl+Shift+P` → "Claude Code: Open"
4. Claude ya conoce el contexto de tu proyecto

## Proyecto relacionado

[cursor-init](https://github.com/icalvete/cursor-init) - Lo mismo para Cursor IDE.
