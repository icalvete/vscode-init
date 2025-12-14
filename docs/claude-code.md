# Guía de Claude Code para VS Code

Esta guía te ayudará a configurar y usar Claude Code en Visual Studio Code.

## Tabla de Contenidos

- [Requisitos previos](#requisitos-previos)
- [Instalación](#instalación)
- [Configuración inicial](#configuración-inicial)
- [Uso básico](#uso-básico)
- [Comandos slash](#comandos-slash)
- [Atajos de teclado](#atajos-de-teclado)
- [El archivo CLAUDE.md](#el-archivo-claudemd)
- [Tips avanzados](#tips-avanzados)
- [Solución de problemas](#solución-de-problemas)

---

## Requisitos previos

### Sistema
- **Node.js 18+** - Requerido para Claude Code CLI
- **VS Code 1.98.0+** - Versión mínima para la extensión
- Conexión estable a internet

### Cuenta
- **Claude Pro** o **Claude Max** (usa tu suscripción, sin costo extra)
- O una **API key** de Anthropic

### Verificar requisitos

```bash
# Node.js
node --version  # Debe ser >= 18

# VS Code
code --version  # Debe ser >= 1.98.0
```

---

## Instalación

### Opción 1: Usando vscode-config (recomendado)

```bash
# Instalación completa (CLI + extensión + settings)
vscode-config claude-code setup
```

### Opción 2: Manual

#### 1. Instalar Claude Code CLI

```bash
# Linux/macOS
curl -fsSL https://claude.ai/install.sh | bash

# Verificar instalación
claude --version
```

#### 2. Instalar extensión VS Code

```bash
code --install-extension anthropic.claude-code
```

O desde VS Code:
1. Abre la paleta de comandos: `Ctrl+Shift+P`
2. Escribe "Extensions: Install Extensions"
3. Busca "Claude Code"
4. Instala la extensión de Anthropic

#### 3. Extensiones complementarias (opcionales)

```bash
# Mejor visualización de diffs y Git
code --install-extension eamodio.gitlens

# Soporte Markdown mejorado
code --install-extension yzhang.markdown-all-in-one

# Errores inline en el editor
code --install-extension usernamehw.errorlens

# Corrector ortográfico
code --install-extension streetsidesoftware.code-spell-checker
```

---

## Configuración inicial

### Autenticación

#### Con cuenta Claude Pro/Max

```bash
claude login
```

Esto abrirá tu navegador para autenticarte con tu cuenta de Anthropic.

#### Con API key

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
```

O en VS Code settings.json:
```json
{
  "claudeCode.disableLoginPrompt": true
}
```

### Verificar estado

```bash
# Desde terminal
claude auth status

# O usando vscode-config
vscode-config claude-code status
```

---

## Uso básico

### Abrir Claude Code en VS Code

1. Abre la paleta de comandos: `Ctrl+Shift+P`
2. Escribe: `Claude Code: Open`
3. Pulsa Enter

![Icono de Claude en la barra lateral](../assets/01-panel-claude-code-inicio.png)

### Panel de Claude Code

Al abrirse, verás el panel listo para empezar:

![Panel de Claude Code abierto](../assets/02-panel-claude-code-inicio.png)

### Primera interacción

Escribe tu primera pregunta y Claude leerá automáticamente `CLAUDE.md` para entender el contexto del proyecto:

![Claude ha leído CLAUDE.md](../assets/03-panel-claude-code-inicio.png)

### Flujo de trabajo básico

1. **Abre un proyecto** en VS Code
2. **Abre el panel** de Claude Code (`Ctrl+Shift+P` → `Claude Code: Open`)
3. **Describe tu tarea** en lenguaje natural
4. **Revisa los cambios** propuestos (diffs)
5. **Acepta o rechaza** los cambios

<!-- TODO: captura 03-diff-aceptar-rechazar.png - Diff con botones Accept/Reject -->

### Mencionar archivos

Usa `@` para referenciar archivos:

```
@src/app.js ¿Puedes añadir validación de entrada?
```

<!-- TODO: captura 04-at-mention-autocompletado.png - Autocompletado de archivos con @ -->

### Adjuntar archivos/imágenes

- Usa el **file picker** en el panel
- Arrastra y suelta archivos
- Pega imágenes desde el clipboard

---

## Comandos slash

Los comandos slash te permiten acceder a funcionalidades avanzadas:

<!-- TODO: captura 05-menu-slash-commands.png - Menú desplegable de comandos slash -->

### Configuración

| Comando | Descripción |
|---------|-------------|
| `/config` | Abre interfaz de configuración |
| `/model` | Cambiar modelo de IA |
| `/status` | Ver versión, modelo, cuenta, conectividad |

### Conversación

| Comando | Descripción |
|---------|-------------|
| `/clear` | Limpiar historial de conversación |
| `/compact [instrucciones]` | Compactar conversación (reducir contexto) |
| `/export [archivo]` | Exportar conversación a archivo |
| `/context` | Ver uso actual de contexto |
| `/cost` | Ver estadísticas de tokens |

### Proyecto

| Comando | Descripción |
|---------|-------------|
| `/memory` | Editar archivo CLAUDE.md |
| `/review` | Solicitar revisión de código |
| `/security-review` | Revisión de seguridad de cambios |
| `/pr-comments` | Ver comentarios de PR de GitHub |

### Herramientas

| Comando | Descripción |
|---------|-------------|
| `/mcp` | Gestionar MCP servers |
| `/plugin` | Gestionar plugins |
| `/agents` | Gestionar subagents |
| `/terminal-setup` | Configurar Shift+Enter para nueva línea |
| `/vim` | Habilitar modo Vim |
| `/help` | Obtener ayuda de uso |

---

## Atajos de teclado

### En el panel de Claude Code

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+Click` en diff | Expandir detalles completos |
| Arrastrar panel | Más ancho = ver diffs inline |

### En terminal (CLI)

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+C` | Cancelar generación |
| `Ctrl+L` | Limpiar pantalla |
| `Ctrl+O` | Toggle salida verbose |
| `Esc` + `Esc` | Rewind (restaurar código) |
| `Shift+Tab` | Toggle modos (Auto/Plan/Normal) |
| `Up/Down` | Navegar historial |

### Nueva línea (multiline input)

| Método | Atajo |
|--------|-------|
| Quick escape | `\ + Enter` |
| macOS | `Option+Enter` |
| Después de `/terminal-setup` | `Shift+Enter` |
| Universal | `Ctrl+J` |

---

## El archivo CLAUDE.md

`CLAUDE.md` es un archivo especial que Claude lee automáticamente al iniciar una sesión en tu proyecto. Funciona como "memoria" del proyecto.

### Ubicación

```
mi-proyecto/
├── CLAUDE.md          # ← Archivo de contexto
├── src/
├── tests/
└── ...
```

### Estructura recomendada

```markdown
# Nombre del Proyecto

Descripción breve del proyecto.

## Stack tecnológico

- Lenguaje: Ruby 3.2
- Framework: Sinatra
- Base de datos: PostgreSQL
- Tests: RSpec

## Estructura del proyecto

```
src/
├── app.rb          # Punto de entrada
├── models/         # Modelos de datos
├── routes/         # Definición de rutas
└── services/       # Lógica de negocio
```

## Convenciones

- Usar snake_case para variables y métodos
- Documentar métodos públicos con YARD
- Tests para toda lógica de negocio

## Comandos útiles

```bash
# Ejecutar servidor
bundle exec ruby app.rb

# Ejecutar tests
bundle exec rspec

# Linter
bundle exec rubocop
```

## Notas importantes

- La API usa autenticación JWT
- Los endpoints públicos no requieren auth
- Rate limit: 100 requests/minuto
```

### Tips para CLAUDE.md

1. **Sé específico** - Incluye detalles técnicos relevantes
2. **Documenta convenciones** - Estilos de código, patrones usados
3. **Lista dependencias críticas** - Versiones específicas si importan
4. **Incluye comandos** - Para ejecutar, testear, deployar
5. **Actualízalo** - Usa `/memory` o `#` para añadir notas

### Añadir a memoria rápidamente

En el CLI, escribe `#` al inicio para añadir a CLAUDE.md:

```
# Recordar: los tests de integración requieren Docker
```

---

## Tips avanzados

### Extended Thinking

Activa "Extended Thinking" (botón inferior derecha del panel) para:
- Tareas complejas de arquitectura
- Debugging difícil
- Decisiones de diseño

### Plan Mode

Para cambios significativos, Claude te preguntará si quieres entrar en modo Plan:

![Claude pregunta si entrar en modo Plan](../assets/06-panel-claude-code-inicio.png)

- **Yes**: Claude planifica los cambios antes de ejecutarlos
- **No**: Claude ejecuta directamente
- **Tell Claude what to do instead**: Da instrucciones diferentes

> **Nota**: Claude hace preguntas interactivas durante el flujo. Responde según lo que necesites.

Al aceptar, Claude muestra el plan detallado:

![Plan propuesto por Claude](../assets/07-panel-claude-code-inicio.png)

Opciones de **"Accept this plan?"**:
- **Yes, and auto-accept**: Ejecuta todo automáticamente
- **Yes, and manually approve edits**: Revisa cada cambio individualmente
- **No, keep planning**: Refina el plan
- **Tell Claude what to do instead**: Cambia de dirección

Con **"Yes, and manually approve edits"**, Claude muestra cada diff y pregunta antes de guardar:

![Diff con pregunta para guardar](../assets/08-panel-claude-code-inicio.png)

### Auto-accept edits

Para flujos rápidos, activa auto-accept:
- Los cambios se aplican automáticamente
- Útil para refactoring masivo
- ⚠️ Cuidado en proyectos de producción

### MCP Servers

Los MCP servers configurados en CLI funcionan en la extensión:

```bash
# Configurar MCP server
claude mcp add github

# Ver servers activos
/mcp
```

### Múltiples sesiones

Puedes tener varios paneles de Claude Code abiertos:
- Uno para implementación
- Otro para tests
- Otro para documentación

### Checkpoints (próximamente)

Los checkpoints permitirán guardar/restaurar estados de conversación.

---

## Solución de problemas

### La extensión no se conecta

1. Verifica que el CLI está instalado:
   ```bash
   claude --version
   ```

2. Verifica autenticación:
   ```bash
   claude auth status
   ```

3. Reinicia VS Code

### "Claude Code CLI not found"

Asegúrate de que `claude` está en tu PATH:

```bash
# Añadir al PATH (Linux/macOS)
export PATH="$HOME/.claude/bin:$PATH"

# Verificar
which claude
```

### Errores de permisos

Si Claude no puede modificar archivos:

1. Verifica Workspace Trust está habilitado
2. Acepta el workspace como "confiable"
3. Revisa permisos del sistema de archivos

### Diffs no se muestran

- Arrastra el panel para hacerlo más ancho
- Los diffs inline requieren espacio suficiente

### Rate limiting

Si recibes errores de rate limit:
- Espera unos minutos
- Considera actualizar tu plan
- Usa `/compact` para reducir contexto

### Verificar estado completo

```bash
vscode-config claude-code status
```

---

## Recursos adicionales

- [Documentación oficial de Claude Code](https://docs.anthropic.com/claude-code)
- [VS Code Extension Marketplace](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code)
- [Anthropic Discord](https://discord.gg/anthropic)

---

## FAQ

### ¿Claude Code usa mi suscripción Pro/Max?

Sí, usa tu suscripción existente. No hay costo adicional.

### ¿Puedo usar Claude Code offline?

No, requiere conexión a internet para comunicarse con los servidores de Anthropic.

### ¿Es seguro usar Claude Code con código privado?

Anthropic tiene políticas de privacidad. Revisa sus términos de servicio. Para mayor seguridad, considera usar una API key dedicada.

### ¿Puedo usar Claude Code con otros editores?

El CLI funciona en cualquier terminal. La extensión es específica de VS Code.

### ¿Qué modelo usa Claude Code?

Por defecto usa Claude Sonnet. Puedes cambiar con `/model` a Opus u otros modelos disponibles.
