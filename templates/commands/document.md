---
description: Documenta el código seleccionado siguiendo las convenciones del proyecto
---

Documenta el código siguiendo las convenciones del proyecto:

## Por lenguaje

- **Ruby**: YARD format (`@param`, `@return`, `@raise`, `@example`)
- **Python**: Google-style docstrings (`Args:`, `Returns:`, `Raises:`, `Example:`)
- **JavaScript**: JSDoc format (`@param`, `@returns`, `@throws`, `@example`)

## Qué incluir

1. **Descripción**: Qué hace el código (1-2 líneas)
2. **Parámetros**: Nombre, tipo, descripción
3. **Retorno**: Tipo y descripción
4. **Excepciones**: Cuándo se lanzan
5. **Ejemplos**: Uso básico

## Instrucciones

- Documenta solo lo que el usuario seleccione o indique
- Usa el idioma del proyecto (español si CLAUDE.md está en español)
- No modifiques la lógica del código, solo añade documentación

## Ejemplos de uso

```
/document @lib/models/user.rb
/document @src/utils/validation.py método validate_email
/document @lib/services/payment.js clase PaymentProcessor
```
