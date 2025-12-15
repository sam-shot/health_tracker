# Template Architecture & Structure

This document provides a detailed overview of the template's architecture, patterns, and conventions.

## 📊 Architecture Overview

This template implements **Clean Architecture** with a **Feature-First** organization pattern, ensuring:
- ✅ Separation of concerns
- ✅ High testability
- ✅ Scalability
- ✅ Maintainability
- ✅ Team collaboration

## 🏗️ Layers Breakdown

### 1. Presentation Layer (`features/*/presentation/`)

**Responsibility:** UI components and user interaction handling

**Contains:**
- **Pages:** Full-screen views (`*_page.dart`)
- **Widgets:** Reusable UI components
- **Providers:** Riverpod state management
- **State Classes:** UI state definitions

**Key Characteristics:**
- Only depends on domain layer
- Uses Riverpod for state management
- Stateless/Stateful widgets and ConsumerWidgets
- No business logic - only UI logic

**Example:**
```dart
@RoutePage()
class ExamplePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exampleProvider);
    
    return Scaffold(
      body: state.when(
        loading: () => CircularProgressIndicator(),
        error: (e) => ErrorWidget(e),
        data: (data) => DataWidget(data),
      ),
    );
  }
}
```

### 2. Domain Layer (`features/*/models/`)

**Responsibility:** Business logic and entities

**Contains:**
- **Models:** Immutable data classes using Freezed
- **State Classes:** Business state representations
- **Interfaces:** Abstract contracts (if needed)

**Key Characteristics:**
- Pure Dart (no Flutter dependencies)
- Immutable data structures
- Business rules and validation
- Framework-agnostic

**Example:**
```dart
@freezed
class ExampleModel with _$ExampleModel {
  const factory ExampleModel({
    required String id,
    required String name,
    required DateTime createdAt,
    @Default(false) bool synced,
  }) = _ExampleModel;

  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);
}
```

### 3. Data Layer (`features/*/repo/` & `data/`)

**Responsibility:** Data access and external service integration

**Contains:**
- **Repositories:** Coordinate between local and remote data sources
- **Local Data Sources:** SQLite database operations
- **Remote Data Sources:** API/Supabase calls
- **DTOs:** Data transfer objects (if needed)

**Key Characteristics:**
- Implements offline-first pattern
- Handles sync logic
- Manages data transformation
- Error handling

**Example:**
```dart
@injectable
class ExampleRepository {
  final ExampleLocalDataSource _localDataSource;
  final ExampleRemoteDataSource _remoteDataSource;
  final Connectivity _connectivity;

  ExampleRepository(
    this._localDataSource,
    this._remoteDataSource,
    this._connectivity,
  );

  Future<List<ExampleModel>> getAll() async {
    // Try to sync if online
    final hasConnection = await _checkConnection();
    if (hasConnection) {
      await _syncData();
    }
    
    // Always return local data
    return await _localDataSource.getAll();
  }

  Future<void> create(ExampleModel model) async {
    // Save locally first
    await _localDataSource.insert(model);
    
    // Try to sync if online
    final hasConnection = await _checkConnection();
    if (hasConnection) {
      await _remoteDataSource.create(model);
      await _localDataSource.markAsSynced(model.id);
    }
  }
}
```

## 🔄 Data Flow

### Reading Data
```
UI (Widget)
    ↓
Provider (StateNotifier)
    ↓
Repository
    ↓
Local DataSource ← Remote DataSource (if online)
    ↓
SQLite Database
```

### Writing Data
```
UI (Widget)
    ↓
Provider (StateNotifier)
    ↓
Repository
    ├─→ Local DataSource (immediate)
    └─→ Remote DataSource (if online)
```

## 🎯 Design Patterns Used

### 1. Repository Pattern
Abstracts data sources from business logic.

**Benefits:**
- Single source of truth
- Easy testing with mocks
- Flexible data source switching

### 2. Provider Pattern (Riverpod)
Manages application state and dependencies.

**Benefits:**
- Compile-time safety
- Easy dependency injection
- Automatic disposal

### 3. Singleton Pattern (GetIt)
Manages service lifecycle.

**Benefits:**
- Single instance of services
- Lazy initialization
- Global access point

### 4. Factory Pattern
Creates objects based on configuration.

**Benefits:**
- Flexible object creation
- Decoupled construction
- Easy testing

### 5. Observer Pattern (Riverpod)
UI observes state changes and rebuilds.

**Benefits:**
- Reactive UI
- Automatic updates
- Efficient rebuilds

## 📦 Module Organization

### Core Module (`lib/core/`)
Shared utilities used across features.

**Structure:**
```
core/
├── extension/           # Dart/Flutter extensions
│   ├── context.extensions.dart
│   ├── datetime.extensions.dart
│   └── string.extensions.dart
├── services/           # Shared services
│   └── database_service.dart
├── theme/             # App-wide theming
│   ├── app_colors.dart
│   ├── app_typography.dart
│   └── app_theme.dart
└── widgets/           # Reusable UI components
    ├── app_button.dart
    ├── app_text_field.dart
    └── app_snackbar.dart
```

### Feature Module (`lib/features/*`)
Self-contained feature implementation.

