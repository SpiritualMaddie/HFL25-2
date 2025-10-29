# HFL25-2 - Dart Learning Journey

A comprehensive collection of Dart projects demonstrating progressive learning from basic CLI applications to advanced architecture with API integration. This repository showcases the complete learning path in the Dart module of the Hybrid Development with Flutter course.

---

## Table of Contents

- [Project Overview](#-project-overview)
- [Project Progression](#-project-progression)
- [Quick Navigation](#-quick-navigation)
- [Technologies & Concepts](#-technologies--concepts)
- [Learning Outcomes](#-learning-outcomes)

---

## Project Overview

This repository contains four progressive projects, each building upon concepts from the previous one:

| Version | Name | Focus | Key Concepts |
|---------|------|-------|--------------|
| **v01** | Calculator | Dart Fundamentals | Functions, I/O, Error Handling |
| **v02** | HeroDex 3000 | Data Structures | Lists, Maps, Singleton Pattern |
| **v03** | HeroDex Advanced | Architecture | Models, Interfaces, Async/Await |
| **v04** | SuperHero Manager | API Integration | HTTP, JSON, Repository Pattern, Factory Pattern |

---

## Project Progression

### v01 - Calculator 🔢
**First Steps in Dart**

A simple CLI calculator that performs basic arithmetic operations.

#### Key Features
- Basic arithmetic (+, -, *, /)
- Input validation
- Error handling
- Continuous operation mode

#### Technologies
- Basic Dart syntax
- `stdin`/`stdout` for I/O
- `switch/case` statements
- Exception handling with `try/catch`

#### What I Learned
- How to write functions in Dart
- Data types (`int`, `double`, `String`, `bool`)
- Control flow (`if/else`, `while`, `switch`)
- Basic error handling patterns

[View v01 Project](./v01/)

---

### v02 - HeroDex 3000
**Introduction to Design Patterns**

A CLI application for managing superheroes with basic attributes.

#### Key Features
- Add heroes with `name`, `strength`, `species`, `alignment`
- View all heroes sorted by `strength`
- Search heroes by `name`
- Pre-loaded dummy data

#### Technologies
- `List<Map<String, dynamic>>` data structures
- Singleton pattern
- Repository pattern
- `forEach` and `where` for collections
- Sorting with comparators

#### What I Learned
- Complex data structures (nested Maps)
- Singleton pattern implementation
- Repository pattern for data management
- Code organization into modules
- Factory constructors

#### Architecture Highlights
```dart
HeroRepository (Singleton)
    ↓
List<Map<String, dynamic>>
    ↓
UI Layer
```

[View v02 Project](./v02/)

---

### v03 - HeroDex 3000 Advanced
**Model-Based Architecture**

A modular CLI application with complete model classes and interfaces.

#### Key Features
- Detailed hero creation with 40+ attributes
- Separate model classes for each data category
- JSON serialization/deserialization
- Interface-based architecture
- 10 pre-loaded mock heroes

#### Technologies
- Model classes (7 separate models)
- Abstract class as interface
- `implements` keyword
- JSON serialization (`toJson`/`fromJson`)
- Async/await pattern (`Future<T>`)
- Null-safety with `?` notation

#### What I Learned
- Model-based vs Map-based data structures
- Creating interfaces with abstract classes
- JSON serialization patterns
- Async programming fundamentals
- Composition over flat structures
- Separation of concerns

#### Architecture Highlights
```dart
Interface (HeroDataManaging)
    ↑
Manager (HeroDataManager - Singleton)
    ↓
Models (HeroModel, PowerstatsModel, etc.)
    ↓
UI Layer
```

#### Data Evolution
**v02:** `List<Map<String, dynamic>>`  
**v03:** `List<HeroModel>` with nested model classes

[View v03 Project](./v03/)

---

### v04 - SuperHero Manager
**Full-Stack Integration**

A CLI application with API integration, local storage, and advanced error handling.

#### Key Features
- **API Integration**: Fetch heroes from [SuperHero API](https://superheroapi.com/index.html)
- **Local Storage**: JSON file persistence
- **CR(U)D Operations**: Create, Read, Delete (almost full CRUD)
- **Duplicate Prevention**: No duplicate heroes based on `name`
- **Sorted Views**: Heroes and villains (and neutrals) separately
- **Retry Logic**: Automatic retry on failed requests
- **Environment Variables**: API key security with `.env`

#### Technologies
- HTTP requests with `http` package
- Environment variables with `dotenv`
- Factory Pattern for HTTP clients
- Dependency Injection
- Repository Pattern
- File I/O operations
- Advanced error handling with specific exceptions

#### What I Learned
- Making HTTP API requests
- Parsing JSON from external sources
- Managing API keys securely
- Factory Pattern for object creation
- Dependency Injection for testability
- File operations (read/write JSON)
- Advanced error handling strategies
- The HTTP client connection problem and solution

#### Architecture Highlights
```dart
Interface (ISuperHeroApiRepository, ILocalFileRepository, HeroDataManaging, IHttpClientFactory)
    ↑
Factory (HttpClientFactory)
    ↑
Repositories (SuperHeroApiRepository, LocalFileRepository)
    ↑
Manager (HeroDataManager - Singleton with DI)
    ↓
Models (HeroModel with 7 sub-models)
    ↓
UI Layer
```

#### The HTTP Client Challenge
**Problem:** SuperHero API closed connections between requests causing `ClientException`.

**Solution:** Factory Pattern creates new HTTP client per request while maintaining DI for testing.

```dart
class HttpClientFactory implements IHttpClientFactory {
  @override
  http.Client create() => http.Client();
}
```

#### Data Flow
```
User Input → UI Layer
    ↓
HeroDataManager (Business Logic)
    ↓
Repository (Data Access)
    ↓
External Source (API or Local JSON File)
```

[View v04 Project](./v04/)

---

## Quick Navigation

### Run Individual Projects

```bash
# v01 - Calculator
cd v01
dart pub get
dart run bin/v01.dart

# v02 - HeroDex Basic
cd v02
dart pub get
dart run bin/v02.dart

# v03 - HeroDex Advanced
cd v03
dart pub get
dart run bin/v03.dart

# v04 - SuperHero Manager (requires .env setup)
cd v04
dart pub get
# Create .env file with API_URL_WITH_KEY=https://superheroapi.com/api/YOUR_KEY
dart run bin/v04.dart
```

### Run Tests

```bash
# Run tests for any version
cd v0X
dart test
```

---

## Technologies & Concepts

### Dart Fundamentals
- ✅ Data types (int, double, String, bool, List, Map)
- ✅ Functions and parameters
- ✅ Control flow (if/else, switch/case, loops)
- ✅ Exception handling (try/catch/finally)
- ✅ Null-safety (`?`, `!`, `??`)

### Object-Oriented Programming
- ✅ Classes and constructors
- ✅ Factory constructors
- ✅ Abstract classes
- ✅ Interfaces (implements)
- ✅ Composition
- ✅ Encapsulation (private members with `_`)

### Design Patterns
- ✅ **Singleton Pattern** - Single instance management
- ✅ **Repository Pattern** - Data access abstraction
- ✅ **Factory Pattern** - Object creation control
- ✅ **Dependency Injection** - Loose coupling for testability

### Asynchronous Programming
- ✅ `Future<T>` - Asynchronous return types
- ✅ `async/await` - Non-blocking operations
- ✅ Error handling in async code
- ✅ Timeout handling

### External Integration
- ✅ HTTP requests with `http` package
- ✅ JSON parsing (`jsonDecode`, `jsonEncode`)
- ✅ JSON deserialization and serialization in models
- ✅ Environment variables with `dotenv`
- ✅ File I/O operations
- ✅ API integration patterns

### Architecture
- ✅ **Separation of Concerns** - Distinct layers (UI, Manager, Repository, Models)
- ✅ **Model-Based Architecture** - Type-safe data structures
- ✅ **Interface-Driven Design** - Contracts for implementations
- ✅ **Clean Architecture Principles** - Dependencies point inward

### Testing
- ✅ Unit testing with `test` package
- ✅ Mocking dependencies
- ✅ Test organization with `group`
- ✅ Assertions with `expect`

---

## Progression Summary

### By v01 (Calculator)
- Can write basic Dart programs
- Understand functions and control flow
- Handle user input and validation
- Implement basic error handling

### By v02 (HeroDex Basic)
- Work with complex data structures (`List<Map>`)
- Implement design patterns (Singleton, Repository)
- Organize code into modules
- Use functional programming concepts (forEach, where, sort)

### By v03 (HeroDex Advanced)
- Design model-based architectures
- Create and implement interfaces
- Use async/await for future operations
- Serialize/deserialize JSON
- Apply composition in models

### By v04 (SuperHero Manager)
- Integrate with external APIs
- Manage HTTP connections and errors
- Implement dependency injection
- Use factory pattern for object creation
- Handle file I/O operations
- Secure sensitive data (API keys)
- Apply retry logic for resilience

---

### Architecture Evolution

```
v01: Functions → main()

v02: Repository (Singleton) → UI

v03: Interface → Manager → Models → UI

v04: Factory → Repositories → Manager → Models → UI
         ↓
    External APIs & File System
```

### Data Structure Evolution

```
v01: Simple variables (double, String)
      ↓
v02: List<Map<String, dynamic>>
      ↓
v03: List<HeroModel> (with composition)
      ↓
v04: List<HeroModel> + JSON persistence + API integration
```

---

## Key Achievements

### Technical Skills
- ✅ Built 4 complete Dart applications
- ✅ Implemented 4 major design patterns
- ✅ Integrated with external REST API
- ✅ Wrote unit tests
- ✅ Applied clean architecture principles

### Problem Solving
- ✅ Solved HTTP connection pooling issue
- ✅ Implemented retry logic for resilience
- ✅ Designed testable architecture with DI
- ✅ Managed async operations effectively

### Best Practices
- ✅ Git workflow with feature branches
- ✅ Documentation (READMEs)
- ✅ Secure API key management
- ✅ Input validation and error handling
- ✅ Code organization and modularity

---

## Author

**Madde** - [GitHub](https://github.com/SpiritualMaddie)
ReadMes created with help from [ClaudeAI](https://claude.ai/) for a cleaner, more comprahensive and structured layout

Course: Hybrid Development with Flutter - Dart Module  
Institution: [Stockholms Tekniska Institut](https://www.sti.se/)  
Date: September - October 2025

---

## Repository Structure

```
HFL25-2/
├── v01/                    # Calculator (Fundamentals)
│   ├── bin/
|   |    └── v01.dart
│   ├── lib/
|   |   └── v01.dart
│   ├── test/
|   |   └── v01_test.dart
│   ├── pubspec.yaml
│   └── README.md
├── v02/                    # HeroDex Basic (Design Patterns)
│   ├── bin/
|   |   └── v02.dart
│   ├── lib/
│   |   ├── data/
|   |   |   └── dummy_data.dart
│   |   ├── repositories/
|   |   |   └── hero_repository.dart
│   |   ├── ui/
|   |   |   ├── application.dart
|   |   |   └── hero_ui.dart
│   |   ├── utils/
|   |   |   ├── console_utils.dart
|   |   |   ├── input_utils.dart
|   |   |   └── menu.dart
│   |   └── vaildators/
|   |       └── get_valid_int.dart
│   ├── test/
|   |   └── v02_test.dart
│   ├── pubspec.yaml
│   └── README.md
├── v03/                    # HeroDex Advanced (Architecture)
│   ├── bin/
|   |   └── v03.dart
│   ├── lib/
│   |   ├── data/
│   |   |   ├── models/
|   |   |   |   ├── appearance_model.dart
|   |   |   |   ├── biography_model.dart
|   |   |   |   ├── connections_model.dart
|   |   |   |   ├── hero_model.dar
|   |   |   |   ├── image_model.dart
|   |   |   |   ├── powerstats_model.dart
|   |   |   |   └── work_model.dart
|   |   |   ├── hero_mock_data.json
|   |   |   └── mock_data.dart
│   |   ├── managers/
|   |   |   ├── hero_data_manager.dart
|   |   |   ├── hero_data_managing.dart
|   |   |   └── mock_data_manager.dart
│   |   ├── ui/
|   |   |   ├── application.dart
|   |   |   └── hero_ui.dart
│   |   ├── utils/
|   |   |   ├── console_utils.dart
|   |   |   ├── get_model_input.dart
|   |   |   ├── input_utils.dart
|   |   |   └── menu.dart
│   |   └── vaildators/
|   |       └── get_valid_int.dart
│   ├── test/
|   |   └── v03_test.dart
│   ├── pubspec.yaml
│   └── README.md
├── v04/                    # SuperHero Manager (API Integration)
│   ├── bin/
|   |   └── v04.dart
│   ├── lib/
│   |   ├── data/
│   |   |   ├── factories/
|   |   |   |   └── http_client_factory.dart
│   |   |   ├── jsondata/
|   |   |   |   ├── hero_mock_data.json
|   |   |   |   └── super_hero_json.json
│   |   |   ├── models/
|   |   |   |   ├── appearance_model.dart
|   |   |   |   ├── biography_model.dart
|   |   |   |   ├── connections_model.dart
|   |   |   |   ├── hero_model.dar
|   |   |   |   ├── image_model.dart
|   |   |   |   ├── powerstats_model.dart
|   |   |   |   └── work_model.dart
│   |   |   ├── repositories/
|   |   |   |   ├── local_file_repository.dart
|   |   |   |   └── super_hero_api_repository.dart
|   |   |   └── mock_data.dart
│   |   ├── interfaces/
|   |   |   ├── hero_data_managing.dart
|   |   |   ├── ihttp_client_factory.dart
|   |   |   ├── ilocal_file_repository.dart
|   |   |   └── isuper_hero_api_repository.dart
│   |   ├── managers/
|   |   |   ├── hero_data_manager.dart
|   |   |   └── mock_data_manager.dart
│   |   ├── ui/
|   |   |   ├── application.dart
|   |   |   └── hero_ui.dart
│   |   ├── utils/
|   |   |   ├── console_utils.dart
|   |   |   ├── get_model_input.dart
|   |   |   ├── input_utils.dart
|   |   |   └── menu.dart
│   |   └── vaildators/
|   |       └── get_valid_int.dart
│   ├── test/
|   |   └── v04_test.dart
│   ├── .env.example
│   ├── .gitignore
│   ├── pubspec.yaml
│   └── README.md
└── README.md              # This file
```

---

## Acknowledgments

- [Dart Documentation](https://dart.dev/guides) - Official Dart documentation
- [SuperHero API](https://www.superheroapi.com/) - Free superhero data API
- [Clean Architecture Guide](https://medium.com/@victornkpubre/clean-architecture-with-flutter-dart-744dd4b3e65a) - Architecture inspiration
- [Claude AI](https://claude.ai/) - README structure and debugging assistance
- [Chat GPT](https://chatgpt.com/) - Debugging assistance
- Course instructors and materials for project guidance

---

## License

This project was created for educational purposes as part of the Hybrid Development with Flutter course.

---

## Next Steps

After completing this Dart module, the course continues with:
- Flutter framework for mobile development
- Building cross-platform applications
- State management in Flutter
- Advanced UI/UX design
- Deployment to app stores

---

*This repository demonstrates the complete learning journey from Dart basics to production-ready applications with API integration and clean architecture. Each version builds upon previous knowledge, creating a solid foundation for Flutter development.*
