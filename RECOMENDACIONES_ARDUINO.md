# Recomendaciones para integrar vscode-init con Arduino/PlatformIO

## Problema identificado

Cuando se ejecuta `vscode-init --arduino <directorio>`, se crea una estructura básica (`.vscode/`, `.claude/`, `CLAUDE.md`) pero **NO** se crea la estructura de proyecto PlatformIO (`platformio.ini`, `src/`, `lib/`, etc.).

Posteriormente, al usar PlatformIO IDE para crear un proyecto nuevo desde VS Code, este intenta crear una subcarpeta con toda la estructura, generando un conflicto:

```
arduino/                    ← vscode-init creó aquí
├── .vscode/
├── .claude/
├── CLAUDE.md
└── test_000/              ← PlatformIO creó aquí (subcarpeta)
    ├── platformio.ini
    ├── src/
    ├── lib/
    └── include/
```

Esto causa que:
- Claude Code esté en el directorio padre
- PlatformIO espere estar en el directorio hijo
- Los iconos de PlatformIO no aparezcan hasta abrir la subcarpeta

---

## Solución recomendada

### Opción 1: Workflow manual (RECOMENDADO para ahora)

1. **Crear primero el proyecto PlatformIO:**
   ```bash
   mkdir ~/mi_proyecto_arduino
   cd ~/mi_proyecto_arduino
   ~/.platformio/penv/bin/pio project init --board uno
   ```

2. **Aplicar vscode-init después:**
   ```bash
   vscode-init ~/mi_proyecto_arduino --arduino
   ```

3. **Abrir VS Code:**
   ```bash
   code ~/mi_proyecto_arduino
   ```

**Resultado:** Estructura correcta en un solo nivel.

```
mi_proyecto_arduino/
├── platformio.ini         ← PlatformIO
├── src/
│   └── main.cpp
├── lib/
├── include/
├── .vscode/               ← vscode-init
├── .claude/
└── CLAUDE.md
```

---

### Opción 2: Modificar vscode-init (MEJOR a largo plazo)

Añadir detección e integración automática con PlatformIO cuando se usa `--arduino`.

#### Cambios propuestos en vscode-init:

**1. Detectar si PlatformIO está instalado:**
```bash
if command -v pio &> /dev/null || [ -f ~/.platformio/penv/bin/pio ]; then
    USE_PLATFORMIO=true
fi
```

**2. Añadir flag opcional `--platformio`:**
```bash
vscode-init ~/mi_proyecto --arduino --platformio
```

**3. Si `--platformio` está presente:**
```bash
if [ "$USE_PLATFORMIO" = true ]; then
    # Ejecutar pio project init
    ~/.platformio/penv/bin/pio project init --board uno

    # Crear main.cpp básico
    cat > src/main.cpp << 'EOF'
#include <Arduino.h>

void setup() {
  // Inicialización
}

void loop() {
  // Loop principal
}
EOF
fi
```

**4. Actualizar settings.json de VS Code:**

Asegurar que `.vscode/settings.json` incluya configuración específica de PlatformIO:

```json
{
  "platformio-ide.autoRebuildAutocompleteIndex": true,
  "platformio-ide.disablePIOHomeStartup": false,
  "platformio-ide.useBuiltinPIOCore": true,
  "platformio-ide.activateOnlyOnPlatformIOProject": true,
  "files.associations": {
    "*.ino": "cpp",
    "*.pde": "cpp"
  }
}
```

---

### Opción 3: Crear comando específico `vscode-init-pio`

Crear un script wrapper que haga todo el proceso:

```bash
#!/bin/bash
# vscode-init-pio: Inicializar proyecto Arduino con PlatformIO

PROJECT_DIR="$1"
BOARD="${2:-uno}"  # Default: Arduino Uno

# Crear directorio
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Inicializar PlatformIO
~/.platformio/penv/bin/pio project init --board "$BOARD"

# Crear código inicial
cat > src/main.cpp << 'EOF'
#include <Arduino.h>

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
EOF

# Aplicar vscode-init
vscode-init "$PROJECT_DIR" --arduino

# Abrir VS Code
code "$PROJECT_DIR"
```

**Uso:**
```bash
vscode-init-pio ~/nuevo_proyecto uno
vscode-init-pio ~/proyecto_esp32 esp32dev
```

