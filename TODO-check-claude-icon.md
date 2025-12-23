# Verificar icono de Claude Code en barra de título

## Problema
En este entorno aparece un icono de Claude en la barra superior derecha del editor.
En el otro entorno no aparece. Queremos que aparezca.

## Comandos a ejecutar en el otro entorno

### 1. Verificar versión de la extensión
```bash
code --list-extensions --show-versions | grep claude
```
Esperado: `anthropic.claude-code@2.0.75` o superior

### 2. Verificar setting useTerminal
```bash
grep -i "claudeCode\|useTerminal" ~/.config/Code/User/settings.json
```
Si `claudeCode.useTerminal: true` → el icono no aparece (usa terminal)

### 3. Verificar si el icono está oculto manualmente
- Abre VS Code
- Click derecho en la barra de título (donde están los iconos)
- Busca "Claude Code" en el menú
- Si aparece desmarcado, márcalo para mostrarlo

### 4. Si nada funciona, reinstalar extensión
```bash
code --uninstall-extension anthropic.claude-code
code --install-extension anthropic.claude-code
```

### 5. Ejecutar setup completo
```bash
vscode-config claude-code setup
```

## Resultado esperado
Icono de Claude (✦) visible en la barra superior derecha del editor.
