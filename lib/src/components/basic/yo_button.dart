import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

enum YoButtonVariant { primary, secondary, outline, ghost, custom, neumorphism }

enum YoButtonSize { small, medium, large }

enum IconPosition { left, right }

class YoButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final YoButtonVariant variant;
  final YoButtonSize size;
  final Widget? icon;
  final IconPosition iconPosition;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isLoading;
  final bool expanded;
  final double? width;
  final double? height;
  final double? borderRadius;

  const YoButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = YoButtonVariant.primary,
    this.size = YoButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.textColor,
    this.backgroundColor,
    this.isLoading = false,
    this.expanded = false,
    this.width,
    this.height,
    this.borderRadius,
  });

  const YoButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = YoButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.textColor,
    this.isLoading = false,
    this.expanded = false,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = YoButtonVariant.primary,
       backgroundColor = null;

  const YoButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = YoButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.textColor,
    this.isLoading = false,
    this.expanded = false,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = YoButtonVariant.secondary,
       backgroundColor = null;

  const YoButton.outline({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = YoButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.textColor,
    this.isLoading = false,
    this.expanded = false,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = YoButtonVariant.outline,
       backgroundColor = null;

  const YoButton.ghost({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = YoButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.textColor,
    this.isLoading = false,
    this.expanded = false,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = YoButtonVariant.ghost,
       backgroundColor = null;

  const YoButton.custom({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.size = YoButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.textColor,
    this.isLoading = false,
    this.expanded = false,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = YoButtonVariant.custom;

  const YoButton.neumorphism({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = YoButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.textColor,
    this.isLoading = false,
    this.expanded = false,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = YoButtonVariant.neumorphism,
       backgroundColor = null;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final padding = _getPadding();
    final textStyle = _getTextStyle(context);

    Widget child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _getProgressIndicatorColor(context),
            ),
          )
        : Row(
            mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildContent(textStyle),
          );

    final buttonChild = Container(
      padding: padding,
      width: width,
      height: height,
      child: child,
    );

    if (variant == YoButtonVariant.neumorphism) {
      return GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
            boxShadow: YoBoxShadow.neuRaisedYo(context),
          ),
          child: child,
        ),
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: buttonChild,
    );
  }

  List<Widget> _buildContent(TextStyle textStyle) {
    final textWidget = Flexible(
      child: Text(
        text,
        style: textStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );

    if (icon == null) return [textWidget];

    final gap = SizedBox(width: _getIconSpacing());
    final iconWidget = IconTheme(
      data: IconThemeData(size: _getIconSize(), color: textStyle.color),
      child: icon!,
    );

    return iconPosition == IconPosition.right
        ? [textWidget, gap, iconWidget]
        : [iconWidget, gap, textWidget];
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case YoButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
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

      case YoButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.surfaceVariant,
          foregroundColor: colorScheme.onSurfaceVariant,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
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

      case YoButtonVariant.outline:
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

      case YoButtonVariant.ghost:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
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

      case YoButtonVariant.custom:
        final bgColor = backgroundColor ?? colorScheme.primary;
        return ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: _getCustomTextColor(context, bgColor),
          disabledBackgroundColor: bgColor.withOpacity(0.32),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: _getShape(),
          padding: EdgeInsets.zero,
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

      case YoButtonVariant.neumorphism:
        throw UnsupportedError(
          "Neumorphism uses GestureDetector, not ElevatedButton",
        );
    }
  }

  OutlinedBorder _getShape() => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 6),
  );

  EdgeInsets _getPadding() {
    switch (size) {
      case YoButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case YoButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
      case YoButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
  }

  Color _getCustomTextColor(BuildContext context, Color bgColor) {
    if (textColor != null) return textColor!;
    final luminance = bgColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Color _getProgressIndicatorColor(BuildContext context) {
    switch (variant) {
      case YoButtonVariant.primary:
      case YoButtonVariant.secondary:
      case YoButtonVariant.custom:
        return Theme.of(context).colorScheme.onPrimary;
      case YoButtonVariant.outline:
      case YoButtonVariant.ghost:
      case YoButtonVariant.neumorphism:
        return Theme.of(context).colorScheme.primary;
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    final baseTextStyle = theme.textTheme;

    Color? textColor;
    switch (variant) {
      case YoButtonVariant.primary:
      case YoButtonVariant.secondary:
        textColor = this.textColor ?? context.onPrimaryColor;
        break;
      case YoButtonVariant.custom:
        textColor = this.textColor ?? theme.colorScheme.onPrimary;
        break;
      case YoButtonVariant.outline:
      case YoButtonVariant.ghost:
      case YoButtonVariant.neumorphism:
        textColor = this.textColor ?? theme.colorScheme.primary;
        break;
    }

    switch (size) {
      case YoButtonSize.small:
        return baseTextStyle.labelMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        );
      case YoButtonSize.medium:
        return baseTextStyle.bodyMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        );
      case YoButtonSize.large:
        return baseTextStyle.bodyLarge!.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        );
    }
  }

  double _getIconSpacing() {
    switch (size) {
      case YoButtonSize.small:
        return 8;
      case YoButtonSize.medium:
        return 10;
      case YoButtonSize.large:
        return 12;
    }
  }

  double _getIconSize() {
    switch (size) {
      case YoButtonSize.small:
        return 16;
      case YoButtonSize.medium:
        return 18;
      case YoButtonSize.large:
        return 20;
    }
  }
}
