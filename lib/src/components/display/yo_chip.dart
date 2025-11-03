// File: yo_chip.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

enum YoChipVariant { filled, outlined, elevated }

enum YoChipSize { small, medium, large }

class YoChip extends StatelessWidget {
  final String label;
  final YoChipVariant variant;
  final YoChipSize size;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool selected;
  final EdgeInsetsGeometry? padding;

  const YoChip({
    super.key,
    required this.label,
    this.variant = YoChipVariant.filled,
    this.size = YoChipSize.medium,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.leading,
    this.trailing,
    this.onTap,
    this.onDeleted,
    this.selected = false,
    this.padding,
  });

  // Predefined chip variants
  const YoChip.primary({
    super.key,
    required this.label,
    this.size = YoChipSize.medium,
    this.variant = YoChipVariant.filled,
    this.leading,
    this.trailing,
    this.onTap,
    this.onDeleted,
  }) : backgroundColor = null, // Will use context
       textColor = null, // Will use context
       borderColor = null, // Will use context
       borderRadius = null,
       selected = false,
       padding = null;

  const YoChip.success({
    super.key,
    required this.label,
    this.size = YoChipSize.medium,
    this.variant = YoChipVariant.filled,
    this.leading,
    this.trailing,
    this.onTap,
    this.onDeleted,
  }) : backgroundColor = null, // Will use context
       textColor = null, // Will use context
       borderColor = null, // Will use context
       borderRadius = null,
       selected = false,
       padding = null;

  @override
  Widget build(BuildContext context) {
    final effectiveColors = _getColors(context);
    final effectivePadding = padding ?? _getPadding();
    final effectiveBorderRadius = borderRadius ?? _getBorderRadius();

    Widget chipChild = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 4)],
        YoText(
          label,
          style: _getTextStyle(
            context,
          )?.copyWith(color: effectiveColors.textColor),
        ),
        if (trailing != null) ...[const SizedBox(width: 4), trailing!],
        if (onDeleted != null) ...[
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDeleted,
            child: Icon(
              Icons.close,
              size: _getIconSize(),
              color: effectiveColors.textColor,
            ),
          ),
        ],
      ],
    );

    final decoration = _getDecoration(
      effectiveColors,
      effectiveBorderRadius,
      context,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: Container(
          padding: effectivePadding,
          decoration: decoration,
          child: chipChild,
        ),
      );
    }

    return Container(
      padding: effectivePadding,
      decoration: decoration,
      child: chipChild,
    );
  }

  _ChipColors _getColors(BuildContext context) {
    switch (variant) {
      case YoChipVariant.filled:
        return _ChipColors(
          backgroundColor: backgroundColor ?? context.primaryColor,
          textColor: textColor ?? context.onPrimaryColor,
          borderColor: borderColor ?? Colors.transparent,
        );
      case YoChipVariant.outlined:
        return _ChipColors(
          backgroundColor: Colors.transparent,
          textColor: textColor ?? context.primaryColor,
          borderColor: borderColor ?? context.primaryColor,
        );
      case YoChipVariant.elevated:
        return _ChipColors(
          backgroundColor: backgroundColor ?? context.backgroundColor,
          textColor: textColor ?? context.textColor,
          borderColor: borderColor ?? Colors.transparent,
        );
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case YoChipSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case YoChipSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case YoChipSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case YoChipSize.small:
        return 12;
      case YoChipSize.medium:
        return 16;
      case YoChipSize.large:
        return 20;
    }
  }

  double _getIconSize() {
    switch (size) {
      case YoChipSize.small:
        return 14;
      case YoChipSize.medium:
        return 16;
      case YoChipSize.large:
        return 18;
    }
  }

  TextStyle? _getTextStyle(BuildContext context) {
    switch (size) {
      case YoChipSize.small:
        return context.yoLabelSmall;
      case YoChipSize.medium:
        return context.yoLabelMedium;
      case YoChipSize.large:
        return context.yoLabelLarge;
    }
  }

  Decoration _getDecoration(
    _ChipColors colors,
    double borderRadius,
    BuildContext context,
  ) {
    switch (variant) {
      case YoChipVariant.filled:
        return BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: colors.borderColor),
        );
      case YoChipVariant.outlined:
        return BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: colors.borderColor),
        );
      case YoChipVariant.elevated:
        return BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: colors.borderColor),
          boxShadow: [
            BoxShadow(
              color: context.gray300.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        );
    }
  }
}

class _ChipColors {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const _ChipColors({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });
}
