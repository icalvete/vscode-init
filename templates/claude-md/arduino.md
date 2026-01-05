## Arduino

### Board Support
Arduino y compatibles (ESP32, ESP8266, STM32, etc.)

### Language
C/C++ (Arduino Framework)

### Architecture Patterns

#### Sketch Structure
- Función `setup()` para inicialización (se ejecuta una vez)
- Función `loop()` para lógica principal (se ejecuta continuamente)
- Evitar `delay()`, usar `millis()` para timing no bloqueante
- Separar código en funciones específicas para cada tarea

#### Naming Conventions
- **Variables:** camelCase
- **Constants:** UPPER_CASE o kCamelCase
- **Functions:** camelCase
- **Pin defines:** descriptivos (LED_PIN, SENSOR_PIN)

#### Code Organization
```cpp
// Constants and pin definitions
const int LED_PIN = 13;
const int BUTTON_PIN = 2;

// Global variables
int sensorValue = 0;
unsigned long lastUpdate = 0;

// Setup: runs once
void setup() {
  Serial.begin(9600);
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
}

// Loop: runs continuously
void loop() {
  // Non-blocking timing
  if (millis() - lastUpdate >= 1000) {
    lastUpdate = millis();
    updateSensor();
  }
}

// Helper functions
void updateSensor() {
  sensorValue = analogRead(A0);
  Serial.println(sensorValue);
}
```

### File Organization
```
project/
├── project.ino       # Main sketch (must match folder name)
├── config.h          # Configuration and constants
├── sensors.ino       # Sensor-related functions
├── actuators.ino     # Motor/LED/output functions
├── communication.ino # Serial/WiFi/Bluetooth
└── src/              # Optional: compiled recursively
    └── utils/        # Helper libraries
```

### Common Patterns

#### Non-Blocking Timing
```cpp
// Bad: blocking delay
delay(1000);  // Blocks everything

// Good: non-blocking millis
unsigned long lastBlink = 0;
const unsigned long BLINK_INTERVAL = 1000;

void loop() {
  unsigned long currentMillis = millis();

  if (currentMillis - lastBlink >= BLINK_INTERVAL) {
    lastBlink = currentMillis;
    digitalWrite(LED_PIN, !digitalRead(LED_PIN));
  }
}
```

#### State Machine
```cpp
enum State {
  IDLE,
  READING,
  PROCESSING,
  SENDING
};

State currentState = IDLE;

void loop() {
  switch (currentState) {
    case IDLE:
      if (checkCondition()) {
        currentState = READING;
      }
      break;

    case READING:
      readSensors();
      currentState = PROCESSING;
      break;

    case PROCESSING:
      processData();
      currentState = SENDING;
      break;

    case SENDING:
      sendData();
      currentState = IDLE;
      break;
  }
}
```

#### Debouncing
```cpp
const int BUTTON_PIN = 2;
const unsigned long DEBOUNCE_DELAY = 50;

int buttonState = HIGH;
int lastButtonState = HIGH;
unsigned long lastDebounceTime = 0;

void loop() {
  int reading = digitalRead(BUTTON_PIN);

  if (reading != lastButtonState) {
    lastDebounceTime = millis();
  }

  if ((millis() - lastDebounceTime) > DEBOUNCE_DELAY) {
    if (reading != buttonState) {
      buttonState = reading;

      if (buttonState == LOW) {
        // Button pressed
        handleButtonPress();
      }
    }
  }

  lastButtonState = reading;
}
```

#### Interrupt Service Routine (ISR)
```cpp
volatile int counter = 0;

void setup() {
  pinMode(2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2), buttonISR, FALLING);
}

void loop() {
  // Main code
  if (counter > 0) {
    Serial.print("Button pressed ");
    Serial.print(counter);
    Serial.println(" times");
  }
}

void buttonISR() {
  // Keep ISR short and fast
  counter++;
}
```

