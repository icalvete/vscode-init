# Tasks API - Sinatra

API REST simple para gestión de tareas, construida con Ruby y Sinatra.

## Stack tecnológico

- **Lenguaje**: Ruby 3.2+
- **Framework**: Sinatra 3.x
- **Base de datos**: SQLite (desarrollo) / PostgreSQL (producción)
- **ORM**: Sequel
- **Tests**: RSpec + Rack::Test
- **Documentación**: YARD

## Estructura del proyecto

```
sinatra-api/
├── app.rb              # Punto de entrada, configuración Sinatra
├── config/
│   └── database.rb     # Configuración de base de datos
├── lib/
│   ├── models/         # Modelos Sequel
│   │   └── task.rb
│   └── routes/         # Definición de rutas
│       └── tasks.rb
├── spec/               # Tests RSpec
│   ├── spec_helper.rb
│   └── routes/
│       └── tasks_spec.rb
├── Gemfile
├── Rakefile
└── config.ru           # Rack config
```

## Convenciones de código

- **Nomenclatura**: snake_case para variables, métodos y archivos
- **Rutas REST**: `/api/v1/recursos`
- **Respuestas**: JSON con estructura `{ data: ..., error: ... }`
- **HTTP Status**: 200 OK, 201 Created, 400 Bad Request, 404 Not Found, 500 Error
- **Validaciones**: En el modelo, no en las rutas

## API Endpoints

| Método | Ruta | Descripción |
|--------|------|-------------|
| GET | `/api/v1/tasks` | Lista todas las tareas |
| GET | `/api/v1/tasks/:id` | Obtiene una tarea |
| POST | `/api/v1/tasks` | Crea una tarea |
| PUT | `/api/v1/tasks/:id` | Actualiza una tarea |
| DELETE | `/api/v1/tasks/:id` | Elimina una tarea |
| PATCH | `/api/v1/tasks/:id/complete` | Marca como completada |

## Modelo Task

```ruby
# Campos
- id: Integer (PK, auto)
- title: String (required, max 255)
- description: Text (optional)
- completed: Boolean (default: false)
- priority: Integer (1-5, default: 3)
- due_date: Date (optional)
- created_at: DateTime
- updated_at: DateTime
```

## Comandos útiles

```bash
# Instalar dependencias
bundle install

# Crear base de datos
bundle exec rake db:create

# Ejecutar migraciones
bundle exec rake db:migrate

# Ejecutar servidor (desarrollo)
bundle exec ruby app.rb
# o
bundle exec rackup -p 4567

# Ejecutar tests
bundle exec rspec

# Ejecutar tests con coverage
COVERAGE=true bundle exec rspec

# Linter
bundle exec rubocop
```

## Ejemplos de requests

```bash
# Crear tarea
curl -X POST http://localhost:4567/api/v1/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Mi tarea", "priority": 2}'

# Listar tareas
curl http://localhost:4567/api/v1/tasks

# Completar tarea
curl -X PATCH http://localhost:4567/api/v1/tasks/1/complete
```

## Notas para desarrollo

- La API no requiere autenticación (es un ejemplo didáctico)
- En desarrollo usa SQLite en `db/development.sqlite3`
- Los tests usan base de datos en memoria
- Formato de fechas: ISO 8601 (`2024-01-15`)
