import 'package:flutter/material.dart';

enum YoIconButtonVariant { primary, secondary, outline, ghost, custom }
enum YoIconButtonShape { circle, rounded }
enum YoIconButtonSize { small, medium, large }

class YoButtonIcon extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final YoIconButtonVariant variant;
  final YoIconButtonShape shape;
  final YoIconButtonSize size;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isLoading;
  final String? tooltip;

  const YoButtonIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = YoIconButtonVariant.primary,
    this.shape = YoIconButtonShape.circle,
    this.size = YoIconButtonSize.medium,
    this.iconColor,
    this.backgroundColor,
    this.isLoading = false,
    this.tooltip,
  });

  // Named constructors
  const YoButtonIcon.primary({
    super.key,
    required this.icon,
    required this.onPressed,
    this.shape = YoIconButtonShape.circle,
    this.size = YoIconButtonSize.medium,
    this.iconColor,
    this.isLoading = false,
    this.tooltip,
  }) : variant = YoIconButtonVariant.primary,
       backgroundColor = null;

  const YoButtonIcon.secondary({
    super.key,
    required this.icon,
    required this.onPressed,
    this.shape = YoIconButtonShape.circle,
    this.size = YoIconButtonSize.medium,
    this.iconColor,
    this.isLoading = false,
    this.tooltip,
  }) : variant = YoIconButtonVariant.secondary,
       backgroundColor = null;

  const YoButtonIcon.outline({
    super.key,
    required this.icon,
    required this.onPressed,
    this.shape = YoIconButtonShape.circle,
    this.size = YoIconButtonSize.medium,
    this.iconColor,
    this.isLoading = false,
    this.tooltip,
  }) : variant = YoIconButtonVariant.outline,
       backgroundColor = null;

  const YoButtonIcon.ghost({
    super.key,
    required this.icon,
    required this.onPressed,
    this.shape = YoIconButtonShape.circle,
    this.size = YoIconButtonSize.medium,
    this.iconColor,
    this.isLoading = false,
    this.tooltip,
  }) : variant = YoIconButtonVariant.ghost,
       backgroundColor = null;

  const YoButtonIcon.custom({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.shape = YoIconButtonShape.circle,
    this.size = YoIconButtonSize.medium,
    this.iconColor,
    this.isLoading = false,
    this.tooltip,
  }) : variant = YoIconButtonVariant.custom;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final buttonSize = _getButtonSize();

    Widget button = Container(
      width: buttonSize,
      height: buttonSize,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: isLoading
            ? SizedBox(
                width: _getLoaderSize(),
                height: _getLoaderSize(),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _getProgressIndicatorColor(context),
                ),
              )
            : IconTheme(
                data: IconThemeData(
                  size: _getIconSize(),
                  color: _getIconColor(context),
                ),
                child: icon,
              ),
      ),
    );

    // Add tooltip if provided
    if (tooltip != null) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case YoIconButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 1;
            if (states.contains(WidgetState.pressed)) return 0;
            return 0;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.12);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary.withOpacity(0.8);
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primary.withOpacity(0.9);
            }
            return colorScheme.primary;
          }),
        );

      case YoIconButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.surfaceVariant,
          foregroundColor: colorScheme.onSurfaceVariant,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 1;
            if (states.contains(WidgetState.pressed)) return 0;
            return 0;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.12);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.surfaceVariant.withOpacity(0.8);
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.surfaceVariant.withOpacity(0.9);
            }
            return colorScheme.surfaceVariant;
          }),
        );

      case YoIconButtonVariant.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          side: BorderSide(
            color: onPressed != null
                ? colorScheme.outline
                : colorScheme.onSurface.withOpacity(0.38),
            width: 1,
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 1;
            if (states.contains(WidgetState.pressed)) return 0;
            return 0;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primary.withOpacity(0.08);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary.withOpacity(0.12);
            }
            return Colors.transparent;
          }),
        );

      case YoIconButtonVariant.ghost:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 0;
            if (states.contains(WidgetState.pressed)) return 0;
            return 0;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primary.withOpacity(0.08);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary.withOpacity(0.12);
            }
            return Colors.transparent;
          }),
        );

      case YoIconButtonVariant.custom:
        final bgColor = backgroundColor ?? colorScheme.primary;
        return ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: _getCustomIconColor(context, bgColor),
          disabledBackgroundColor: bgColor.withOpacity(0.32),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 1;
            if (states.contains(WidgetState.pressed)) return 0;
            return 0;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return bgColor.withOpacity(0.32);
            }
            if (states.contains(WidgetState.pressed)) {
              return bgColor.withOpacity(0.8);
            }
            if (states.contains(WidgetState.hovered)) {
              return bgColor.withOpacity(0.9);
            }
            return bgColor;
          }),
        );
    }
  }

  OutlinedBorder _getShape() {
    switch (shape) {
      case YoIconButtonShape.circle:
        return const CircleBorder();
      case YoIconButtonShape.rounded:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
    }
  }

  double _getButtonSize() {
    switch (size) {
      case YoIconButtonSize.small:
        return 32;
      case YoIconButtonSize.medium:
        return 40;
      case YoIconButtonSize.large:
        return 48;
    }
  }

  double _getIconSize() {
    switch (size) {
      case YoIconButtonSize.small:
        return 16;
      case YoIconButtonSize.medium:
        return 20;
      case YoIconButtonSize.large:
        return 24;
    }
  }

  double _getLoaderSize() {
    switch (size) {
      case YoIconButtonSize.small:
        return 14;
      case YoIconButtonSize.medium:
        return 16;
      case YoIconButtonSize.large:
        return 18;
    }
  }

  Color _getIconColor(BuildContext context) {
    if (iconColor != null) return iconColor!;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case YoIconButtonVariant.primary:
      case YoIconButtonVariant.secondary:
      case YoIconButtonVariant.custom:
        return colorScheme.onPrimary;
      case YoIconButtonVariant.outline:
      case YoIconButtonVariant.ghost:
        return colorScheme.primary;
    }
  }

  Color _getCustomIconColor(BuildContext context, Color bgColor) {
    if (iconColor != null) return iconColor!;

    // Calculate luminance to determine if icon should be light or dark
    final luminance = bgColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Color _getProgressIndicatorColor(BuildContext context) {
    switch (variant) {
      case YoIconButtonVariant.primary:
      case YoIconButtonVariant.secondary:
      case YoIconButtonVariant.custom:
        return Theme.of(context).colorScheme.onPrimary;
      case YoIconButtonVariant.outline:
      case YoIconButtonVariant.ghost:
        return Theme.of(context).colorScheme.primary;
    }
  }
}