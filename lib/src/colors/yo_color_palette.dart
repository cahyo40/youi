import 'package:flutter/material.dart';

class YoCorePalette {
  final Color text;
  final Color background;
  final Color primary;
  final Color secondary;
  final Color accent;

  const YoCorePalette({
    required this.text,
    required this.background,
    required this.primary,
    required this.secondary,
    required this.accent,
  });

  Color get onPrimary =>
      primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  Color get onBackground =>
      background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}
