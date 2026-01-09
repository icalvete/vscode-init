## C/C++

### Language Standards
C++17 / C++20 (modern C++)

### Build Systems
- **CMake** (recomendado)
- **Make** (tradicional)
- **Meson** (moderno, rápido)

### Architecture Patterns

#### Modern C++ Principles
- **RAII** (Resource Acquisition Is Initialization)
- **Smart Pointers** sobre raw pointers
- **Move Semantics** para eficiencia
- **const correctness** en toda la codebase
- **Type safety** usando el sistema de tipos

#### Naming Conventions (Google C++ Style)
- **Variables:** `snake_case`
- **Functions:** `PascalCase` o `camelCase` (consistente)
- **Classes:** `PascalCase`
- **Constants:** `kCamelCase` o `UPPER_CASE`
- **Namespaces:** `lowercase`
- **Private members:** `snake_case_`

#### Code Organization
```cpp
// main.cpp
#include <iostream>
#include <memory>
#include <vector>
#include <string>

// Usar namespaces para organizar código
namespace myapp {

class DataProcessor {
 public:
  DataProcessor() = default;
  ~DataProcessor() = default;

  // Disable copy, enable move
  DataProcessor(const DataProcessor&) = delete;
  DataProcessor& operator=(const DataProcessor&) = delete;
  DataProcessor(DataProcessor&&) = default;
  DataProcessor& operator=(DataProcessor&&) = default;

  void Process(const std::string& data) {
    // Implementation
  }

 private:
  std::vector<std::string> buffer_;
};

}  // namespace myapp

int main(int argc, char* argv[]) {
  auto processor = std::make_unique<myapp::DataProcessor>();
  processor->Process("example");
  return 0;
}
```

### File Organization (CMake)
```
project/
├── CMakeLists.txt         # Build configuration
├── src/
│   ├── main.cpp           # Entry point
│   ├── core/              # Core functionality
│   │   ├── processor.h
│   │   └── processor.cpp
│   └── utils/             # Utilities
│       ├── string_utils.h
│       └── string_utils.cpp
├── include/               # Public headers
│   └── myproject/
│       └── api.h
├── tests/                 # Unit tests
│   ├── CMakeLists.txt
│   └── test_processor.cpp
└── third_party/           # External dependencies
    └── CMakeLists.txt
```

### CMakeLists.txt Example
```cmake
cmake_minimum_required(VERSION 3.14)
project(MyProject VERSION 1.0.0 LANGUAGES CXX)

# C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Compiler warnings
if(MSVC)
  add_compile_options(/W4 /WX)
else()
  add_compile_options(-Wall -Wextra -Wpedantic -Werror)
endif()

# Source files
add_executable(myproject
  src/main.cpp
  src/core/processor.cpp
  src/utils/string_utils.cpp
)

target_include_directories(myproject
  PRIVATE src
  PUBLIC include
)

# Tests (opcional)
enable_testing()
add_subdirectory(tests)
```

### Common Patterns

#### Smart Pointers (RAII)
```cpp
#include <memory>

// Bad: raw pointer (manual management)
MyClass* obj = new MyClass();
delete obj;  // Easy to forget!

// Good: unique_ptr (single ownership)
auto obj = std::make_unique<MyClass>();
// Automatically deleted when out of scope

// Good: shared_ptr (shared ownership)
auto shared = std::make_shared<MyClass>();
auto another = shared;  // Reference counting

// Good: weak_ptr (non-owning reference)
std::weak_ptr<MyClass> weak = shared;
if (auto ptr = weak.lock()) {
  // Use ptr safely
}
```

#### Move Semantics
```cpp
#include <vector>
#include <string>

class Buffer {
 public:
  // Move constructor
  Buffer(Buffer&& other) noexcept
      : data_(std::move(other.data_)) {}

  // Move assignment
  Buffer& operator=(Buffer&& other) noexcept {
    if (this != &other) {
      data_ = std::move(other.data_);
    }
    return *this;
  }

 private:
  std::vector<std::string> data_;
};

// Usage
Buffer CreateBuffer() {
  Buffer buf;
  // ... fill buffer
  return buf;  // Move, not copy!
}

auto buffer = CreateBuffer();  // Efficient move
```

#### Range-based for loops
```cpp
#include <vector>

std::vector<int> numbers = {1, 2, 3, 4, 5};

// Read-only
for (const auto& num : numbers) {
  std::cout << num << '\n';
}

// Modify elements
for (auto& num : numbers) {
  num *= 2;
}

// With structured bindings (C++17)
std::map<std::string, int> ages = {{"Alice", 30}, {"Bob", 25}};
for (const auto& [name, age] : ages) {
  std::cout << name << ": " << age << '\n';
}
```

#### std::optional (C++17)
```cpp
#include <optional>
#include <string>

std::optional<std::string> FindUser(int id) {
  if (id == 42) {
    return "Alice";
  }
  return std::nullopt;  // No value
}

// Usage
if (auto user = FindUser(42)) {
  std::cout << "Found: " << *user << '\n';
} else {
  std::cout << "Not found\n";
}
```

#### Error Handling
```cpp
#include <stdexcept>
#include <system_error>

// Exceptions for exceptional cases
class FileError : public std::runtime_error {
 public:
  explicit FileError(const std::string& msg)
      : std::runtime_error(msg) {}
};

void ReadFile(const std::string& path) {
  if (!FileExists(path)) {
    throw FileError("File not found: " + path);
  }
  // ... read file
}

// Usage with RAII
void ProcessFile(const std::string& path) {
  try {
    ReadFile(path);
  } catch (const FileError& e) {
    std::cerr << "Error: " << e.what() << '\n';
    throw;  // Re-throw if needed
  }
}
```

