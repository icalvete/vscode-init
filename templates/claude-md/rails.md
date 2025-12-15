
## Ruby on Rails

### Arquitectura
- Controllers: thin (5-7 líneas por action)
- Models: fat (lógica de negocio)
- Views: sin queries, solo helpers
- Service Objects para lógica compleja
- Query Objects para queries complejas

### Seguridad
- Strong Parameters siempre
- SQL con placeholders: `where('x = ?', val)`
- No desactivar CSRF

### Performance
- `includes()` para evitar N+1
- `find_each` para grandes volúmenes
- Background jobs para tareas lentas

