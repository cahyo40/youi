// yo_shadow.dart
// Revisi 2025-06 – ramah dark-mode, light-mode, Flutter ≥ 3.10
import 'package:flutter/material.dart';

import '../../yo_ui.dart'; // mengandung YoColorContext

/// Utility preset bayangan yang otomatis mengikuti tema (dark/light)
// ignore: unintended_html_in_doc_comment
/// Semua method return List<BoxShadow> siap pakai di BoxDecoration
class YoBoxShadow {
  const YoBoxShadow._();

  /* --------------------------------------------------------------- */
  /* 1. Soft & Natural – cocok untuk card, sheet, tile               */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> soft(
    BuildContext context, {
    double blur = 16,
    double y = 4,
  }) {
    final shadowColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black.withOpacity(0.35)
        : Colors.black.withOpacity(0.08);
    return [
      BoxShadow(color: shadowColor, blurRadius: blur, offset: Offset(0, y)),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 2. Primary-tinted – bayangan berwarna primary (brand)           */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> tinted(
    BuildContext context, {
    double blur = 20,
    double y = 6,
  }) {
    final base = context.primaryColor.withOpacity(0.18);
    return [BoxShadow(color: base, blurRadius: blur, offset: Offset(0, y))];
  }

  /* --------------------------------------------------------------- */
  /* 3. Layered – dua lapisan untuk kesan lebih dalam                */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> layered(
    BuildContext context, {
    double blur1 = 4,
    double blur2 = 12,
    double y1 = 2,
    double y2 = 6,
  }) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: (dark ? Colors.black : Colors.black).withOpacity(
          dark ? 0.30 : 0.04,
        ),
        blurRadius: blur1,
        offset: Offset(0, y1),
      ),
      BoxShadow(
        color: (dark ? Colors.black : Colors.black).withOpacity(
          dark ? 0.20 : 0.06,
        ),
        blurRadius: blur2,
        offset: Offset(0, y2),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 4. Dark-Mode Optimised – tetap kelam tanpa over-glow            */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> darkMode(
    BuildContext context, {
    double blur = 24,
    double y = 8,
  }) {
    final shadow = Colors.black.withOpacity(0.45);
    return [BoxShadow(color: shadow, blurRadius: blur, offset: Offset(0, y))];
  }

  /* --------------------------------------------------------------- */
  /* 5. Neumorphism raised – timbul di permukaan putih/abu           */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> neuRaised(
    BuildContext context, {
    double blur = 12,
    double distance = 6,
  }) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final lightColor = dark
        ? context.gray800.withOpacity(0.7)
        : Colors.white.withOpacity(0.8);
    final darkColor = dark
        ? Colors.black.withOpacity(0.5)
        : Colors.black.withOpacity(0.15);
    return [
      BoxShadow(
        color: lightColor,
        blurRadius: blur,
        offset: Offset(-distance, -distance),
      ),
      BoxShadow(
        color: darkColor,
        blurRadius: blur,
        offset: Offset(distance, distance),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 6. Glassmorphism glow – untuk elemen transparan/berwarna        */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> glow(
    BuildContext context, {
    double blur = 40,
    double spread = -8,
  }) {
    final tint = context.primaryColor.withOpacity(0.22);
    return [
      BoxShadow(
        color: tint,
        blurRadius: blur,
        spreadRadius: spread,
        offset: Offset.zero,
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 7. Long-throw drop – bayangan jauh (header floating)            */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> long(
    BuildContext context, {
    double blur = 32,
    double y = 16,
  }) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withOpacity(dark ? 0.50 : 0.12),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 8. Gradient two-tone – dua warna berlapis (promo banner)        */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> gradient(
    BuildContext context, {
    double blur = 24,
    double y1 = 8,
    double y2 = 12,
  }) {
    final c1 = context.primaryColor.withOpacity(0.28);
    final c2 = context.secondaryColor.withOpacity(0.24);
    return [
      BoxShadow(color: c1, blurRadius: blur, offset: Offset(0, y1)),
      BoxShadow(color: c2, blurRadius: blur, offset: Offset(0, y2)),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 9. Sharp & Subtle – hampir tanpa blur (list divider kecil)      */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> sharp(
    BuildContext context, {
    double blur = 2,
    double y = 1,
  }) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withOpacity(dark ? 0.25 : 0.08),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 10. Apple-style – iOS 17 background blur                        */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> apple(
    BuildContext context, {
    double blur1 = 10,
    double blur2 = 24,
    double y1 = 4,
    double y2 = 12,
    double spread2 = -12,
  }) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final base = dark ? Colors.black : Colors.black;
    return [
      BoxShadow(
        color: base.withOpacity(dark ? 0.30 : 0.12),
        blurRadius: blur1,
        offset: Offset(0, y1),
      ),
      BoxShadow(
        color: base.withOpacity(dark ? 0.20 : 0.06),
        blurRadius: blur2,
        spreadRadius: spread2,
        offset: Offset(0, y2),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 11. FAB floating – khusus FloatingActionButton                  */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> floatFab(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: context.primaryColor.withOpacity(dark ? 0.35 : 0.20),
        blurRadius: 16,
        offset: const Offset(0, 6),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(dark ? 0.40 : 0.12),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
    ];
  }

  /* --------------------------------------------------------------- */
  /* 12. Surface elevated – card/section timbul halus                */
  /* --------------------------------------------------------------- */
  static List<BoxShadow> surfaceElevated(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: Colors.black.withOpacity(dark ? 0.40 : 0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(dark ? 0.30 : 0.04),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> neuRaisedYo(
    BuildContext context, {
    double blur = 12,
    double distance = 6,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final lightColor = isDark
        ? context.gray800.withOpacity(0.7)
        : Colors.white.withOpacity(0.8);
    final darkColor = isDark
        ? Colors.black.withOpacity(0.5)
        : Colors.black.withOpacity(0.15);

    return [
      BoxShadow(
        color: lightColor,
        blurRadius: blur,
        offset: Offset(-distance, -distance),
      ),
      BoxShadow(
        color: darkColor,
        blurRadius: blur,
        offset: Offset(distance, distance),
      ),
    ];
  }
}
