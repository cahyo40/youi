import 'package:flutter/material.dart';

import '../../yo_ui.dart';

extension YoDeviceExtensions on BuildContext {
  // Screen size checks
  bool get isPhone => YoDeviceHelper.isPhone(this);
  bool get isTablet => YoDeviceHelper.isTablet(this);
  bool get isLandscape => YoDeviceHelper.isLandscape(this);
  bool get isPortrait => YoDeviceHelper.isPortrait(this);

  // Screen size categories
  ScreenSize get screenSize => YoDeviceHelper.getScreenSize(this);
  ScreenHeight get screenHeight => YoDeviceHelper.getScreenHeight(this);

  // Screen dimensions
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // Device metrics
  double get yoPixelRatio => YoDeviceHelper.getPixelRatio(this);
  double get yoTextScaleFactor => YoDeviceHelper.getTextScaleFactor(this);
  Brightness get yoPlatformBrightness =>
      YoDeviceHelper.getPlatformBrightness(this);

  // Safe area and insets
  EdgeInsets get yoSafeArea => YoDeviceHelper.getSafeAreaPadding(this);
  EdgeInsets get yoViewPadding => YoDeviceHelper.getViewPadding(this);
  EdgeInsets get yoViewInsets => YoDeviceHelper.getViewInsets(this);

  // Notch and navigation bar
  bool get yoHasNotch => YoDeviceHelper.hasNotch(this);
  double get yoNotchHeight => YoDeviceHelper.getNotchHeight(this);
  double get yoBottomNavBarHeight =>
      YoDeviceHelper.getBottomNavigationBarHeight(this);
  double get yoStatusBarHeight => YoDeviceHelper.getStatusBarHeight(this);

  // Keyboard
  bool get yoKeyboardVisible => YoDeviceHelper.isKeyboardVisible(this);
  double get yoKeyboardHeight => YoDeviceHelper.getKeyboardHeight(this);

  // Responsive helpers
  bool get isSmallScreen => screenSize == ScreenSize.small;
  bool get isMediumScreen => screenSize == ScreenSize.medium;
  bool get isLargeScreen => screenSize == ScreenSize.large;

  // Responsive sizing
  double responsiveValue({
    required double phone,
    double? tablet,
    double? desktop,
  }) {
    if (isTablet && tablet != null) return tablet;
    if (isLargeScreen && desktop != null) return desktop;
    return phone;
  }

  // Conditional rendering based on screen size
  T responsiveWidget<T>({required T phone, T? tablet, T? desktop}) {
    if (isTablet && tablet != null) return tablet;
    if (isLargeScreen && desktop != null) return desktop;
    return phone;
  }
}
