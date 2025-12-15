
## JavaScript

### Convenciones de código

- **Variables/funciones**: `camelCase` (`getUserName`)
- **Clases/componentes**: `PascalCase` (`UserAccount`)
- **Constantes**: `SCREAMING_SNAKE_CASE` (`MAX_RETRIES`)
- **Booleanos**: prefijos `is`, `has`, `can` (`isActive`, `hasPermission`)
- **Indentación**: 2 espacios
- **Líneas**: máximo 100 caracteres
- **Punto y coma**: consistente (con o sin, según proyecto)

### Idioms ES6+

```javascript
// Preferir
const { name, age } = user;
const items = [...oldItems, newItem];
const result = items.map(x => x.value);

// Evitar
const name = user.name; const age = user.age;
const items = oldItems.concat([newItem]);
const result = items.map(function(x) { return x.value; });
```

### Async/await

```javascript
// Preferir
async function fetchData() {
  const response = await fetch(url);
  return response.json();
}

// Evitar
function fetchData() {
  return fetch(url).then(r => r.json());
}
```

### Documentación

Usar JSDoc:

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
```

### Comandos útiles

```bash
# Ejecutar
node archivo.js

# Dependencias
npm install
npm install package-name
npm update

# Scripts del proyecto
npm run dev
npm run build
npm test

# Linter/formatter
npm run lint
npx eslint .
npx prettier --write .
```

