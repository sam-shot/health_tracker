# Health Tracker - Flutter Assessment

This project is a fully-featured health tracking application built with Flutter. It allows users to log their daily mood with an optional note, view their history, and see a weekly summary. The app is built with a professional, scalable architecture, featuring a robust offline-first synchronization system with a Supabase backend.

---

## Time Spent

- **Total Time:** Approximately 10-12 hours

---

## Try It Live

Want to test the app without setting up the development environment? You can try it instantly in your browser or download the APK directly to your Android device.

### 🌐 Live Browser Demo

Experience the app directly in your browser using Appetize.io:

**[👉 Try Health Tracker Live](https://appetize.io/app/android/com.example.health_tracker?device=pixel9xl&osVersion=15.0&toolbar=true&scale=100)**

*No installation required - runs in your browser on any device*

### 📱 Download APK

Download the APK file directly to your Android device:

**[📥 Download APK from Google Drive](https://drive.google.com/file/d/1MAUa0l8gctvRS3Y320nLwMgAMgPOVDqv/view?usp=sharing)**


**Installation Instructions:**
1. Download the APK file to your Android device
2. Enable "Install from Unknown Sources" in your device settings
3. Open the downloaded APK file to install



## Screenshots

Here's a visual walkthrough of the Health Tracker app:

### Authentication Flow
<img src="https://i.ibb.co/Z64VHrrj/2025-09-12-11-24-53-High-Res-Screenshot.png" width="300">

### Home Screen & Entry Management
<img src="https://i.ibb.co/XfK8pLFy/2025-09-12-11-25-15-High-Res-Screenshot.png" alt="Home screen displaying list of mood entries with sync status indicators" width="300">

### Creating New Entries
<img src="https://i.ibb.co/S7tFZY2j/2025-09-12-11-26-01-High-Res-Screenshot.png" alt="Create new health entry form with mood selection and optional notes" width="300">

### User Profile
<img src="https://i.ibb.co/60WmRj8N/2025-09-12-11-26-18-High-Res-Screenshot.png" alt="User profile page with avatar, email, and entry statistics" width="300">

### Offline Functionality
<img src="https://i.ibb.co/cczLYp9J/2025-09-12-11-27-09-High-Res-Screenshot.png" alt="App functioning offline with local data and sync indicators" width="300">

*Note: To view the actual app interface, use the [live browser demo](https://appetize.io/app/android/com.example.health_tracker?device=pixel9xl&osVersion=15.0&toolbar=true&scale=100) or download the APK above.*



## Features Implemented

- **Full Authentication:** Secure sign-up and sign-in with both email/password and third-party Google Sign-In.
- **Reactive Navigation:** A centralized `AuthObserver` automatically navigates users between the sign-in and home screens based on their real-time authentication state.
- **Health Entry CRUD:** Users can create new mood entries with an optional title and note.
- **Offline-First Persistence:** Entries are always saved to a local `sqflite` database first for instant UI feedback and full offline functionality. The app is 100% usable without an internet connection.
- **Backend Synchronization:** A robust "Push First, Then Pull" sync mechanism automatically uploads offline-created entries and downloads the latest data from the Supabase backend whenever the app is online.
- **Dynamic UI:**
  - The home page displays a list of all entries, showing a "not synced" icon for local-only entries.
  - A dynamic `WeeklyChart` visually indicates which days of the week have logged entries.
  - Subtle animations (`TweenAnimationBuilder`) provide a smooth user experience when data is loaded.
- **User Profile & Stats:** A dedicated profile page displays the user's email, a generated avatar, and key stats like total entries and entries made today.

---

## Architecture & Technical Choices

This project was built using a feature-first, clean architecture approach **(Data -> Repository -> State Notifier -> UI)** to ensure a clear separation of concerns, high testability, and scalability.

### Core Technologies

- **State Management: Riverpod**

  - **Why:** I chose Riverpod for its compile-time safety and declarative approach. It eliminates the boilerplate of `Provider` while offering powerful features that simplify handling asynchronous data (like our auth state and data fetching). The pattern of "providers depending on other providers" makes the entire state management layer self-contained and highly testable by allowing easy dependency overriding.

- **Local Storage: sqflite**

  - **Why:** For the local persistence layer, `sqflite` was the ideal choice. It is a mature, battle-tested, and incredibly reliable package that provides the full power of a SQL database on the device. This is perfect for complex queries, sorting, and migrations. Its SQL-based nature also aligns well with the PostgreSQL backend, creating a consistent mental model for data management.

- **Backend: Supabase**
  - **Why:** Supabase provides a fantastic developer experience with its auto-generated APIs, real-time capabilities, and robust authentication system (including third-party providers like Google). The `supabase_flutter` client library is clean and makes integration seamless.

### Supporting Packages

- **Routing: auto_route**

  - **Why:** `auto_route` was used to create a strongly-typed and boilerplate-free navigation system. It eliminates string-based routing, reducing the risk of runtime errors. Using a global router instance provided a robust and unambiguous way to handle navigation commands from anywhere in the app, which was key to the reactive auth flow.

- **Dependency Injection: get_it & injectable**

  - **Why:** This combination provides a fast and efficient service locator for managing the lifecycle of singleton services like repositories and data sources. `injectable`'s code generation removes the need for manual setup, keeping the DI container clean and maintainable.

- **Models & Serialization: freezed & json_serializable**

  - **Why:** `freezed` was used to create immutable data classes (models). This prevents accidental state mutation and provides useful methods like `copyWith`, `==` overrides, and `toString` for free, significantly reducing boilerplate.

- **Connectivity: connectivity_plus**
  - **Why:** A simple but crucial package used in the repository layer to check for an active internet connection, allowing the app to decide whether to attempt a remote sync or operate in offline mode.

---

## What I Like About My Implementation

- **The Robust Offline-First Sync:** I'm particularly proud of the repository logic that seamlessly handles online and offline states. The use of a `synced` flag in the local database ensures that no data is ever lost. The "Push First, Then Pull" sync strategy is efficient, reliable, and provides an excellent user experience.
- **Clean Data Source Abstraction:** I'm also proud of how I separated the local and remote data sources into distinct concerns. This abstraction allows for efficient testing, independent editing of each data source, and the ability to migrate databases without affecting other parts of the application. The clear separation makes the codebase more maintainable and flexible.
- **Reactive Authentication Flow:** The `AuthObserver` widget at the top of the application provides a clean, centralized, and foolproof way to handle navigation based on auth state. The UI reactively navigates between the sign-in and home screens without any manual routing calls in the widgets themselves.
- **Testable Code:** By using constructor dependency injection (passing repositories into notifiers) and creating a bridge provider for `get_it` services, the entire application logic is highly testable. Notifiers and repositories can be unit tested with mock dependencies, and widget tests can easily override providers to test specific UI states.

## What I Would Change With More Time

- **Advanced Sync Handling:** I would improve the sync logic to handle edge cases like "merge conflicts" (if an entry is updated on two devices simultaneously) and create a dedicated queue for failed uploads to retry them later with a package like `background_fetch`.
- **More Advanced Charting:** I would replace the simple `WeeklyChart` with a more detailed visualization using a package like `fl_chart` to show mood trends over time (e.g., a line or bar chart).
- **Tablet & Web Responsiveness:** The current UI is designed for mobile. With more time, I would adapt the layout using `LayoutBuilder` or other responsive techniques to work beautifully on larger screens like tablets and web browsers.

## How I Would Test This

- **Unit Tests:** I would write unit tests for the `HealthEntryNotifier` and `HealthEntryRepository`. Since we used constructor dependency injection, it's easy to provide mock repositories and data sources to verify that the business logic (like counting entries, handling sync states, and transforming data) works correctly in isolation.
- **Widget Tests:** I would write widget tests for the `SignInPage`, `HealthEntriesPage`, and `CreateEntryPage`. The goal would be to verify that the UI correctly reflects different states from the Riverpod providers (e.g., showing a `CircularProgressIndicator` when the state is `loading`, displaying a list of entries when `loaded`, and showing an error message when `error`).
- **Integration Tests:** I would write a full integration test for the "offline entry" use case using `flutter_test` and `integration_test`: 1. Turn off the network. 2. Create a new entry. 3. Verify it appears in the list with a "not synced" icon. 4. Turn the network back on. 5. Trigger a refresh and verify the "not synced" icon disappears.

---

## How to Run the Project

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio/VS Code with Flutter extensions

### Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/sam-shot/health_tracker/
   cd health_tracker
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate required files**

   ```bash
   dart pub run build_runner build --delete-conflicting-outputs
   ```

   This command generates:

   - Auto-route navigation files (`router.gr.dart`)
   - Injectable dependency injection files
   - Freezed model files
   - JSON serialization files

4. **Import routes in router file**
   After running the build_runner command, make sure to import the generated routes in your `router.gr.dart` file if not done automatically.

### Google Authentication Setup

**⚠️ Important Note:** If you're building this project on your own machine, Google Authentication will **NOT** work out of the box. You need to set up your own Google Cloud project and configure the authentication credentials.

#### Steps to Enable Google Auth:

1. **Create a Google Cloud Project**

   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project or select an existing one

2. **Enable Google Sign-In API**

   - Navigate to "APIs & Services" → "Library"
   - Search for "Google Sign-In API" and enable it

3. **Create OAuth 2.0 Credentials**

   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "OAuth 2.0 Client IDs"

4. **For Android:**

   - Select "Android" as application type
   - You'll need your app's **Application ID** (found in `android/app/build.gradle`)
   - Generate your **SHA-1 key** using:
     ```bash
     keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
     ```
   - For release builds, use your release keystore
   - Useful resources:
     - [Android SHA-1 Key Generation Guide](https://developers.google.com/android/guides/client-auth)
     - [Google Sign-In Android Setup](https://developers.google.com/identity/sign-in/android/start-integrating)

5. **Web Clint Id:**

   - Create a "Web application" credential
   - Note the **Web Client ID** - you'll need this

6. **Update the code with your credentials:**
   - In `lib/features/auth/repo/auth_repo_impl.dart`, replace the placeholder web client ID:
     ```dart
      final GoogleSignIn signIn = GoogleSignIn.instance;
      signIn.initialize(
        serverClientId:
            'YOUR_ACTUAL_WEB_CLIENT_ID_HERE',
      );
     ```

### Additional Setup for Windows (SQLite)

If running on Windows, you may need to add SQLite support:

1. Download `sqlite3.dll` from [SQLite official website](https://www.sqlite.org/download.html)
2. Place it in the `build/windows/runner/Debug` directory (created after first run)

### Run the Application

```bash
flutter run
```

The app will work offline-first, and Google authentication will only work if properly configured as described above.

---

## Project Structure & Clean Architecture

This project follows **Clean Architecture** principles with a **feature-first** approach, ensuring separation of concerns, testability, and scalability. The architecture is organized into distinct layers that communicate through well-defined interfaces.

### Folder Structure

```
lib/
├── main.dart                    # App entry point & dependency injection setup
├── app/                         # Application layer (routing, global providers)
│   ├── app.dart                # Main app widget configuration
│   └── router/                 # Auto-route navigation setup
│       └── app_router.dart     # Route definitions
├── core/                       # Shared utilities & cross-cutting concerns
│   ├── extension/              # Dart extension methods (context, etc.)
│   ├── gen_assets/             # Generated asset classes
│   ├── services/               # Shared services (dependency injection)
│   ├── theme/                  # App theming (colors, text styles)
│   └── widgets/                # Reusable UI components
├── data/                       # Data layer (repositories & data sources)
│   ├── local/                  # Local data sources (SQLite, shared prefs)
│   └── remote/                 # Remote data sources (API, Supabase)
└── features/                   # Feature modules (business logic)
    ├── auth/                   # Authentication feature
    │   ├── data/              # Auth-specific data layer
    │   ├── domain/            # Auth business logic & models
    │   └── presentation/      # Auth UI (pages, widgets, state)
    ├── health_entry/          # Health entries feature
    │   ├── data/              # Health entry data layer
    │   ├── domain/            # Health entry business logic
    │   └── presentation/      # Health entry UI components
    └── profile/               # User profile feature
        └── presentation/      # Profile UI components
```

### Clean Architecture Layers Explained

#### 1. **Presentation Layer** (`presentation/`)

- **Responsibility**: UI components, state management, user interactions
- **Contents**: Pages, widgets, state notifiers (Riverpod providers)
- **Dependencies**: Only depends on domain layer (business logic)
- **Why**: Keeps UI logic separate from business logic, making it easy to change the UI without affecting core functionality

#### 2. **Domain Layer** (`domain/`)

- **Responsibility**: Business logic, entities, and use cases
- **Contents**: Models (using Freezed), business rules, interfaces
- **Dependencies**: No dependencies on other layers (pure Dart)
- **Why**: Contains the core business rules that don't change regardless of external concerns (UI, database, API)

#### 3. **Data Layer** (`data/`)

- **Responsibility**: Data access, external services integration
- **Contents**: Repository implementations, data sources (local/remote)
- **Dependencies**: Implements domain interfaces, depends on external packages
- **Why**: Isolates data access logic, making it easy to switch data sources (SQLite ↔ API) without affecting business logic

### Key Architectural Decisions

#### **Dependency Injection with GetIt & Injectable**

```dart
// Services are registered in a centralized container
@injectable
class HealthEntryRepository implements HealthEntryRepositoryInterface {
  // Implementation...
}
```

**Why this pattern:**

- **Testability**: Easy to inject mock dependencies for unit testing
- **Flexibility**: Can swap implementations without changing dependent code
- **Single Responsibility**: Each class has one clear purpose

#### **Repository Pattern**

```dart
// Abstract interface in domain layer
abstract class HealthEntryRepositoryInterface {
  Future<List<HealthEntry>> getEntries();
  Future<void> saveEntry(HealthEntry entry);
}

// Concrete implementation in data layer
class HealthEntryRepository implements HealthEntryRepositoryInterface {
  // Handles both local and remote data sources
}
```

**Benefits:**

- **Abstraction**: Business logic doesn't know about SQLite, Supabase, or any specific technology
- **Offline-First**: Repository can intelligently choose between local and remote data
- **Testability**: Easy to create mock repositories for testing

#### **State Management with Riverpod**

```dart
// State notifiers handle business logic
final healthEntryNotifierProvider =
    StateNotifierProvider<HealthEntryNotifier, HealthEntryState>((ref) {
  final repository = ref.watch(healthEntryRepositoryProvider);
  return HealthEntryNotifier(repository,ref);
});
```

**Why Riverpod:**

- **Compile-time Safety**: Catches dependency errors at compile time
- **Declarative**: UI automatically rebuilds when state changes
- **Testing**: Easy to override providers for testing different states

#### **Immutable Models with Freezed**

```dart
@freezed
class HealthEntry with _$HealthEntry {
  const factory HealthEntry({
    required String id,
    required String mood,
    String? title,
    String? note,
    required DateTime createdAt,
    @Default(false) bool synced,
  }) = _HealthEntry;

  factory HealthEntry.fromJson(Map<String, dynamic> json) => _$HealthEntryFromJson(json);
}
```

**Benefits:**

- **Immutability**: Prevents accidental state mutations
- **Equality**: Automatic `==` and `hashCode` implementations
- **Copy Methods**: Easy to create modified copies with `copyWith()`
- **Serialization**: Automatic JSON serialization/deserialization

### Offline-First Architecture

The app implements a sophisticated offline-first strategy:

1. **Local-First Writes**: All data is immediately saved to SQLite for instant UI feedback
2. **Background Sync**: When online, data automatically syncs to the remote backend
3. **Conflict Resolution**: The `synced` flag tracks which entries need to be uploaded
4. **Graceful Degradation**: Full functionality available offline

This architecture ensures:

- **Fast User Experience**: No waiting for network requests
- **Reliability**: Works in poor network conditions
- **Data Integrity**: No data loss even if the app crashes during sync

### Why This Architecture?

1. **Maintainability**: Clear separation makes the codebase easy to understand and modify
2. **Testability**: Each layer can be tested independently with mock dependencies
3. **Scalability**: New features can be added without affecting existing code
4. **Flexibility**: Individual components can be changed without ripple effects
5. **Team Development**: Multiple developers can work on different features simultaneously
6. **Performance**: Offline-first approach provides excellent user experience

This architecture might seem complex for a simple app, but it demonstrates production-ready patterns that scale well as applications grow in complexity and team size.

---
