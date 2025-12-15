
## Ruby

### Convenciones de código

- **Clases**: `PascalCase` (`UserAccount`)
- **Métodos/variables**: `snake_case` (`find_user`)
- **Constantes**: `SCREAMING_SNAKE_CASE` (`MAX_RETRIES`)
- **Predicados**: terminan en `?` (`empty?`, `valid?`)
- **Métodos destructivos**: terminan en `!` (`save!`, `delete!`)
- **Indentación**: 2 espacios
- **Líneas**: máximo 100 caracteres

### Idioms Ruby

```ruby
# Preferir
array.map(&:method)
hash[:key] ||= default
%w[uno dos tres]

# Evitar
array.map { |x| x.method }
hash[:key] = hash[:key] || default
['uno', 'dos', 'tres']
```

### Documentación

Usar YARD:

```ruby
# Descripción del método
#
# @param name [String] descripción del parámetro
# @return [Boolean] descripción del retorno
# @raise [ArgumentError] cuándo se lanza
# @example
#   method_name('ejemplo') #=> true
```

### Comandos útiles

```bash
# Ejecutar archivo
ruby archivo.rb

# Consola interactiva
irb

# Gestión de gems
bundle install
bundle update

# Tests
bundle exec rspec
bundle exec rspec spec/models/

# Linter
bundle exec rubocop
bundle exec rubocop -a  # auto-fix
```