### Serial Communication
```cpp
void setup() {
  Serial.begin(9600);  // Standard baud rate
  while (!Serial) {    // Wait for Serial (only needed for Leonardo/Micro)
    ;
  }
}

void loop() {
  // Read from Serial
  if (Serial.available() > 0) {
    String input = Serial.readStringUntil('\n');
    Serial.print("Received: ");
    Serial.println(input);
  }

  // Write to Serial
  Serial.print("Value: ");
  Serial.println(analogRead(A0));
}
```

### Memory Management
```cpp
// Use F() macro for strings in flash memory
Serial.println(F("This string stays in flash, saves RAM"));

// Use PROGMEM for large constant data
const int data[] PROGMEM = {100, 200, 300, 400};

// Read from PROGMEM
int value = pgm_read_word(&data[0]);

// Check free RAM
int freeRam() {
  extern int __heap_start, *__brkval;
  int v;
  return (int) &v - (__brkval == 0 ? (int) &__heap_start : (int) __brkval);
}
```

### Common Libraries
```cpp
// Standard Arduino libraries
#include <Wire.h>           // I2C communication
#include <SPI.h>            // SPI communication
#include <Servo.h>          // Servo motors
#include <EEPROM.h>         // Non-volatile storage
#include <SoftwareSerial.h> // Additional serial ports

// Popular third-party libraries
#include <WiFi.h>           // WiFi (ESP32/ESP8266)
#include <PubSubClient.h>   // MQTT
#include <ArduinoJson.h>    // JSON parsing
#include <Adafruit_Sensor.h> // Sensor abstraction
```

### Best Practices

#### Power Management
```cpp
#include <avr/sleep.h>
#include <avr/power.h>

void enterSleep() {
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  sleep_enable();
  sleep_mode();
  sleep_disable();
}
```

#### Watchdog Timer
```cpp
#include <avr/wdt.h>

void setup() {
  wdt_enable(WDTO_2S);  // 2 second timeout
}

void loop() {
  // Reset watchdog
  wdt_reset();

  // Your code here
}
```

#### Pin Mode Best Practices
```cpp
// Always set pinMode in setup()
pinMode(LED_PIN, OUTPUT);
pinMode(BUTTON_PIN, INPUT_PULLUP);  // Use internal pullup when available

// Use descriptive names
const int LED_BUILTIN = 13;  // Usually built-in LED
const int A0 = 14;           // Analog pin
```

### Debugging

#### Serial Monitor
```cpp
void setup() {
  Serial.begin(9600);
  Serial.println(F("=== Sketch Started ==="));
  Serial.print(F("Free RAM: "));
  Serial.println(freeRam());
}

void debugVariable(const char* name, int value) {
  Serial.print(name);
  Serial.print(": ");
  Serial.println(value);
}
```

#### LED Blinking Patterns
```cpp
// Quick visual debugging
void blinkError() {
  for (int i = 0; i < 3; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(100);
    digitalWrite(LED_PIN, LOW);
    delay(100);
  }
}
```

### Performance Tips
- Avoid floating-point math when possible (use integers)
- Use `const` for constants (compiler can optimize)
- Prefer `byte` over `int` for small values (0-255)
- Use bit operations for flags: `|=`, `&=`, `~`
- Cache function results instead of recalculating
- Minimize Serial.print() calls (they're slow)

### Common Arduino Commands
```bash
# With Arduino IDE
arduino-cli compile --fqbn arduino:avr:uno sketch/
arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:uno sketch/
arduino-cli monitor -p /dev/ttyACM0

# List connected boards
arduino-cli board list

# Install libraries
arduino-cli lib install "WiFi" "PubSubClient"

# Search for boards
arduino-cli board search uno
```

### Pin Reference (Arduino Uno)
- Digital pins: 0-13 (0-1 used for Serial)
- Analog pins: A0-A5 (can also be used as digital 14-19)
- PWM pins: 3, 5, 6, 9, 10, 11 (marked with ~)
- I2C: A4 (SDA), A5 (SCL)
- SPI: 10 (SS), 11 (MOSI), 12 (MISO), 13 (SCK)
- Interrupts: 2, 3
