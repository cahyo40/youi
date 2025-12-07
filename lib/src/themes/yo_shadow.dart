import 'package:flutter/material.dart';

import '../../yo_ui.dart';

/// Utility shadow presets yang otomatis mengikuti tema (dark/light)
/// Semua method return `List<BoxShadow>` siap pakai di BoxDecoration
class YoBoxShadow {
  const YoBoxShadow._();

  /* --------------------------------------------------------------- */
  /* 1. Soft – bayangan halus untuk card, sheet, tile                */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> soft(
    BuildContext context, {
    double blur = 16,
    double y = 4,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 89 : 20),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 2. Elevated – bayangan standar untuk elevated surfaces          */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> elevated(
    BuildContext context, {
    double blur = 12,
    double y = 4,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 102 : 15),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 77 : 10),
        blurRadius: blur / 2,
        offset: Offset(0, y / 2),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 3. Primary Tinted – bayangan berwarna primary (brand)           */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> tinted(
    BuildContext context, {
    double blur = 20,
    double y = 6,
  }) {
    return [
      BoxShadow(
        color: context.primaryColor.withAlpha(46),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 4. Layered – dua lapisan untuk kesan lebih dalam                */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> layered(
    BuildContext context, {
    double blur1 = 4,
    double blur2 = 12,
    double y1 = 2,
    double y2 = 6,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 77 : 10),
        blurRadius: blur1,
        offset: Offset(0, y1),
      ),
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 51 : 15),
        blurRadius: blur2,
        offset: Offset(0, y2),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 5. Glow – efek glow untuk highlight elements                    */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> glow(
    BuildContext context, {
    Color? color,
    double blur = 24,
    double spread = 0,
  }) {
    final glowColor = color ?? context.primaryColor;
    return [
      BoxShadow(
        color: glowColor.withAlpha(56),
        blurRadius: blur,
        spreadRadius: spread,
        offset: Offset.zero,
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 6. Sharp – bayangan tajam untuk subtle divider/border           */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> sharp(
    BuildContext context, {
    double blur = 2,
    double y = 1,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 64 : 20),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 7. Float – bayangan untuk floating elements (FAB, modal)        */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> float(
    BuildContext context, {
    double blur = 24,
    double y = 8,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 128 : 31),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 8. Button – khusus untuk button dengan primary tint             */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> button(
    BuildContext context, {
    double blur = 12,
    double y = 4,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: context.primaryColor.withAlpha(isDark ? 89 : 51),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
      BoxShadow(
        color: Colors.black.withAlpha(isDark ? 102 : 31),
        blurRadius: blur * 2,
        offset: Offset(0, y * 2),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 9. None – no shadow (untuk consistency)                         */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> none() => [];

  /* --------------------------------------------------------------- */
  /* PRESET SHORTCUTS                                                 */
  /* --------------------------------------------------------------- */

  /// Small shadow for subtle elevation
  static List<BoxShadow> sm(BuildContext context) =>
      soft(context, blur: 8, y: 2);

  /// Medium shadow for cards
  static List<BoxShadow> md(BuildContext context) =>
      soft(context, blur: 16, y: 4);

  /// Large shadow for modals/dialogs
  static List<BoxShadow> lg(BuildContext context) =>
      float(context, blur: 24, y: 8);

  /// Extra large shadow for floating elements
  static List<BoxShadow> xl(BuildContext context) =>
      float(context, blur: 32, y: 12);
}
