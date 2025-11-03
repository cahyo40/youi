import 'package:flutter/material.dart';

import '../../../../yo_ui_base.dart';

class YoConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;
  final bool isDestructive;
  final Widget? icon;
  final bool showCancelButton;
  final YoButtonSize buttonSize;
  final bool isLoading;

  const YoConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText = 'Batal',
    this.onCancel,
    this.confirmColor,
    this.isDestructive = false,
    this.icon,
    this.showCancelButton = true,
    this.buttonSize = YoButtonSize.medium,
    this.isLoading = false,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    String cancelText = 'Batal',
    Color? confirmColor,
    bool isDestructive = false,
    Widget? icon,
    bool barrierDismissible = true,
    bool showCancelButton = true,
    YoButtonSize buttonSize = YoButtonSize.medium,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => YoConfirmDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
        confirmColor: confirmColor,
        isDestructive: isDestructive,
        icon: icon,
        showCancelButton: showCancelButton,
        buttonSize: buttonSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confirmButtonColor =
        confirmColor ??
        (isDestructive ? theme.colorScheme.error : theme.colorScheme.primary);

    return Dialog(
      backgroundColor: YoColors.background(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Center(child: icon),
              const SizedBox(height: 16),
            ],

            // Title
            YoText.titleLarge(
              title,
              color: isDestructive ? theme.colorScheme.error : null,
            ),

            const SizedBox(height: 12),

            // Content
            YoText.bodyMedium(content, color: YoColors.gray600(context)),

            const SizedBox(height: 24),

            // Buttons Section
            _buildButtons(context, confirmButtonColor),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, Color confirmButtonColor) {
    if (!showCancelButton) {
      // Single button layout
      return YoButton.custom(
        text: confirmText,
        onPressed: isLoading ? null : onConfirm,
        backgroundColor: confirmButtonColor,
        size: buttonSize,
        isLoading: isLoading,
        expanded: true,
      );
    }

    // Dual buttons layout
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: YoButton.outline(
            text: cancelText,
            onPressed: onCancel ?? () => Navigator.of(context).pop(false),
            size: buttonSize,
          ),
        ),

        const SizedBox(width: 12),

        // Confirm Button
        Expanded(
          child: YoButton.custom(
            text: confirmText,
            onPressed: isLoading ? null : onConfirm,
            backgroundColor: confirmButtonColor,
            size: buttonSize,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}

// Enhanced version with more customization options
class YoAdvancedConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;
  final Color? cancelColor;
  final bool isDestructive;
  final Widget? icon;
  final bool showCancelButton;
  final YoButtonVariant confirmVariant;
  final YoButtonVariant cancelVariant;
  final YoButtonSize buttonSize;
  final bool isLoading;
  final Widget? customContent;
  final double? width;
  final bool centerTitle;

  const YoAdvancedConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText = 'Batal',
    this.onCancel,
    this.confirmColor,
    this.cancelColor,
    this.isDestructive = false,
    this.icon,
    this.showCancelButton = true,
    this.confirmVariant = YoButtonVariant.primary,
    this.cancelVariant = YoButtonVariant.outline,
    this.buttonSize = YoButtonSize.medium,
    this.isLoading = false,
    this.customContent,
    this.width,
    this.centerTitle = false,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    String cancelText = 'Batal',
    Color? confirmColor,
    Color? cancelColor,
    bool isDestructive = false,
    Widget? icon,
    bool barrierDismissible = true,
    bool showCancelButton = true,
    YoButtonVariant confirmVariant = YoButtonVariant.primary,
    YoButtonVariant cancelVariant = YoButtonVariant.outline,
    YoButtonSize buttonSize = YoButtonSize.medium,
    Widget? customContent,
    double? width,
    bool centerTitle = false,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => YoAdvancedConfirmDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
        confirmColor: confirmColor,
        cancelColor: cancelColor,
        isDestructive: isDestructive,
        icon: icon,
        showCancelButton: showCancelButton,
        confirmVariant: confirmVariant,
        cancelVariant: cancelVariant,
        buttonSize: buttonSize,
        customContent: customContent,
        width: width,
        centerTitle: centerTitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confirmButtonColor =
        confirmColor ??
        (isDestructive ? theme.colorScheme.error : theme.colorScheme.primary);

    return Dialog(
      backgroundColor: YoColors.background(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Center(child: icon),
              const SizedBox(height: 16),
            ],

            // Title
            if (centerTitle)
              Center(
                child: YoText.titleLarge(
                  title,
                  color: isDestructive ? theme.colorScheme.error : null,
                ),
              )
            else
              YoText.titleLarge(
                title,
                color: isDestructive ? theme.colorScheme.error : null,
              ),

            const SizedBox(height: 12),

            // Content
            if (customContent != null)
              customContent!
            else
              YoText.bodyMedium(content, color: YoColors.gray600(context)),

            const SizedBox(height: 24),

            // Buttons Section
            _buildButtons(context, confirmButtonColor),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, Color confirmButtonColor) {
    if (!showCancelButton) {
      return YoButton(
        text: confirmText,
        onPressed: isLoading ? null : onConfirm,
        variant: confirmVariant,
        size: buttonSize,
        isLoading: isLoading,
        expanded: true,
        backgroundColor: confirmVariant == YoButtonVariant.custom
            ? confirmButtonColor
            : null,
        textColor: confirmVariant == YoButtonVariant.custom
            ? _getCustomTextColor(context, confirmButtonColor)
            : null,
      );
    }

    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: YoButton(
            text: cancelText,
            onPressed: onCancel ?? () => Navigator.of(context).pop(false),
            variant: cancelVariant,
            size: buttonSize,
            backgroundColor: cancelVariant == YoButtonVariant.custom
                ? (cancelColor ?? YoColors.gray300(context))
                : null,
            textColor: cancelVariant == YoButtonVariant.custom
                ? _getCustomTextColor(
                    context,
                    cancelColor ?? YoColors.gray300(context),
                  )
                : null,
          ),
        ),

        const SizedBox(width: 12),

        // Confirm Button
        Expanded(
          child: YoButton(
            text: confirmText,
            onPressed: isLoading ? null : onConfirm,
            variant: confirmVariant,
            size: buttonSize,
            isLoading: isLoading,
            backgroundColor: confirmVariant == YoButtonVariant.custom
                ? confirmButtonColor
                : null,
            textColor: confirmVariant == YoButtonVariant.custom
                ? _getCustomTextColor(context, confirmButtonColor)
                : null,
          ),
        ),
      ],
    );
  }

  Color _getCustomTextColor(BuildContext context, Color bgColor) {
    final luminance = bgColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

// Quick confirmation dialogs for common use cases
class YoConfirmDialogHelper {
  static Future<bool?> showDestructive({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    String cancelText = 'Batal',
    Widget? icon,
  }) {
    return YoConfirmDialog.show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      isDestructive: true,
      icon:
          icon ??
          Icon(
            Icons.warning_rounded,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
    );
  }

  static Future<bool?> showSuccess({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    String cancelText = 'Batal',
    Widget? icon,
  }) {
    return YoConfirmDialog.show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      icon:
          icon ??
          Icon(
            Icons.check_circle_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 48,
          ),
    );
  }

  static Future<bool?> showInfo({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    String cancelText = 'Batal',
    Widget? icon,
  }) {
    return YoConfirmDialog.show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      icon:
          icon ??
          Icon(
            Icons.info_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 48,
          ),
    );
  }
}
