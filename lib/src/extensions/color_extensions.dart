import 'package:flutter/material.dart';

import '../../yo_ui.dart';

extension YoColorContext on BuildContext {
  /* --------------------------------------------------------------- */
  /*  1.  READ THE SCHEME STORED IN THEME EXTENSION                  */
  /* --------------------------------------------------------------- */
  YoCorePalette get _active {
    final bright = Theme.of(this).brightness;
    final scheme =
        Theme.of(this).extension<YoScheme>()?.scheme ??
        YoColorScheme.defaultScheme; // fallback
    return kYoPalettes[scheme]![bright]!;
  }

  /* --------------------------------------------------------------- */
  /*  2.  SAME SHORT-HAND GETTERS AS BEFORE                          */
  /* --------------------------------------------------------------- */
  Color get primaryColor => _active.primary;
  Color get secondaryColor => _active.secondary;
  Color get accentColor => _active.accent;
  Color get backgroundColor => _active.background;
  Color get textColor => _active.text;
  Color get onPrimaryColor => _active.onPrimary;
  Color get onBackgroundColor => _active.onBackground;
  // Color get onPrimaryBW => _active.onPrimaryBW;
  // Color get onBackgroundBW => _active.onBackgroundBW;

  // semantic
  Color get successColor => YoColors.success(this);
  Color get warningColor => YoColors.warning(this);
  Color get errorColor => YoColors.error(this);
  Color get infoColor => YoColors.info(this);

  // grey scale
  Color get gray50 => YoColors.gray50(this);
  Color get gray100 => YoColors.gray100(this);
  Color get gray200 => YoColors.gray200(this);
  Color get gray300 => YoColors.gray300(this);
  Color get gray400 => YoColors.gray400(this);
  Color get gray500 => YoColors.gray500(this);
  Color get gray600 => YoColors.gray600(this);
  Color get gray700 => YoColors.gray700(this);
  Color get gray800 => YoColors.gray800(this);
  Color get gray900 => YoColors.gray900(this);

  // gradients
  Gradient get primaryGradient => YoColors.primaryGradient(this);
  Gradient get accentGradient => YoColors.accentGradient(this);

  Color get colorTextBtn => Theme.of(this).brightness == Brightness.dark
      ? textColor // dari yo_ui
      : backgroundColor; // dari yo_ui
}
