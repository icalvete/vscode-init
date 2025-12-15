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
| `--php` | Convenciones PHP (PSR-12, PHPDoc) |
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

Documenta código siguiendo las convenciones del proyecto.

```
/document @lib/models/user.rb
/document @src/utils/validation.py método validate_email
/document @lib/services/payment.js clase PaymentProcessor
```

### /review

Realiza code review local (sin GitHub).

```
/review
/review @lib/routes/tasks.rb
/review solo los cambios en models/
```

Busca problemas de:
- **Seguridad**: Inyecciones, secrets expuestos, permisos
- **Performance**: N+1 queries, loops ineficientes
- **Legibilidad**: Nombres claros, funciones cortas, DRY
- **Tests**: Cobertura, casos edge

### /explain

Explica código complejo de forma clara.

```
/explain @lib/services/payment.rb
/explain @src/utils/parser.py función parse_config
/explain este bloque de código [código pegado]
```

### /security

Auditoría de seguridad del código.

```
/security
/security @lib/routes/auth.rb
/security @src/api/ solo endpoints públicos
```

Busca:
- **Inyecciones**: SQL, Command, XSS, Path Traversal
- **Autenticación**: Contraseñas, tokens, sesiones
- **Datos sensibles**: Secrets en código, logs
- **Configuración**: Debug, CORS, headers, HTTPS

---

## Convenciones por lenguaje

### Ruby (`--ruby`)

| Elemento | Convención |
|----------|------------|
| Clases | `PascalCase` (`UserAccount`) |
| Métodos/variables | `snake_case` (`find_user`) |
| Constantes | `SCREAMING_SNAKE_CASE` (`MAX_RETRIES`) |
| Predicados | terminan en `?` (`empty?`, `valid?`) |
| Destructivos | terminan en `!` (`save!`, `delete!`) |
| Indentación | 2 espacios |
| Líneas | máx 100 caracteres |

**Idioms preferidos:**

```ruby
# Usar
array.map(&:method)
hash[:key] ||= default
%w[uno dos tres]

# Evitar
array.map { |x| x.method }
hash[:key] = hash[:key] || default
['uno', 'dos', 'tres']
```

### Python (`--python`)

| Elemento | Convención |
|----------|------------|
| Módulos/funciones/variables | `snake_case` |
| Clases | `PascalCase` |
| Constantes | `SCREAMING_SNAKE_CASE` |
| Privados | prefijo `_` (`_internal_method`) |
| Indentación | 4 espacios |
| Líneas | máx 99 caracteres |
| Tipos | Type hints obligatorios |

**Idioms preferidos:**

```python
# Usar
[x for x in items if x.valid]
with open('file') as f:
f"Hello {name}"

# Evitar
filter(lambda x: x.valid, items)
f = open('file'); f.close()
"Hello " + name
```

### JavaScript (`--javascript`)

| Elemento | Convención |
|----------|------------|
| Variables/funciones | `camelCase` (`getUserName`) |
| Clases/componentes | `PascalCase` (`UserAccount`) |
| Constantes | `SCREAMING_SNAKE_CASE` |
| Booleanos | prefijos `is`, `has`, `can` |
| Indentación | 2 espacios |
| Líneas | máx 100 caracteres |

**Idioms preferidos:**

```javascript
// Usar
const { name, age } = user;
const items = [...oldItems, newItem];
async/await

// Evitar
const name = user.name; const age = user.age;
oldItems.concat([newItem])
.then().catch()
```

### PHP (`--php`)

| Elemento | Convención |
|----------|------------|
| Clases | `PascalCase` (`UserAccount`) |
| Métodos/funciones | `camelCase` (`getUserName`) |
| Variables | `camelCase` (`$userName`) |
| Constantes | `SCREAMING_SNAKE_CASE` (`MAX_RETRIES`) |
| Namespaces | `PascalCase` (`App\Services`) |
| Indentación | 4 espacios |
| Líneas | máx 120 caracteres |

**Idioms preferidos:**

```php
// Usar
$result = $array['key'] ?? 'default';
$name = $user?->getName();
match($status) { 'active' => true, default => false };

// Evitar
$result = isset($array['key']) ? $array['key'] : 'default';
$name = $user !== null ? $user->getName() : null;
switch/case largo
```

### Ruby on Rails (`--rails`)

Implica `--ruby` automáticamente.

| Elemento | Convención |
|----------|------------|
| Controllers | Thin (5-7 líneas por action) |
| Models | Fat (lógica de negocio aquí) |
| Views | Sin queries, solo helpers |
| Lógica compleja | Service Objects |
| Queries complejas | Query Objects |

**Seguridad:**

```ruby
# Strong Parameters siempre
params.require(:user).permit(:name, :email)

# Placeholders para SQL (evitar inyección)
User.where('email = ?', email)

# No desactivar CSRF
protect_from_forgery
```

**Performance:**

```ruby
# Evitar N+1
User.includes(:posts).each { |u| u.posts }

# Grandes volúmenes
User.find_each(batch_size: 1000) { |u| process(u) }

# Background jobs
ProcessOrderJob.perform_later(order_id)
```

---

## Formatos de documentación

### Ruby: YARD

```ruby
# Descripción del método
#
# @param name [String] descripción del parámetro
# @return [Boolean] descripción del retorno
# @raise [ArgumentError] cuándo se lanza
# @example
#   method_name('ejemplo') #=> true
def method_name(name)
  # ...
end
```

### Python: Google-style docstrings

```python
def function(param1: str, param2: int) -> bool:
    """Descripción breve del método.

    Args:
        param1: Descripción del parámetro.
        param2: Descripción del parámetro.

    Returns:
        Descripción del valor de retorno.

    Raises:
        ValueError: Cuándo se lanza.

    Example:
        >>> function('test', 42)
        True
    """
```

### JavaScript: JSDoc

```javascript
/**
 * Descripción del método.
 *
 * @param {string} name - Descripción del parámetro
 * @param {number} [age=0] - Parámetro opcional con default
 * @returns {boolean} Descripción del retorno
 * @throws {Error} Cuándo se lanza
 * @example
 * functionName('test', 42) // => true
 */
function functionName(name, age = 0) {
  // ...
}
```

### PHP: PHPDoc

```php
/**
 * Descripción del método.
 *
 * @param string $name Descripción del parámetro
 * @param int|null $age Parámetro opcional
 * @return bool Descripción del retorno
 * @throws InvalidArgumentException Cuándo se lanza
 */
public function methodName(string $name, ?int $age = null): bool
{
    // ...
}
```

---

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
