import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  /// Returns the current [ThemeData] from the context.
  ThemeData get theme => Theme.of(this);

  /// Returns the current [TextTheme] from the context.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the current [ColorScheme] from the context.
  ColorScheme get colorScheme => theme.colorScheme;

  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;
}
