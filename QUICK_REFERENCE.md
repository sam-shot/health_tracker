# Flutter Template - Quick Reference Card

## 📋 Essential Commands

### Initial Setup
```bash
flutter pub get                                                    # Get dependencies
dart pub run build_runner build --delete-conflicting-outputs      # Generate code
flutter run                                                         # Run the app
```

### Development
```bash
dart pub run build_runner watch --delete-conflicting-outputs      # Auto-generate on changes
flutter clean && flutter pub get                                   # Clean project
flutter analyze                                                    # Analyze code
```

### Building
```bash
flutter build apk                                                  # Android APK
flutter build appbundle                                            # Android App Bundle
flutter build ios                                                  # iOS build
flutter build web                                                  # Web build
```

## 🗂️ Project Structure Quick Reference

```
lib/
├── main.dart                        # Entry point
├── app/
│   ├── app.dart                    # App widget
│   ├── injection.dart              # DI setup
│   └── router.dart                 # Routes
├── core/
│   ├── extension/                  # Extensions
│   ├── services/                   # Core services
│   ├── theme/                      # Theming
│   └── widgets/                    # Reusable widgets
├── data/
│   ├── local/                      # SQLite
│   └── remote/                     # API calls
└── features/
    └── your_feature/
        ├── models/                 # Data models
        ├── presentation/           # UI
        └── repo/                   # Data layer
```

## 🔄 Creating a New Feature

### 1. Create Feature Structure
```bash
mkdir -p lib/features/my_feature/{models,presentation/{pages,widgets,providers},repo}
```

### 2. Create Model
```dart
// lib/features/my_feature/models/my_model.dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel({
    required String id,
    required String name,
  }) = _MyModel;
  
  factory MyModel.fromJson(Map<String, dynamic> json) => 
    _$MyModelFromJson(json);
}
```

### 3. Create Repository
```dart
// lib/features/my_feature/repo/my_repository.dart
@injectable
class MyRepository {
  final MyLocalDataSource _localDataSource;
  
  MyRepository(this._localDataSource);
  
  Future<List<MyModel>> getAll() async {
    return await _localDataSource.getAll();
  }
}
```

### 4. Create Provider
```dart
// lib/features/my_feature/presentation/providers/my_providers.dart
final myRepositoryProvider = Provider<MyRepository>((ref) {
  return getIt<MyRepository>();
});

final myProvider = StateNotifierProvider<MyNotifier, AsyncValue<List<MyModel>>>((ref) {
  final repository = ref.watch(myRepositoryProvider);
  return MyNotifier(repository);
});
```

### 5. Create Page
```dart
// lib/features/my_feature/presentation/pages/my_page.dart
@RoutePage()
class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('My Feature')),
      body: state.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(items[index].name),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
```

### 6. Add Route
```dart
// lib/app/router.dart
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MyRoute.page, path: '/my-feature'),
    // ... other routes
  ];
}
```

### 7. Register in DI
```dart
// Add to appropriate data source file or create new one
@injectable
class MyLocalDataSource {
  // Implementation
}
```

### 8. Generate Code
```bash
dart pub run build_runner build --delete-conflicting-outputs
```

## 🎨 Theming Quick Access

### Colors
```dart
// lib/core/theme/app_colors.dart
AppColors.primary
AppColors.secondary
AppColors.background
AppColors.error
```

### Typography
```dart
// lib/core/theme/app_typography.dart
AppTypography.heading1
AppTypography.heading2
AppTypography.bodyLarge
AppTypography.bodySmall
```

### Using in Widgets
```dart
Container(
  color: AppColors.primary,
  child: Text(
    'Hello',
    style: AppTypography.heading1,
  ),
)
```

## 🧭 Navigation

### Push
```dart
context.router.push(MyRoute(id: '123'));
```

### Replace
```dart
context.router.replace(MyRoute());
```

### Pop
```dart
context.router.pop();
context.router.popUntilRoot();
```

### With Result
```dart
final result = await context.router.push(MyRoute());
```

## 📦 Common Widgets

### Custom Button
```dart
AppButton(
  text: 'Click Me',
  onPressed: () {},
)
```

### Custom Text Field
```dart
AppTextField(
  controller: controller,
  label: 'Email',
  hint: 'Enter email',
)
```

