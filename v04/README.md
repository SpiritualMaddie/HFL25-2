# SuperHero Manager

A CLI application in Dart for managing superheroes and villains. The application fetches data from the SuperHero API and displays it, as well as creates, displays, and deletes heroes and villains from local storage in a JSON file. The application has almost full CRUD functionality - it supports viewing, creating, and deleting, but not updating.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#-tech-stack)
- [Installation](#-installation)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [Architecture & Design](#-architecture--design)
- [Code Quality](#-code-quality)

---

## Features

### Core Functionality
- **API Integration**: Search, fetch and display heroes/villains from SuperHero API
- **Local Storage**: All data is managed in a `List<HeroModel>` and saved to a JSON file either manually via the menu or automatically on shutdown, persisting between restarts
- **CR(U)D Operations**: 
  - Create custom heroes/villains manually
  - Read and display all heroes from the local list (sorted by strength)
  - Delete heroes from the local list
- **Duplicate Prevention**: Prevents the same hero from being saved twice based on `name`
- **Sorting**: Display heroes and villains separately based on `alignment`
- **Search Functionality**: 
  - Local search in saved data
  - API search against SuperHero API

### UX Features
- Clear console menu with numbered options
- User-friendly error handling with Swedish messages
- Confirmation prompts before deletion
- Automatic saving on exit

---

## Tech Stack

### Dependencies
```yaml
dependencies:
  http: ^1.2.2           # HTTP requests to API
  dotenv: ^4.2.0         # Environment variables for API key

dev_dependencies:
  lints: ^5.1.1          # Dart linting
  test: ^1.25.8          # Unit testing
```

### Dart Version
- SDK: `>=3.5.4 <4.0.0`
- Uses null-safety (`?`, `!`)

---

## Installation

### 1. Clone the repository
```bash
git clone https://github.com/SpiritualMaddie/HFL25-2.git
cd HFL25-2/v04
```

### 2. Get an API key
Go to [SuperHero API](https://www.superheroapi.com/) and log in with your GitHub account to get a free API key.

### 3. Configure environment variables
Create a `.env` file in the `v04/` folder:
```env
API_URL_WITH_KEY=https://superheroapi.com/api/YOUR_API_KEY_HERE
```

**NOTE!** `.env` is in `.gitignore` and should never be committed to GitHub for security reasons.

### 4. Install dependencies
```bash
dart pub get
```

### 5. Run the application
```bash
dart run
```

---

## Usage

### Main Menu
```

             .=.,
            ;c =\
          __|  _/
        .'-'-._/-'-._
       /..   ____    \
      /' _  [<_->] )  \
     (  / \--\_>/-/'._ )
      \-;_/\__;__/ _/ _/
       '._}|==o==\{_\/
        /  /-._.--\  \_
       // /   /|   \ \ \
      / | |   | \;  |  \ \
     / /  | :/   \: \   \_\
    /  |  /.'|   /: |    \ \
    |  |  |--| . |--|     \_\
    / _/   \ | : | /___--._) \
   |_(---'-| >-'-| |       '-'
          /_/     \_\
 _   _                ____              _____  ___   ___   ___  
| | | | ___ _ __ ___ |  _ \  _____  __ |___ / / _ \ / _ \ / _ \ 
| |_| |/ _ \ '__/ _ \| | | |/ _ \ \/ /   |_ \| | | | | | | | | |
|  _  |  __/ | | (_) | |_| |  __/>  <   ___) | |_| | |_| | |_| |
|_| |_|\___|_|  \___/|____/ \___/_/\_\ |____/ \___/ \___/ \___/ 

======================================================
Vad vill du göra?

1. Lägga till - hjälte/skurk
2. Visa alla - starkast först
3. Visa alla - hjältar & skurkar
4. Sök - lokalt
5. Sök - API
6. Spara manuellt - lokalt
7. Avsluta

======================================================
```

### Example: Search for a hero from API
1. Select option `5` from the menu
2. Enter a name (e.g., "Superman")
3. View all matching results from the API
4. Choose to search again or return to the main menu

### Example: Add your own hero
1. Select option `1` from the menu
2. Fill in:
   - Name
   - Powerstats (Intelligence, Strength, Speed, Durability, Power, Combat)
   - Biography (Place of Birth, First Appearance, Publisher, Alignment)
   - Appearance (Gender, Race, Height, Weight)
   - Work (Occupation, Base)
   - Connections (Group Affiliation, Relatives)
   - Image URL
3. The hero is automatically saved to the local list (unless duplicate)

---

## Project Structure

```
v04/
├── lib/
│   ├── data/
│   │   ├── factories/
│   │   │   └── http_client_factory.dart      # Factory for HTTP clients
│   │   ├── models/
│   │   │   ├── hero_model.dart                # Main model
│   │   │   ├── powerstats_model.dart
│   │   │   ├── biography_model.dart
│   │   │   ├── appearance_model.dart
│   │   │   ├── work_model.dart
│   │   │   ├── connections_model.dart
│   │   │   └── image_model.dart
│   │   ├── repositories/
│   │   │   ├── super_hero_api_repository.dart # API communication
│   │   │   └── local_file_repository.dart     # Local file handling
│   │   └── jsondata/
│   │       └── super_hero_json.json           # Local json database
│   ├── interfaces/
│   │   ├── isuper_hero_api_repository.dart
│   │   ├── ilocal_file_repository.dart
│   │   ├── ihttp_client_factory.dart
│   │   └── hero_data_managing.dart
│   ├── managers/
│   │   └── hero_data_manager.dart             # Business logic
│   ├── ui/
│   │   ├── application.dart                   # Main menu logic
│   │   └── hero_ui.dart                       # UI logic for heroes
│   ├── utils/
│   │   ├── console_utils.dart                 # Console helper functions
│   │   ├── input_utils.dart                   # Input helper functions
│   │   ├── menu.dart                          # Menu class
│   │   └── get_model_input.dart               # Model input helpers
│   └── validators/
│       └── get_valid_int.dart                 # Int validation helpers
├── .env                                        # API key (not in Git)
├── .gitignore
├── pubspec.yaml
└── bin/
    └── v04.dart                                # Entry point (main)
```

---

## Architecture & Design

### Design Patterns

#### 1. **Repository Pattern**
Separates data sources from business logic:
- `SuperHeroApiRepository`: Handles HTTP requests to API
- `LocalFileRepository`: Handles JSON file operations

**Why?** Makes it easy to change data sources without modifying business logic.

#### 2. **Singleton Pattern**
`HeroDataManager` uses Singleton to ensure a single data source:
```dart
static HeroDataManager? _instance;

factory HeroDataManager({SuperHeroApiRepository? apiRepo}){
  _instance ??= HeroDataManager._internal(
    apiHeroRepo: apiRepo ?? SuperHeroApiRepository(clientFactory: clientFactory),
  );
  return _instance!;
}
```

**Why?** Prevents conflicts during simultaneous read/write operations to the same list.

#### 3. **Factory Pattern**
`HttpClientFactory` creates new HTTP clients:
```dart
class HttpClientFactory implements IHttpClientFactory {
  @override
  http.Client create() => http.Client();
}
```

**Why?** Solves the problem of reusing HTTP connections and enables repeated requests to the API, while also enabling dependency injection for testing.

#### 4. **Dependency Injection (DI)**
Repositories and Managers receive dependencies via constructor:
```dart
SuperHeroApiRepository({
  required this.clientFactory,
  String? envBaseUrl,
})
```

**Why?** Makes the code testable by allowing dependencies to be mocked.

### Separation of Concerns (SOC)

The project follows clear separation:

| Layer | Responsibility | Example |
|-------|---------------|---------|
| **UI** | Presentation layer, user interaction | `hero_ui.dart`, `application.dart` |
| **Managers** | Business logic, coordinates repositories | `hero_data_manager.dart` |
| **Repositories** | Data sources (API, files) | `super_hero_api_repository.dart` |
| **Models** | Data structures | `hero_model.dart` |
| **Utils** | Helper functions | `input_utils.dart`, `console_utils.dart` |
| **Interfaces** | Abstractions for testability | `isuper_hero_api_repository.dart` |

### Data Flow

```
User Input (UI)
    ↓
HeroDataManager (Business Logic)
    ↓
Repository (Data Access)
    ↓
External Source (API / Local File)
```

**Example: Searching for a hero from API**
1. User types "Superman" in `hero_ui.dart`
2. `hero_ui.dart` calls `dataManager.getHeroByNameApi("Superman")`
3. `HeroDataManager` delegates to `apiHeroRepo.getHeroByName("Superman")`
4. `SuperHeroApiRepository` creates an HTTP client via factory and makes a request
5. JSON is parsed into `HeroModel` and returned through the layers

---

## Code Quality

### Null-Safety
The project uses Dart's null-safety:
- Nullable types: `ImageModel?`, `WorkModel?`
- Safe navigation: `?.`
- Null-assertion: `!` (used sparingly)

### Error Handling

#### API calls with retry logic
```dart
for(int attempt = 0; attempt < 3; attempt++){
  final client = clientFactory.create();
  try {
    final response = await client.get(searchUrl).timeout(const Duration(seconds: 10));
    if(response.statusCode == 200){
      return _parseHeroes(response.body);       
    }
  } finally {
    client.close();
  }
  if(attempt < 2) await Future.delayed(const Duration(seconds: 2));
}
```

**Benefits:**
- Retries 3 times before failure
- Closes client in `finally` block (even on exception)
- Timeout to avoid hanging requests

#### Specific catch blocks
```dart
try {
  // API call
} on FormatException catch (e) {
  print("❌ Error parsing JSON: $e");
} on SocketException catch (e) {
  print("❌ Network error: $e");
} catch (e, stack) {
  print("❌ Unexpected error: $e");
}
```

**Benefits:** Different error messages depending on error type.

### Asynchronous Programming

#### Future & async/await
```dart
Future<List<HeroModel>> getHeroByName(String heroName) async {
  final response = await client.get(searchUrl);
  return _parseHeroes(response.body);
}
```

**Why Future?** API calls take time - the application continues running while waiting for a response.

### Testability

Thanks to interfaces and DI, components can be mocked:

```dart
// Mock for testing
class MockHttpClientFactory implements IHttpClientFactory {
  final http.Client mockClient;
  MockHttpClientFactory(this.mockClient);
  
  @override
  http.Client create() => mockClient;
}

// Test
final mockClient = MockClient((request) async {
  return http.Response('{"response":"success","results":[...]}', 200);
});

final repo = SuperHeroApiRepository(
  clientFactory: MockHttpClientFactory(mockClient)
);
```

### Security

1. **API key in .env**: Never hardcoded or committed to Git
2. **Input validation**: All user input is validated
3. **Duplicate prevention**: Prevents duplicate entries
4. **Safe file operations**: `flush: true` and `FileMode.write` to avoid corruption

---

## Lessons Learned & Design Decisions

### Why Factory Pattern for HTTP clients?
**Problem:** SuperHero API closes connections between requests, causing `ClientException` and a huge headache.

**Solution:** Create a new client per request via factory.

**Alternatives considered:**
- ❌ Reuse the same client → Connection errors
- ❌ Create directly in method → Breaks DI and testability
- ✅ Factory Pattern → Testable and solves the problem

### Why Singleton for DataManager?
**Problem:** Risk of race conditions if multiple instances read/write simultaneously.

**Solution:** One central instance that manages all data.

### Why separate model classes instead of `Map<String, dynamic>`?
**Benefits:**
- Type-safety at compile time
- Autocomplete in IDE
- Clear data structure
- Easier to maintain
- Easier transfer to database later on

---

## Author

**Madde** - [GitHub](https://github.com/SpiritualMaddie)  
ReadMe created with help from [ClaudeAI](https://claude.ai/) for a cleaner, more structured layout

Course: Hybrid Development with Flutter, Dart module (v04 - Final Assignment)  
Date: October 2025

---

## License

This project was created for educational purposes.

---

## Acknowledgments

- [SuperHero API](https://www.superheroapi.com/) for data
- [Dart Documentation](https://dart.dev/guides) for reference
- [Clean Architecture Guide](https://medium.com/@victornkpubre/clean-architecture-with-flutter-dart-744dd4b3e65a) for architecture inspiration
- [Claude AI](https://claude.ai/) for README inspiration and clarity in the README layout
