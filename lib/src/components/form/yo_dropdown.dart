// File: yo_dropdown.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoDropDown<T> extends StatelessWidget {
  final T? value;
  final ValueChanged<T?> onChanged;
  final List<YoDropDownItem<T>> items;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;

  const YoDropDown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.labelText,
    this.hintText,
    this.icon,
    this.enabled = true,
    this.padding,
    this.borderRadius = 8.0,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(context.yoSpacingMd),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? context.gray300, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          onChanged: enabled ? onChanged : null,
          items: items.map((item) => item.toDropdownMenuItem(context)).toList(),
          isExpanded: true,
          icon: icon ?? Icon(Icons.arrow_drop_down, color: context.gray500),
          hint: hintText != null
              ? YoText.bodyMedium(hintText!, color: context.gray400)
              : null,
          dropdownColor: context.backgroundColor,
        ),
      ),
    );
  }
}

class YoDropDownItem<T> {
  final T value;
  final String label;
  final Widget? leading;
  final Widget? trailing;

  const YoDropDownItem({
    required this.value,
    required this.label,
    this.leading,
    this.trailing,
  });

  DropdownMenuItem<T> toDropdownMenuItem(BuildContext context) {
    return DropdownMenuItem<T>(
      value: value,
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 8)],
          Expanded(child: YoText.bodyMedium(label)),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );
  }
}
