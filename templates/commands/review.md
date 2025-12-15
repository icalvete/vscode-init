---
description: Revisa el código del proyecto (revisión local, sin GitHub)
---

Realiza una revisión de código **local** del proyecto.

## Proceso

1. Analiza los cambios uncommitted:
   ```bash
   git diff
   git status
   ```

2. Revisa el código buscando:
   - **Seguridad**: Inyecciones, secrets expuestos, permisos
   - **Performance**: N+1 queries, loops ineficientes, memoria
   - **Legibilidad**: Nombres claros, funciones cortas, DRY
   - **Tests**: Cobertura de casos edge, mocks apropiados

3. Clasifica los problemas:
   - **CRÍTICO**: Seguridad, pérdida de datos
   - **ALTO**: Bugs, performance severa
   - **MEDIO**: Refactoring, legibilidad
   - **BAJO**: Estilo, sugerencias menores

## Output

Presenta un resumen con:
- Puntos positivos del código
- Problemas encontrados (con severidad)
- Sugerencias de mejora concretas

## Importante

- Esta es una revisión **local** (no usa GitHub CLI)
- Enfócate en los cambios recientes, no en todo el proyecto
- Sé constructivo y específico en las sugerencias
