import 'package:flutter/material.dart';

import '../../../yo_ui_base.dart';

class YoSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onAction,
    YoSnackBarType type = YoSnackBarType.info,
    Duration duration = const Duration(seconds: 4),
  }) {
    final snackBar = _buildSnackBar(
      context: context,
      message: message,
      actionText: actionText,
      onAction: onAction,
      type: type,
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static SnackBar _buildSnackBar({
    required BuildContext context,
    required String message,
    required String? actionText,
    required VoidCallback? onAction,
    required YoSnackBarType type,
    required Duration duration,
  }) {
    final backgroundColor = _getBackgroundColor(context, type);
    final textColor = _getTextColor(context, type);
    final icon = _getIcon(type);

    return SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: duration,
      content: Row(
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 12),
          Expanded(child: YoText.bodyMedium(message, color: textColor)),
        ],
      ),
      action: actionText != null && onAction != null
          ? SnackBarAction(
              label: actionText,
              textColor: textColor,
              onPressed: onAction,
            )
          : null,
    );
  }

  static Color _getBackgroundColor(BuildContext context, YoSnackBarType type) {
    switch (type) {
      case YoSnackBarType.success:
        return YoColors.success(context);
      case YoSnackBarType.error:
        return YoColors.error(context);
      case YoSnackBarType.warning:
        return YoColors.warning(context);
      case YoSnackBarType.info:
        return YoColors.info(context);
    }
  }

  static Color _getTextColor(BuildContext context, YoSnackBarType type) {
    return YoColors.white;
  }

  static IconData _getIcon(YoSnackBarType type) {
    switch (type) {
      case YoSnackBarType.success:
        return Icons.check_circle;
      case YoSnackBarType.error:
        return Icons.error;
      case YoSnackBarType.warning:
        return Icons.warning;
      case YoSnackBarType.info:
        return Icons.info;
    }
  }
}

enum YoSnackBarType { success, error, warning, info }
