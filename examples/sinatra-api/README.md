# Tasks API - Ejemplo de desarrollo con Claude Code

Este proyecto es un ejemplo didáctico para aprender a desarrollar con **Claude Code** en VS Code.

## Objetivo

Construir una API REST completa usando:
- Ruby + Sinatra
- TDD con RSpec
- Claude Code como asistente de desarrollo

## Requisitos

- Ruby 3.2+
- Bundler
- SQLite3
- Claude Code (CLI + extensión VS Code)

## Tutorial paso a paso

### Paso 1: Preparar el entorno

```bash
# Clonar el proyecto base
cd examples/sinatra-api

# Instalar dependencias
bundle install

# Verificar Claude Code
vscode-config claude-code status
```

### Paso 2: Abrir en VS Code con Claude Code

```bash
# Abrir VS Code
code .
```

1. Abre el panel de Claude Code (icono ✦)
2. Claude leerá automáticamente `CLAUDE.md`

### Paso 3: Crear la estructura inicial

Pide a Claude:

```
Crea la estructura básica del proyecto según CLAUDE.md:
1. Gemfile con las dependencias
2. config.ru para Rack
3. app.rb con configuración básica de Sinatra
```

### Paso 4: Configurar la base de datos

```
Configura Sequel con SQLite para desarrollo.
Crea la migración para la tabla tasks según el modelo en CLAUDE.md.
```

### Paso 5: Crear el modelo Task

```
Crea el modelo Task en lib/models/task.rb con:
- Validaciones según CLAUDE.md
- Métodos para marcar como completada
- Scopes para filtrar por estado y prioridad
```

### Paso 6: Implementar las rutas (TDD)

```
Implementa las rutas de la API usando TDD:
1. Primero escribe el test en spec/routes/tasks_spec.rb
2. Luego implementa la ruta en lib/routes/tasks.rb
Empezamos con GET /api/v1/tasks
```

Repite para cada endpoint.

### Paso 7: Refactoring

```
Revisa el código y sugiere mejoras:
- DRY en las rutas
- Manejo de errores consistente
- Documentación YARD
```

### Paso 8: Commits

```
Crea commits atómicos para cada feature implementada.
Usa conventional commits (feat:, fix:, refactor:, test:, docs:)
```

## Comandos Claude Code útiles

Durante el desarrollo, usa estos comandos:

| Comando | Uso |
|---------|-----|
| `/review` | Revisar código antes de commit |
| `/memory` | Actualizar CLAUDE.md con aprendizajes |
| `/compact` | Reducir contexto si la conversación es larga |
| `@archivo` | Referenciar archivos específicos |

## Estructura final esperada

```
sinatra-api/
├── CLAUDE.md
├── README.md
├── Gemfile
├── Gemfile.lock
├── Rakefile
├── config.ru
├── app.rb
├── config/
│   └── database.rb
├── db/
│   ├── migrations/
│   │   └── 001_create_tasks.rb
│   └── development.sqlite3
├── lib/
│   ├── models/
│   │   └── task.rb
│   └── routes/
│       └── tasks.rb
└── spec/
    ├── spec_helper.rb
    └── routes/
        └── tasks_spec.rb
```

## Tips para el tutorial

1. **Lee CLAUDE.md primero** - Claude lo usa como contexto
2. **Sé específico** - Describe exactamente qué quieres
3. **Revisa los diffs** - No aceptes cambios sin revisar
4. **Usa TDD** - Es más efectivo con Claude Code
5. **Haz commits frecuentes** - Checkpoints de tu progreso

## Aprende más

- [Guía completa de Claude Code](../docs/claude-code.md)
- [Documentación de Sinatra](https://sinatrarb.com/)
- [Documentación de Sequel](https://sequel.jeremyevans.net/)