---

## Extensiones recomendadas para VS Code

Asegurar que `vscode-init --arduino` instale/recomiende:

1. **platformio-ide** (obligatorio)
2. **ms-vscode.cpptools** (C/C++ IntelliSense)
3. **ms-vscode.cpptools-extension-pack** (opcional, pack completo)
4. **twxs.cmake** (si se usan proyectos CMake)

---

## Placas comúnmente usadas

Para futura referencia de boards en PlatformIO:

| Placa | Board ID | Ejemplo |
|-------|----------|---------|
| Arduino Uno | `uno` | `pio project init --board uno` |
| Arduino Mega | `megaatmega2560` | `pio project init --board megaatmega2560` |
| Arduino Nano | `nanoatmega328` | `pio project init --board nanoatmega328` |
| ESP32 DevKit | `esp32dev` | `pio project init --board esp32dev` |
| ESP8266 | `esp12e` | `pio project init --board esp12e` |
| NodeMCU | `nodemcuv2` | `pio project init --board nodemcuv2` |
| STM32 Blue Pill | `bluepill_f103c8` | `pio project init --board bluepill_f103c8` |

---

## Comandos Claude Code específicos para Arduino

Considerar añadir comandos personalizados en `.claude/commands/`:

### `/arduino-blink`
Genera código básico de blink con millis() (no bloqueante).

### `/arduino-serial`
Genera código de ejemplo para comunicación serial.

### `/arduino-sensor`
Template para lectura de sensores analógicos.

### `/arduino-debug`
Añade código de debugging con Serial y LEDs.

---

## Testing del workflow

Antes de implementar cambios en vscode-init, probar manualmente:

```bash
# 1. Crear proyecto
mkdir ~/test_arduino_001
cd ~/test_arduino_001

# 2. Init PlatformIO
~/.platformio/penv/bin/pio project init --board uno

# 3. Aplicar vscode-init
vscode-init ~/test_arduino_001 --arduino

# 4. Verificar estructura
tree -a -L 2

# 5. Abrir VS Code
code ~/test_arduino_001

# 6. Verificar que:
#    - Aparecen iconos PlatformIO en status bar
#    - Claude Code funciona
#    - Compilación funciona
#    - Upload funciona
```

---

## Documentación para README de vscode-init

Añadir sección específica:

```markdown
### Arduino / PlatformIO Projects

For Arduino projects using PlatformIO:

1. Initialize PlatformIO project first:
   ```bash
   mkdir ~/my_arduino_project
   cd ~/my_arduino_project
   pio project init --board uno
   ```

2. Apply vscode-init configuration:
   ```bash
   vscode-init ~/my_arduino_project --arduino
   ```

3. Open in VS Code:
   ```bash
   code ~/my_arduino_project
   ```

**Note:** Do not run `vscode-init` first and then create a PlatformIO project
from VS Code UI, as this will create nested directories and cause integration issues.
```

---

## Checklist de implementación

- [ ] Decidir entre Opción 1 (manual), Opción 2 (integrado), u Opción 3 (wrapper)
- [ ] Modificar scripts de vscode-init si aplica
- [ ] Actualizar templates de `.vscode/settings.json` para Arduino
- [ ] Añadir comandos Claude específicos de Arduino (opcional)
- [ ] Actualizar README con workflow correcto
- [ ] Probar con múltiples placas (Uno, ESP32, etc.)
- [ ] Documentar en CLAUDE.md generado

---

## Workflow actual (temporal - NO RECOMENDADO)

El workflow que funcionó hoy pero que genera problemas:

```bash
# ❌ Esto crea conflictos
vscode-init --arduino ~/arduino
cd ~/arduino
# Crear proyecto desde PlatformIO UI → genera subcarpeta
# Mover archivos manualmente a raíz
```

**Problema:** PlatformIO crea `test_000/` dentro de `arduino/`, y hay que mover todo manualmente.

---

## Conclusión

**Para nuevos proyectos:** Usar workflow de Opción 1 (crear con `pio` primero, luego `vscode-init`).

**Para mejorar vscode-init:** Implementar Opción 2 o 3 para automatizar el proceso.

**Para este proyecto:** Ya funciona, dejar como está y continuar con el curso.