### Show Snackbar
```dart
AppSnackbar.show(
  context,
  message: 'Success!',
  type: SnackbarType.success,
)
```

## 🔌 Dependency Injection

### Register Service
```dart
@injectable
class MyService {
  MyService(MyDependency dependency);
}
```

### Singleton
```dart
@singleton
class MyService {
  // Only one instance
}
```

### Lazy Singleton
```dart
@lazySingleton
class MyService {
  // Created when first accessed
}
```

### Get Service
```dart
final myService = getIt<MyService>();
```

### Bridge to Riverpod
```dart
final myServiceProvider = Provider<MyService>((ref) {
  return getIt<MyService>();
});
```

## 💾 Database Operations

### Local Data Source Pattern
```dart
@injectable
class MyLocalDataSource {
  final DatabaseService _db;
  
  Future<List<MyModel>> getAll() async {
    final db = await _db.database;
    final maps = await db.query('my_table');
    return maps.map((m) => MyModel.fromJson(m)).toList();
  }
  
  Future<void> insert(MyModel model) async {
    final db = await _db.database;
    await db.insert('my_table', model.toJson());
  }
  
  Future<void> update(MyModel model) async {
    final db = await _db.database;
    await db.update(
      'my_table',
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }
  
  Future<void> delete(String id) async {
    final db = await _db.database;
    await db.delete(
      'my_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
```

## 🌐 Remote Data Source Pattern

```dart
@injectable
class MyRemoteDataSource {
  final SupabaseClient _supabase;
  
  Future<List<MyModel>> getAll() async {
    final response = await _supabase
        .from('my_table')
        .select();
    return (response as List)
        .map((e) => MyModel.fromJson(e))
        .toList();
  }
  
  Future<void> create(MyModel model) async {
    await _supabase
        .from('my_table')
        .insert(model.toJson());
  }
}
```

## 🔄 State Management Patterns

### StateNotifier
```dart
class MyNotifier extends StateNotifier<AsyncValue<List<MyModel>>> {
  final MyRepository _repository;
  
  MyNotifier(this._repository) : super(AsyncValue.loading()) {
    loadData();
  }
  
  Future<void> loadData() async {
    state = AsyncValue.loading();
    try {
      final data = await _repository.getAll();
      state = AsyncValue.data(data);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
  
  Future<void> add(MyModel item) async {
    await _repository.add(item);
    await loadData();
  }
}
```

### Provider Usage
```dart
// Watch - rebuilds when changes
final state = ref.watch(myProvider);

// Read - one-time read
final notifier = ref.read(myProvider.notifier);

// Listen - callback on change
ref.listen(myProvider, (prev, next) {
  // Handle change
});
```

## 🧪 Testing Quick Reference

### Unit Test
```dart
test('should return data', () async {
  final repository = MockRepository();
  when(repository.getData()).thenAnswer((_) async => []);
  
  final result = await repository.getData();
  
  expect(result, isEmpty);
});
```

### Widget Test
```dart
testWidgets('should display text', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: MyWidget()),
  );
  
  expect(find.text('Hello'), findsOneWidget);
});
```

## 🐛 Common Issues & Solutions

### Issue: Generated files missing
```bash
dart pub run build_runner build --delete-conflicting-outputs
```

### Issue: Conflicting files
```bash
dart pub run build_runner clean
dart pub run build_runner build --delete-conflicting-outputs
```

### Issue: Dependencies not found
```bash
flutter clean
flutter pub get
```

### Issue: Android build fails
```bash
cd android && ./gradlew clean
cd .. && flutter clean
flutter pub get
```

## 📚 Package Versions Reference

Check `pubspec.yaml` for current versions of:
- `flutter_riverpod` - State management
- `auto_route` - Navigation
- `get_it` & `injectable` - DI
- `freezed` - Models
- `sqflite` - Local DB
- `supabase_flutter` - Backend

## 🔗 Useful Links

- Template Docs: `TEMPLATE_README.md`
- Setup Guide: `SETUP_GUIDE.md`
- Architecture: `TEMPLATE_STRUCTURE.md`
- Extraction: `EXTRACTION_GUIDE.md`

---

**Keep this card handy for quick reference! 📌**
