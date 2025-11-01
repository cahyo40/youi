import 'package:flutter/material.dart';

import '../themes/yo_text_theme.dart';

extension YoContextExtensions on BuildContext {
  // === COLOR EXTENSIONS ===

  // === TEXT STYLE EXTENSIONS ===

  // Text Styles - Theme aware
  TextStyle get yoDisplayLarge => YoTextTheme.displayLarge(this);
  TextStyle get yoDisplayMedium => YoTextTheme.displayMedium(this);
  TextStyle get yoDisplaySmall => YoTextTheme.displaySmall(this);
  TextStyle get yoHeadlineLarge => YoTextTheme.headlineLarge(this);
  TextStyle get yoHeadlineMedium => YoTextTheme.headlineMedium(this);
  TextStyle get yoHeadlineSmall => YoTextTheme.headlineSmall(this);
  TextStyle get yoTitleLarge => YoTextTheme.titleLarge(this);
  TextStyle get yoTitleMedium => YoTextTheme.titleMedium(this);
  TextStyle get yoTitleSmall => YoTextTheme.titleSmall(this);
  TextStyle get yoBodyLarge => YoTextTheme.bodyLarge(this);
  TextStyle get yoBodyMedium => YoTextTheme.bodyMedium(this);
  TextStyle get yoBodySmall => YoTextTheme.bodySmall(this);
  TextStyle get yoLabelLarge => YoTextTheme.labelLarge(this);
  TextStyle get yoLabelMedium => YoTextTheme.labelMedium(this);
  TextStyle get yoLabelSmall => YoTextTheme.labelSmall(this);
  TextStyle get yoCurrencyLarge => YoTextTheme.monoLarge(this);
  TextStyle get yoCurrencyMedium => YoTextTheme.monoMedium(this);
  TextStyle get yoCurrencySmall => YoTextTheme.monoSmall(this);

  // === SPACING & SCREEN HELPERS ===

  // Spacing
  double get yoSpacingXs => 4;
  double get yoSpacingSm => 8;
  double get yoSpacingMd => 16;
  double get yoSpacingLg => 24;
  double get yoSpacingXl => 32;

  // Screen
  double get yoScreenWidth => MediaQuery.of(this).size.width;
  double get yoScreenHeight => MediaQuery.of(this).size.height;
  bool get yoIsMobile => yoScreenWidth < 600;
  bool get yoIsTablet => yoScreenWidth >= 600 && yoScreenWidth < 1200;
  bool get yoIsDesktop => yoScreenWidth >= 1200;
}
