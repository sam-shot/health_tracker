# Flutter App Template - Clean Architecture

A production-ready Flutter application template featuring clean architecture, offline-first capabilities, and modern development practices.

## 🎯 What This Template Provides

This template is extracted from a production Flutter application and includes:

- **Clean Architecture** with feature-first organization
- **Offline-First** data synchronization pattern
- **State Management** with Riverpod
- **Dependency Injection** using GetIt & Injectable
- **Type-Safe Routing** with Auto Route
- **Local Database** with SQLite
- **Backend Integration** ready for Supabase or custom APIs
- **Authentication Flow** with email/password and OAuth support
- **Code Generation** setup for models, routes, and DI
- **Custom Theme System** with reusable components

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point & DI setup
├── app/                         # Application layer
│   ├── app.dart                # Main app widget
│   ├── injection.dart          # Dependency injection configuration
│   ├── router.dart             # Navigation routes
│   └── splash.dart             # Splash screen
├── core/                       # Shared utilities
│   ├── extension/              # Dart extensions
│   ├── gen_assets/             # Generated assets
│   ├── services/               # Core services (database, etc.)
│   ├── theme/                  # App theming
│   └── widgets/                # Reusable UI components
├── data/                       # Data layer
│   ├── local/                  # Local data sources
│   └── remote/                 # Remote data sources
└── features/                   # Feature modules
    ├── auth/                   # Authentication
    ├── health_entry/           # Example feature
    └── profile/                # User profile
```

## 🏗️ Architecture Layers

### 1. Presentation Layer
- **UI Components**: Pages, widgets, dialogs
- **State Management**: Riverpod providers and state notifiers
- **User Interactions**: Form handling, navigation

### 2. Domain Layer
- **Models**: Immutable data classes using Freezed
- **Business Logic**: Use cases and validation
- **Interfaces**: Abstract repository contracts

### 3. Data Layer
- **Repositories**: Implement domain interfaces
- **Data Sources**: Local (SQLite) and Remote (API)
- **Sync Logic**: Offline-first synchronization

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Setup

1. **Clone this template**
   ```bash
   git clone <your-repo-url>
   cd <your-project-name>
   ```

2. **Rename the project**
   - Update `name` in `pubspec.yaml`
   - Update package names in Android/iOS configurations
   - Update import statements throughout the codebase

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run code generation**
   ```bash
   dart pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Key Technologies

### State Management: Riverpod
- Compile-time safe dependency injection
- Provider-based architecture
- Easy testing and mocking

### Local Storage: SQLite
- Full SQL database on device
- Perfect for complex queries
- Schema migrations support

### Backend: Supabase-Ready
- Pre-configured for Supabase
- Easy to adapt to custom REST APIs
- Built-in authentication flows

### Routing: Auto Route
- Type-safe navigation
- Generated route definitions
- Guard-based protection

### DI: GetIt & Injectable
- Service locator pattern
- Code generation for setup
- Singleton and factory support

### Models: Freezed
- Immutable data classes
- Copy methods
- JSON serialization

## 📦 Core Features Included

### Authentication System
- Email/password authentication
- OAuth integration (Google Sign-In)
- Auth state management
- Protected routes

### Offline-First Architecture
- Local-first data writes
- Background synchronization
- Conflict resolution ready
- Network status detection

### Reusable Components
- Custom text fields
- Styled buttons
- Snackbar notifications
- Loading indicators

### Theme System
- Centralized color palette
- Typography styles
- Dark/light mode ready
- Consistent design language

## 🎨 Customization Guide

### Adding a New Feature

1. **Create feature folder structure**
   ```
   features/
   └── your_feature/
       ├── models/          # Data models
       ├── presentation/    # UI components
       │   ├── pages/
       │   ├── widgets/
       │   └── providers/
       └── repo/            # Repository
   ```

2. **Define your models**
   ```dart
   @freezed
   class YourModel with _$YourModel {
     const factory YourModel({
       required String id,
       required String field,
     }) = _YourModel;
     
     factory YourModel.fromJson(Map<String, dynamic> json) => 
       _$YourModelFromJson(json);
   }
   ```

3. **Create repository**
   ```dart
   @injectable
   class YourRepository {
     final YourLocalDataSource _localDataSource;
     final YourRemoteDataSource _remoteDataSource;
     
     YourRepository(this._localDataSource, this._remoteDataSource);
     
     // Implement your data logic
   }
   ```

4. **Add state provider**
   ```dart
   final yourProvider = StateNotifierProvider<YourNotifier, YourState>((ref) {
     final repository = ref.watch(yourRepositoryProvider);
     return YourNotifier(repository);
   });
   ```

5. **Create UI pages**
   ```dart
   @RoutePage()
   class YourPage extends ConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       // Your UI implementation
     }
   }
   ```

6. **Add routes**
   ```dart
   @AutoRouterConfig()
   class AppRouter extends RootStackRouter {
     @override
     List<AutoRoute> get routes => [
       AutoRoute(page: YourRoute.page, path: '/your-route'),
       // ... other routes
     ];
   }
   ```

7. **Run code generation**
   ```bash
   dart pub run build_runner build --delete-conflicting-outputs
   ```

### Customizing Theme

Edit files in `lib/core/theme/`:
- `app_colors.dart` - Color palette
- `app_typography.dart` - Text styles
- `app_theme.dart` - Overall theme configuration

### Adding Dependencies

1. Add to `pubspec.yaml`
2. Run `flutter pub get`
3. If it requires code generation, add to `build_runner`
4. Import and use in your code

## 🧪 Testing Strategy

### Unit Tests
Test business logic in isolation:
```dart
test('should fetch data correctly', () {
  final repository = MockRepository();
  final notifier = YourNotifier(repository);
  // Test logic
});
```

### Widget Tests
Test UI components:
```dart
testWidgets('should display loading indicator', (tester) async {
  await tester.pumpWidget(YourWidget());
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

### Integration Tests
Test complete user flows using `integration_test` package.

## 📝 Best Practices

1. **Keep features independent** - Each feature should be self-contained
2. **Use dependency injection** - Makes code testable and flexible
3. **Follow immutability** - Use Freezed for all data models
4. **Separate concerns** - Keep UI, business logic, and data separate
5. **Handle errors gracefully** - Provide meaningful error messages
6. **Document complex logic** - Add comments where necessary
7. **Keep UI responsive** - Use proper loading states
8. **Test critical paths** - Focus on core functionality

## 🔐 Security Considerations

- Never commit sensitive keys (use environment variables)
- Implement proper authentication flows
- Validate all user inputs
- Use HTTPS for API calls
- Implement proper error handling without exposing sensitive data

## 🚦 Common Commands

```bash
# Get dependencies
flutter pub get

# Run code generation
dart pub run build_runner build --delete-conflicting-outputs

# Watch mode for development
dart pub run build_runner watch --delete-conflicting-outputs

# Clean build
flutter clean && flutter pub get

# Run app
flutter run

# Build APK
flutter build apk

# Build iOS
flutter build ios
```

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Auto Route Documentation](https://autoroute.vercel.app)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [GetIt Documentation](https://pub.dev/packages/get_it)

## 🤝 Contributing

This is a template project. Feel free to modify it according to your needs. If you improve the architecture or add useful features, consider sharing them back to the community.

## 📄 License

This template is provided as-is for use in your projects. Modify freely to suit your needs.

## 🙏 Acknowledgments

This template is based on production Flutter development best practices and combines patterns from various successful Flutter applications.

---

**Happy Coding! 🎉**

For questions or suggestions, please open an issue in the repository.
