---
description: Code review local de cambios uncommitted
---

Revisar cambios con `git diff` buscando:
- Seguridad: inyecciones, secrets, permisos
- Performance: N+1, loops ineficientes
- Legibilidad: nombres, funciones cortas, DRY
- Tests: cobertura, casos edge

Clasificar: CRÍTICO > ALTO > MEDIO > BAJO

Output: puntos positivos, problemas con severidad, sugerencias concretas.
