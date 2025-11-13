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

  // dua baris ini saja
  // Color get onPrimaryBW =>
  //     primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  // Color get onBackgroundBW =>
  //     background.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  Color get onPrimary =>
      primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  Color get onBackground =>
      primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}
