
## Python

### Convenciones de código (PEP 8)

- **Módulos/funciones/variables**: `snake_case` (`user_account`)
- **Clases**: `PascalCase` (`UserAccount`)
- **Constantes**: `SCREAMING_SNAKE_CASE` (`MAX_RETRIES`)
- **Privados**: prefijo `_` (`_internal_method`)
- **Indentación**: 4 espacios
- **Líneas**: máximo 99 caracteres

### Idioms Python

```python
# Preferir
[x for x in items if x.valid]
with open('file') as f:
f"Hello {name}"

# Evitar
filter(lambda x: x.valid, items)
f = open('file'); f.close()
"Hello " + name
```

### Type hints

```python
def process_user(user_id: int, active: bool = True) -> dict[str, Any]:
    ...
```

### Documentación

Usar Google-style docstrings:

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

### Comandos útiles

```bash
# Ejecutar
python archivo.py

# Entorno virtual
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# Dependencias
pip install -r requirements.txt
pip freeze > requirements.txt

# Tests
pytest
pytest -v tests/

# Linter/formatter
black .
flake8
mypy .
```

