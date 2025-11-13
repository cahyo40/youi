// File: yo_dialog_picker.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

abstract final class YoDialogPicker {
  /// Dialog pemilihan tanggal saja.
  static Future<DateTime?> date({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) => _themedDialog(context, child),
    );
  }

  /// Dialog pemilihan waktu saja.
  static Future<TimeOfDay?> time({
    required BuildContext context,
    TimeOfDay? initialTime,
  }) async {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) => _themedDialog(context, child),
    );
  }

  /// Dialog pemilihan tanggal & waktu (urutan: tanggal → waktu).
  static Future<DateTime?> dateTime({
    required BuildContext context,
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? pickedDate = await date(
      context: context,
      initialDate: initialDateTime,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate == null) return null;

    final TimeOfDay? pickedTime = await time(
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

  /// Helper agar dialog mengikuti tema aplikasi.
  static Widget _themedDialog(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
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
