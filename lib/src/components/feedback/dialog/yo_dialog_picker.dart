import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

/// Dialog picker untuk tanggal dan waktu
abstract final class YoDialogPicker {
  /// Show date picker dialog
  static Future<DateTime?> date({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      builder: (context, child) => _themedDialog(context, child),
    );
  }

  /// Show time picker dialog
  static Future<TimeOfDay?> time({
    required BuildContext context,
    TimeOfDay? initialTime,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      builder: (context, child) => _themedDialog(context, child),
    );
  }

  /// Show date and time picker (date first, then time)
  static Future<DateTime?> dateTime({
    required BuildContext context,
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final pickedDate = await date(
      context: context,
      initialDate: initialDateTime,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate == null) return null;

    if (!context.mounted) return null;

    final pickedTime = await time(
      context: context,
      initialTime: initialDateTime != null
          ? TimeOfDay.fromDateTime(initialDateTime)
          : null,
    );
    if (pickedTime == null) return null;

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  /// Show date range picker
  static Future<DateTimeRange?> dateRange({
    required BuildContext context,
    DateTimeRange? initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    String? saveText,
  }) async {
    return showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      saveText: saveText,
      builder: (context, child) => _themedDialog(context, child),
    );
  }

  /// Apply theme to picker dialogs
  static Widget _themedDialog(BuildContext context, Widget? child) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: isDark
            ? ColorScheme.dark(
                primary: context.primaryColor,
                onPrimary: context.onPrimaryColor,
                surface: context.backgroundColor,
                onSurface: context.textColor,
              )
            : ColorScheme.light(
                primary: context.primaryColor,
                onPrimary: context.onPrimaryColor,
                surface: context.backgroundColor,
                onSurface: context.textColor,
              ),
        dialogBackgroundColor: context.backgroundColor,
      ),
      child: child!,
    );
  }
}
