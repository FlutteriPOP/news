import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  /// ---------- THEME ---------- ///
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;

  bool get isDark => theme.brightness == Brightness.dark;

  /// ---------- SIZE ---------- ///
  Size get size => MediaQuery.sizeOf(this);

  double get width => size.width;

  double get height => size.height;

  /// ---------- PADDING ---------- ///
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  double get topPadding => padding.top;

  double get bottomPadding => padding.bottom;

  /// ---------- VIEW INSETS (KEYBOARD) ---------- ///
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  bool get isKeyboardOpen => viewInsets.bottom > 0;

  /// ---------- SAFE AREA ---------- ///
  double get safeHeight => height - padding.top - padding.bottom;

  /// ---------- UNFOCUS ---------- ///
  void unfocus() => FocusScope.of(this).unfocus();
}
