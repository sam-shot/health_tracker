# Setting Up Your New Project from This Template

This guide will help you customize this template for your new Flutter project.

## Step 1: Clone or Extract the Template

```bash
# If using as a branch from the original repo
git checkout base-template

# Or clone just this branch
git clone -b base-template <repo-url> your-new-project
cd your-new-project
```

## Step 2: Rename Your Project

### Update pubspec.yaml
1. Open `pubspec.yaml`
2. Change the `name` field to your project name (use snake_case)
3. Update the `description` field

```yaml
name: your_app_name  # Change this
description: "Your app description"  # Change this
```

### Update Android Configuration

1. **Update package name in `android/app/build.gradle`:**
   ```gradle
   defaultConfig {
       applicationId "com.yourcompany.yourapp"  // Change this
       // ... other config
   }
   ```

2. **Update AndroidManifest.xml files:**
   - `android/app/src/main/AndroidManifest.xml`
   - `android/app/src/debug/AndroidManifest.xml`
   - `android/app/src/profile/AndroidManifest.xml`
   
   Update the `package` attribute in each file.

3. **Move package directories:**
   ```bash
   # Navigate to Android source
   cd android/app/src/main/kotlin
   
   # Rename the directory structure
   # From: com/example/health_tracker
   # To: com/yourcompany/yourapp
   ```

4. **Update MainActivity.kt:**
   ```kotlin
   package com.yourcompany.yourapp  // Change this
   
   import io.flutter.embedding.android.FlutterActivity
   
   class MainActivity: FlutterActivity() {
   }
   ```

### Update iOS Configuration

1. **Open iOS project in Xcode:**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Update Bundle Identifier:**
   - Select Runner in the project navigator
   - In the General tab, change the Bundle Identifier
   - Example: `com.yourcompany.yourapp`

3. **Update Info.plist if needed:**
   - `ios/Runner/Info.plist`
   - Update CFBundleDisplayName for your app name

### Update Web Configuration

1. **Update `web/index.html`:**
   ```html
   <title>Your App Name</title>
   ```

2. **Update `web/manifest.json`:**
   ```json
   {
     "name": "your_app_name",
     "short_name": "YourApp",
     "description": "Your app description"
   }
   ```

## Step 3: Update Import Statements

Since you've changed the package name, update all imports throughout the codebase:

### Manual Method
Search and replace in your IDE:
- Find: `package:health_tracker/`
- Replace with: `package:your_app_name/`

### Using Command Line
```bash
# macOS/Linux
find lib -type f -name "*.dart" -exec sed -i '' 's/health_tracker/your_app_name/g' {} +

# Linux (without '')
find lib -type f -name "*.dart" -exec sed -i 's/health_tracker/your_app_name/g' {} +
```

## Step 4: Clean and Regenerate

```bash
# Clean everything
flutter clean
rm -rf .dart_tool
rm -rf build

# Get dependencies
flutter pub get

# Run code generation
dart pub run build_runner build --delete-conflicting-outputs
```

## Step 5: Update Supabase Configuration (If Using)

If you're using Supabase for your backend:

1. Create a new Supabase project at [supabase.com](https://supabase.com)

2. Get your project URL and anon key

3. Update in your code where Supabase is initialized (typically in a repository or service):
   ```dart
   await Supabase.initialize(
     url: 'YOUR_SUPABASE_URL',
     anonKey: 'YOUR_SUPABASE_ANON_KEY',
   );
   ```

4. Consider using environment variables or a config file for these values

## Step 6: Configure Google Authentication (Optional)

If you want to keep Google Sign-In:

1. **Create a Google Cloud Project:**
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project

2. **Enable Google Sign-In API:**
   - Navigate to "APIs & Services" → "Library"
   - Search for "Google Sign-In API" and enable it

3. **Create OAuth 2.0 Credentials:**
   - For Android: You need your app's SHA-1 key
     ```bash
     keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
     ```
   - For iOS: Configure in Google Cloud Console
   - For Web: Create a Web client ID

4. **Update the code:**
   - Find where Google Sign-In is configured
   - Update with your OAuth client IDs

## Step 7: Customize Features

### Remove Example Features
If you don't need the health_entry example:
```bash
rm -rf lib/features/health_entry
rm -rf lib/data/local/health_entry_local_data_source.dart
rm -rf lib/data/remote/health_entry_remote_data_source.dart
```

Then regenerate code:
```bash
dart pub run build_runner build --delete-conflicting-outputs
```

### Add Your Own Features
Follow the structure shown in the TEMPLATE_README.md for adding new features.

## Step 8: Update Assets

1. **Replace logo/icons:**
   - Add your app logo to `assets/images/`
   - Generate app icons using a tool like:
     ```bash
     flutter pub add flutter_launcher_icons
     flutter pub run flutter_launcher_icons
     ```

2. **Replace fonts (optional):**
   - Add your custom fonts to `assets/fonts/`
   - Update `pubspec.yaml` font section
   - Update `lib/core/theme/app_typography.dart`

3. **Update theme colors:**
   - Edit `lib/core/theme/app_colors.dart`
   - Adjust your brand colors

## Step 9: Initialize Git for Your Project

```bash
# Remove connection to template repo
rm -rf .git

# Initialize new git repo
git init

# Create initial commit
git add .
git commit -m "Initial commit from template"

# Add your remote repository
git remote add origin <your-repo-url>
git branch -M main
git push -u origin main
```

## Step 10: Test Your Setup

```bash
# Run on your device/emulator
flutter run

# Verify everything works:
# - App launches successfully
# - Navigation works
# - Authentication flow works (if configured)
# - Database operations work
```

## Step 11: Update Documentation

1. Delete or rename `README.md` to `ORIGINAL_README.md`
2. Rename `TEMPLATE_README.md` to `README.md`
3. Update `README.md` with your project-specific information
4. Remove `SETUP_GUIDE.md` (this file) once setup is complete

## Common Issues and Solutions

### Issue: Build fails with package name errors
**Solution:** Make sure you've updated ALL import statements and package references.

### Issue: Android build fails
**Solution:** 
- Check that package names match in all AndroidManifest.xml files
- Verify MainActivity.kt has correct package declaration
- Run `flutter clean` and rebuild

### Issue: iOS build fails
**Solution:**
- Open the project in Xcode and check for any errors
- Clean build folder in Xcode (Shift + Cmd + K)
- Update Bundle Identifier consistently

### Issue: Code generation fails
**Solution:**
- Delete `.dart_tool` and `build` folders
- Run `flutter clean`
- Run `flutter pub get`
- Run generation again

### Issue: Supabase connection fails
**Solution:**
- Verify your Supabase URL and anon key
- Check internet connectivity
- Ensure Supabase project is active

## Next Steps

1. ✅ Set up your backend (Supabase, Firebase, or custom API)
2. ✅ Configure authentication providers
3. ✅ Design your data models
4. ✅ Create your features
5. ✅ Set up CI/CD
6. ✅ Add comprehensive tests
7. ✅ Configure app signing for release
8. ✅ Prepare for deployment

## Getting Help

- Review `TEMPLATE_README.md` for architecture details
- Check the existing code for examples
- Consult Flutter documentation
- Review package-specific documentation

---

**Good luck with your new project! 🚀**
