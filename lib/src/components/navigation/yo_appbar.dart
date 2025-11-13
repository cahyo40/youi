// [file name]: yo_appbar.dart
import 'package:flutter/material.dart';

import '../../../yo_ui.dart';

enum YoAppBarVariant { primary, surface, transparent, elevated }

class YoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final YoAppBarVariant variant;
  final Color? backgroundColor;
  final double elevation;
  final VoidCallback? onBackPressed;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final double? toolbarHeight;

  const YoAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.variant = YoAppBarVariant.primary,
    this.backgroundColor,
    this.elevation = 0,
    this.onBackPressed,
    this.titleStyle,
    this.centerTitle = true,
    this.toolbarHeight,
  });

  const YoAppBar.primary({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.titleStyle,
    this.centerTitle = true,
    this.toolbarHeight,
  }) : variant = YoAppBarVariant.primary,
       backgroundColor = null,
       elevation = 0;

  const YoAppBar.surface({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.titleStyle,
    this.centerTitle = true,
    this.toolbarHeight,
  }) : variant = YoAppBarVariant.surface,
       backgroundColor = null,
       elevation = 1;

  const YoAppBar.transparent({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.titleStyle,
    this.centerTitle = true,
    this.toolbarHeight,
  }) : variant = YoAppBarVariant.transparent,
       backgroundColor = null,
       elevation = 0;

  const YoAppBar.elevated({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.titleStyle,
    this.centerTitle = true,
    this.toolbarHeight,
  }) : variant = YoAppBarVariant.elevated,
       backgroundColor = null,
       elevation = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color effectiveBackgroundColor =
        backgroundColor ?? _getBackgroundColor(context);
    final Color effectiveTitleColor = _getTitleColor(context);
    final double effectiveElevation = _getElevation(context);

    return AppBar(
      title: YoText(
        title,
        style:
            titleStyle ??
            theme.textTheme.titleLarge?.copyWith(
              color: effectiveTitleColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      leading: _buildLeading(context),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: effectiveBackgroundColor,
      elevation: effectiveElevation,
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: effectiveTitleColor),
      actionsIconTheme: IconThemeData(color: effectiveTitleColor),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (automaticallyImplyLeading && Navigator.of(context).canPop()) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        iconSize: 20,
      );
    }

    return null;
  }

  Color _getBackgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (variant) {
      case YoAppBarVariant.primary:
        return colorScheme.primary;
      case YoAppBarVariant.surface:
        return colorScheme.surface;
      case YoAppBarVariant.transparent:
        return Colors.transparent;
      case YoAppBarVariant.elevated:
        return colorScheme.surface;
    }
  }

  Color _getTitleColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (variant) {
      case YoAppBarVariant.primary:
        return context.onPrimaryColor;
      case YoAppBarVariant.surface:
      case YoAppBarVariant.elevated:
        return colorScheme.onSurface;
      case YoAppBarVariant.transparent:
        return colorScheme.onBackground;
    }
  }

  double _getElevation(BuildContext context) {
    switch (variant) {
      case YoAppBarVariant.primary:
      case YoAppBarVariant.transparent:
        return 0;
      case YoAppBarVariant.surface:
        return 1;
      case YoAppBarVariant.elevated:
        return 4;
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
