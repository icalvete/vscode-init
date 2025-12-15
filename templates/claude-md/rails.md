
## Ruby on Rails

### Arquitectura MVC

- **Controllers**: Thin, máximo 5-7 líneas por action
- **Models**: Fat, contienen la lógica de negocio
- **Views**: Sin queries, usar helpers para presentación

### Estructura de directorios

```
app/
├── controllers/     # Controllers (thin)
├── models/          # Models (fat) + validaciones
├── views/           # ERB/Haml templates
├── helpers/         # View helpers
├── services/        # Service objects (lógica compleja)
├── jobs/            # Background jobs (Sidekiq/DelayedJob)
├── mailers/         # Action Mailer
└── channels/        # Action Cable (WebSockets)
```

### Patrones recomendados

```ruby
# Service Objects para lógica compleja
class CreateOrderService
  def call(user, items)
    # ...
  end
end

# Query Objects para queries complejas
class ActiveUsersQuery
  def call
    User.where(active: true).where('last_login > ?', 30.days.ago)
  end
end
```

### Seguridad

- **Strong Parameters**: Siempre usar `params.require(:model).permit(:field)`
- **CSRF**: No desactivar `protect_from_forgery`
- **SQL Injection**: Usar placeholders `where('field = ?', value)`
- **Mass Assignment**: Solo permitir campos explícitos

### Performance

```ruby
# Evitar N+1 queries
User.includes(:posts).each { |u| u.posts }

# Para grandes volúmenes
User.find_each(batch_size: 1000) { |u| process(u) }

# Background jobs para tareas lentas
ProcessOrderJob.perform_later(order_id)
```

### Comandos útiles

```bash
# Servidor de desarrollo
bin/rails server
bin/rails s

# Consola
bin/rails console
bin/rails c

# Generadores
bin/rails generate model User name:string email:string
bin/rails generate controller Users index show
bin/rails generate migration AddAgeToUsers age:integer

# Base de datos
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bin/rails db:rollback

# Tests
bin/rails test
bin/rails test test/models/
bundle exec rspec

# Rutas
bin/rails routes
bin/rails routes | grep users
```

### Migraciones

```ruby
# Añadir columna
add_column :users, :age, :integer, default: 0

# Añadir índice
add_index :users, :email, unique: true

# Añadir referencia
add_reference :posts, :user, foreign_key: true
```