**Structure:**
```
feature_name/
├── models/                    # Domain models
│   ├── feature_model.dart
│   ├── feature_model.freezed.dart
│   ├── feature_model.g.dart
│   └── feature_state.dart
├── presentation/             # UI layer
│   ├── pages/
│   │   └── feature_page.dart
│   ├── widgets/
│   │   └── feature_widget.dart
│   └── providers/
│       └── feature_providers.dart
└── repo/                     # Data layer
    └── feature_repository.dart
```

## 🔐 Dependency Injection

### Setup (GetIt + Injectable)

**1. Define Injectable Classes:**
```dart
@injectable
class MyService {
  MyService(MyDependency dependency);
}
```

**2. Register in Module:**
```dart
@InjectableInit()
void configureDependencies() => getIt.init();
```

**3. Bridge to Riverpod:**
```dart
final myServiceProvider = Provider<MyService>((ref) {
  return getIt<MyService>();
});
```

**4. Use in Widgets:**
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(myServiceProvider);
    // Use service
  }
}
```

## 🔄 Offline-First Pattern

### Strategy: "Local First, Sync When Online"

**1. Write Operations:**
- Save to local database immediately
- Mark as "unsynced"
- Try to upload to server if online
- Mark as "synced" on success
- Retry later if failed

**2. Read Operations:**
- Always read from local database
- Sync from server in background if online
- Update local database with server data
- UI automatically reflects changes

**3. Sync Logic:**
```dart
Future<void> syncData() async {
  // 1. Push local changes to server
  final unsyncedItems = await _localDataSource.getUnsynced();
  for (final item in unsyncedItems) {
    await _remoteDataSource.upload(item);
    await _localDataSource.markAsSynced(item.id);
  }
  
  // 2. Pull server changes to local
  final serverItems = await _remoteDataSource.getAll();
  await _localDataSource.upsertAll(serverItems);
}
```

## 🧪 Testing Strategy

### Unit Tests
Test business logic in isolation.

```dart
group('FeatureRepository', () {
  late FeatureRepository repository;
  late MockLocalDataSource mockLocal;
  late MockRemoteDataSource mockRemote;

  setUp(() {
    mockLocal = MockLocalDataSource();
    mockRemote = MockRemoteDataSource();
    repository = FeatureRepository(mockLocal, mockRemote);
  });

  test('should save locally first', () async {
    final item = FeatureModel(id: '1', name: 'Test');
    await repository.create(item);
    verify(mockLocal.insert(item)).called(1);
  });
});
```

### Widget Tests
Test UI components.

```dart
testWidgets('should display loading indicator', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        featureProvider.overrideWith((ref) => AsyncValue.loading()),
      ],
      child: MaterialApp(home: FeaturePage()),
    ),
  );

  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

### Integration Tests
Test complete user flows.

```dart
testWidgets('complete user flow', (tester) async {
  // 1. Start app
  // 2. Navigate to feature
  // 3. Create item
  // 4. Verify it appears in list
  // 5. Edit item
  // 6. Verify changes persist
});
```

## 🎨 Theming System

### Color System
Centralized in `app_colors.dart`:
```dart
class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const secondary = Color(0xFF2ECC71);
  static const background = Color(0xFFF5F5F5);
  // ... more colors
}
```

### Typography
Defined in `app_typography.dart`:
```dart
class AppTypography {
  static TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  // ... more styles
}
```

### Theme Configuration
Applied in `app_theme.dart`:
```dart
class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    textTheme: TextTheme(
      displayLarge: AppTypography.heading1,
      // ... more mappings
    ),
  );
}
```

## 🚀 Code Generation

### Required Generators:
1. **Auto Route** - Navigation
2. **Injectable** - Dependency injection
3. **Freezed** - Immutable models
4. **JSON Serializable** - JSON conversion

### Running Generation:
```bash
# One-time generation
dart pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerates on changes)
dart pub run build_runner watch --delete-conflicting-outputs
```

### Generated Files:
- `*.g.dart` - JSON serialization
- `*.freezed.dart` - Freezed classes
- `*.gr.dart` - Routes
- `*.config.dart` - DI configuration

## 📱 Navigation

### Route Definition:
```dart
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: DetailsRoute.page),
    AutoRoute(page: SettingsRoute.page),
  ];
}
```

### Navigation Usage:
```dart
// Push
context.router.push(DetailsRoute(id: '123'));

// Replace
context.router.replace(HomeRoute());

// Pop
context.router.pop();
```

### Protected Routes:
```dart
AutoRoute(
  page: ProfileRoute.page,
  guards: [AuthGuard()],
),
```

## 🔒 Best Practices

### DO:
✅ Keep features independent
✅ Use dependency injection
✅ Write immutable models
✅ Separate UI from logic
✅ Handle errors gracefully
✅ Test critical paths
✅ Document complex logic
✅ Use meaningful names

### DON'T:
❌ Mix business logic in UI
❌ Create circular dependencies
❌ Ignore error handling
❌ Skip code generation
❌ Hardcode values
❌ Use mutable state
❌ Couple features together
❌ Commit generated files to version control

## 🎓 Learning Resources

- **Clean Architecture:** Uncle Bob's principles
- **Riverpod:** Official documentation at riverpod.dev
- **Flutter:** flutter.dev/docs
- **Freezed:** pub.dev/packages/freezed
- **Auto Route:** autoroute.vercel.app

---

This architecture provides a solid foundation for building scalable Flutter applications. Adapt and extend based on your specific needs while maintaining these core principles.
