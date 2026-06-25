# How to Extract and Use the Base Template

This guide shows you how to extract the `base-template` branch from this repository and use it to start a new Flutter project.

## Quick Start

### Option 1: Clone Only the Template Branch

The fastest way to start with the template:

```bash
# Clone only the base-template branch
git clone -b base-template --single-branch https://github.com/sam-shot/health_tracker your-new-project

# Navigate to your new project
cd your-new-project

# Remove connection to original repo
git remote remove origin

# (Optional) Create a new repository on GitHub and add it
git remote add origin https://github.com/yourusername/your-new-project
git push -u origin base-template

# Or rename the branch to main
git branch -m base-template main
git push -u origin main
```

### Option 2: Create a New Repository from This Branch

If you have write access to this repository:

```bash
# Create a new empty repository on GitHub (don't initialize it)
# Then run these commands:

git clone https://github.com/sam-shot/health_tracker
cd health_tracker
git checkout base-template

# Remove connection to original repo
git remote remove origin

# Add your new repo as origin
git remote add origin https://github.com/yourusername/your-new-project
git push -u origin base-template

# Or push as main branch
git branch -m base-template main
git push -u origin main
```

### Option 3: Fork and Customize

1. Fork this repository on GitHub
2. Clone your fork:
   ```bash
   git clone https://github.com/yourusername/health_tracker your-new-project
   cd your-new-project
   ```
3. Checkout the template branch:
   ```bash
   git checkout base-template
   ```
4. Create a new main branch from it:
   ```bash
   git checkout -b main
   git push -u origin main
   ```
5. (Optional) Delete other branches:
   ```bash
   git branch -d base-template
   git push origin --delete base-template
   ```

## After Extraction

Once you have the template in your new repository:

### 1. Read the Documentation

- **TEMPLATE_README.md** - Overview of the template
- **SETUP_GUIDE.md** - Step-by-step customization instructions
- **TEMPLATE_STRUCTURE.md** - Deep dive into architecture

### 2. Follow Setup Steps

Follow the `SETUP_GUIDE.md` to:
- ✅ Rename your project
- ✅ Update package names
- ✅ Configure Android/iOS/Web
- ✅ Update import statements
- ✅ Set up backend services
- ✅ Customize themes and assets
- ✅ Remove example features if not needed

### 3. Initialize Your Project

```bash
# Install dependencies
flutter pub get

# Run code generation
dart pub run build_runner build --delete-conflicting-outputs

# Test that everything works
flutter run
```

## What's Included in the Template

The `base-template` branch includes:

### ✅ Complete Project Structure
- Feature-first architecture
- Clean separation of concerns
- All necessary folders and organization

### ✅ Core Dependencies Configured
- Riverpod for state management
- Auto Route for navigation
- GetIt + Injectable for DI
- Freezed for immutable models
- SQLite for local storage
- Supabase integration ready

### ✅ Example Feature
The `health_entry` feature serves as a complete example showing:
- How to structure a feature
- Data layer implementation
- State management setup
- UI component organization

You can:
- Keep it as a reference
- Remove it completely
- Modify it for your needs

### ✅ Reusable Components
- Custom buttons
- Text fields
- Snackbars
- Theme system
- Extensions

### ✅ Development Setup
- Code generation configured
- Build configuration ready
- Linting rules included
- .gitignore properly set up

### ✅ Platform Support
- Android (configured)
- iOS (configured)
- Web (configured)
- Linux (partial - SQLite setup)

## Recommended Workflow

### For a Brand New Project

1. **Extract the template** (Option 1 recommended)
2. **Rename everything** following SETUP_GUIDE.md
3. **Remove the example feature** (health_entry)
4. **Start building your features**

### For Learning/Reference

1. **Keep the example feature** to see how everything works
2. **Study the code** to understand patterns
3. **Build alongside it** to compare approaches
4. **Remove when confident** in the architecture

### For Similar Projects

1. **Keep the health_entry feature** as a starting point
2. **Modify the models** to fit your domain
3. **Adjust the UI** to match your design
4. **Extend the functionality**

## Branch Management

### Keep Both Branches in Sync (Advanced)

If you want to keep getting updates from the original template:

```bash
# Add original repo as upstream
git remote add upstream https://github.com/sam-shot/health_tracker

# Fetch updates
git fetch upstream base-template

# Merge updates (be careful of conflicts)
git merge upstream/base-template
```

### Multiple Templates from One Source

You can create multiple projects from this template:

```bash
# Project 1
git clone -b base-template ... project1

# Project 2
git clone -b base-template ... project2

# Each is independent
```

## Common Questions

### Q: Should I keep the original README?
**A:** The original README documents the health tracker app. When using as a template:
1. Rename `README.md` to `ORIGINAL_README.md` (for reference)
2. Rename `TEMPLATE_README.md` to `README.md`
3. Customize the new README for your project

### Q: What about the health_entry feature?
**A:** It's a complete example showing best practices. You can:
- Keep it as reference while building your features
- Modify it to fit your domain
- Delete it completely if you don't need it
- Use it as a starting point and build upon it

### Q: Do I need to reconfigure everything?
**A:** Yes, follow SETUP_GUIDE.md to:
- Change package names
- Update import statements
- Configure platform-specific files
- Set up your backend
- Customize theme and assets

### Q: Can I use this for commercial projects?
**A:** Yes! This is a template designed to be used for any project. Make sure to:
- Update all licenses in your final app
- Replace placeholder API keys
- Configure proper app signing
- Follow platform guidelines

### Q: What if I want different dependencies?
**A:** The template uses popular, production-ready packages. You can:
- Replace Riverpod with Provider/BLoC/etc.
- Use different routing solutions
- Swap SQLite for Hive/Isar
- Change any dependency you prefer

Just maintain the architecture principles.

### Q: Is the template actively maintained?
**A:** The template represents a snapshot of production best practices. Check the original repository for any updates to the `base-template` branch.

## Getting Help

- **Template Issues**: Check TEMPLATE_README.md and TEMPLATE_STRUCTURE.md
- **Setup Problems**: Follow SETUP_GUIDE.md step by step
- **Architecture Questions**: Review TEMPLATE_STRUCTURE.md
- **Flutter Issues**: Consult Flutter documentation
- **Package Issues**: Check package-specific docs

## Contributing Back

If you improve the template or find issues:
1. Open an issue in the original repository
2. Submit a PR to the `base-template` branch
3. Share your improvements with the community

## Success Checklist

After extraction, verify:
- [ ] Project renamed successfully
- [ ] All imports updated
- [ ] Android configuration updated
- [ ] iOS configuration updated
- [ ] Web configuration updated
- [ ] Code generation runs successfully
- [ ] App builds without errors
- [ ] Theme reflects your brand
- [ ] Backend configured (if using)
- [ ] Authentication works (if using)
- [ ] Database operations work
- [ ] Navigation flows properly
- [ ] Documentation updated for your project

## Next Steps

1. ✅ Extract the template using one of the methods above
2. ✅ Follow SETUP_GUIDE.md for customization
3. ✅ Study TEMPLATE_STRUCTURE.md to understand architecture
4. ✅ Start building your amazing Flutter app!

---

**Ready to build something awesome? Let's go! 🚀**

For detailed instructions, refer to:
- **TEMPLATE_README.md** - Template overview
- **SETUP_GUIDE.md** - Customization guide
- **TEMPLATE_STRUCTURE.md** - Architecture details