#### Templates and Concepts (C++20)
```cpp
#include <concepts>
#include <type_traits>

// Concept: requires arithmetic type
template <typename T>
concept Arithmetic = std::is_arithmetic_v<T>;

// Function template with concept
template <Arithmetic T>
T Add(T a, T b) {
  return a + b;
}

// Class template
template <typename T>
class Container {
 public:
  void Add(T value) { data_.push_back(value); }

 private:
  std::vector<T> data_;
};
```

### STL Containers

#### Common Containers
```cpp
#include <vector>
#include <map>
#include <unordered_map>
#include <set>
#include <deque>

// Vector: dynamic array (use by default)
std::vector<int> numbers = {1, 2, 3};
numbers.push_back(4);

// Map: ordered key-value (red-black tree)
std::map<std::string, int> ages;
ages["Alice"] = 30;

// Unordered map: hash table (faster lookup)
std::unordered_map<int, std::string> users;
users[42] = "Alice";

// Set: unique sorted elements
std::set<int> unique_numbers = {1, 2, 2, 3};  // {1, 2, 3}

// Deque: double-ended queue
std::deque<int> queue;
queue.push_front(1);
queue.push_back(2);
```

### Algorithms
```cpp
#include <algorithm>
#include <numeric>
#include <ranges>  // C++20

std::vector<int> numbers = {5, 2, 8, 1, 9};

// Sort
std::sort(numbers.begin(), numbers.end());

// Find
auto it = std::find(numbers.begin(), numbers.end(), 8);

// Transform
std::vector<int> doubled(numbers.size());
std::transform(numbers.begin(), numbers.end(),
               doubled.begin(),
               [](int n) { return n * 2; });

// Accumulate (sum)
int sum = std::accumulate(numbers.begin(), numbers.end(), 0);

// C++20 Ranges (more readable)
auto even = numbers | std::views::filter([](int n) { return n % 2 == 0; });
```

### Threading and Concurrency
```cpp
#include <thread>
#include <mutex>
#include <future>
#include <atomic>

// Thread
void Worker() {
  std::cout << "Working...\n";
}

std::thread t(Worker);
t.join();  // Wait for completion

// Mutex for thread safety
std::mutex mtx;
int shared_data = 0;

void SafeIncrement() {
  std::lock_guard<std::mutex> lock(mtx);
  ++shared_data;
}

// Async with futures
std::future<int> result = std::async(std::launch::async, []() {
  return 42;
});
std::cout << result.get() << '\n';

// Atomic for lock-free operations
std::atomic<int> counter{0};
counter.fetch_add(1);
```

### Testing (Google Test)
```cpp
#include <gtest/gtest.h>

// Test case
TEST(MathTest, Addition) {
  EXPECT_EQ(2 + 2, 4);
  EXPECT_NE(2 + 2, 5);
}

// Test with fixture
class ProcessorTest : public ::testing::Test {
 protected:
  void SetUp() override {
    processor_ = std::make_unique<Processor>();
  }

  std::unique_ptr<Processor> processor_;
};

TEST_F(ProcessorTest, ProcessData) {
  EXPECT_TRUE(processor_->Process("test"));
}
```

### Common Build Commands
```bash
# CMake build
mkdir build && cd build
cmake ..
cmake --build .

# With options
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake -DCMAKE_CXX_COMPILER=clang++ ..

# Run tests
ctest
ctest --output-on-failure

# Install
cmake --install .

# Clean
rm -rf build/
```

### Debugging
```bash
# Compile with debug symbols
cmake -DCMAKE_BUILD_TYPE=Debug ..

# GDB
gdb ./myprogram
(gdb) break main
(gdb) run
(gdb) step
(gdb) print variable_name

# Valgrind (memory leaks)
valgrind --leak-check=full ./myprogram

# Address Sanitizer
cmake -DCMAKE_CXX_FLAGS="-fsanitize=address" ..
```

### Best Practices

#### const Correctness
```cpp
class MyClass {
 public:
  // Const method: doesn't modify object
  int GetValue() const { return value_; }

  // Non-const method: can modify
  void SetValue(int value) { value_ = value; }

 private:
  int value_;
};

// Const references for parameters (avoid copies)
void ProcessData(const std::vector<int>& data);
```

#### Header Guards
```cpp
// old_style.h
#ifndef OLD_STYLE_H_
#define OLD_STYLE_H_
// ... declarations
#endif  // OLD_STYLE_H_

// modern_style.h (C++20)
#pragma once
// ... declarations
```

#### Forward Declarations
```cpp
// Reduce compilation time
class Database;  // Forward declaration

class Service {
 public:
  void UseDatabase(const Database& db);

 private:
  Database* db_;  // Pointer to incomplete type OK
};
```

### Performance Tips
- Use `const` and `constexpr` aggressively
- Prefer stack allocation over heap (`MyClass obj` vs `new MyClass`)
- Use `std::move` for large objects
- Reserve vector capacity if size known: `vec.reserve(1000)`
- Use `emplace_back` instead of `push_back` for in-place construction
- Profile before optimizing: `perf`, `gprof`, or Instruments (macOS)
- Enable compiler optimizations: `-O3`, `-march=native`

### Common Pitfalls
- Dangling pointers/references after scope ends
- Forgetting to initialize variables
- Not using `const` references for read-only parameters
- Mixing signed/unsigned comparisons
- Not checking return values (especially allocation)
- Memory leaks (use smart pointers!)
- Data races in multithreaded code (use mutexes/atomics)
