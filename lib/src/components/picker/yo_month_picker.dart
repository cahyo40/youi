// File: yo_month_picker.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoMonthPicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onMonthChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? labelText;
  final String? hintText;
  final IconData? icon;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final bool showYear;

  const YoMonthPicker({
    super.key,
    this.selectedDate,
    required this.onMonthChanged,
    this.firstDate,
    this.lastDate,
    this.labelText,
    this.hintText,
    this.icon,
    this.enabled = true,
    this.padding,
    this.borderRadius = 8.0,
    this.borderColor,
    this.backgroundColor,
    this.showYear = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectMonth(context),
      child: Container(
        padding: padding ?? EdgeInsets.all(context.yoSpacingMd),
        decoration: BoxDecoration(
          color: backgroundColor ?? context.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor ?? context.gray300, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              icon ?? Icons.calendar_month,
              color: enabled ? context.primaryColor : context.gray400,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (labelText != null) ...[
                    YoText(
                      labelText!,
                      style: context.yoLabelSmall.copyWith(
                        color: context.gray500,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  YoText(
                    selectedDate != null
                        ? _formatMonth(selectedDate!)
                        : hintText ?? 'Select month',
                    style: context.yoBodyMedium.copyWith(
                      color: selectedDate != null
                          ? context.textColor
                          : context.gray400,
                      fontWeight: selectedDate != null
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down, color: context.gray500),
          ],
        ),
      ),
    );
  }

  String _formatMonth(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final monthName = months[date.month - 1];
    return showYear ? '$monthName ${date.year}' : monthName;
  }

  Future<void> _selectMonth(BuildContext context) async {
    if (!enabled) return;

    final DateTime? picked = await YoDialogPicker.month(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != selectedDate) {
      onMonthChanged(picked);
    }
  }
}
