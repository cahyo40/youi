import 'package:flutter/material.dart';

import '../../../../yo_ui_base.dart';

class YoDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget>? actions;
  final Widget? icon;
  final Color? iconColor;
  final double? maxWidth;
  final double? maxHeight;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final Widget? customContent;
  final bool centerTitle;
  final bool centerContent;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;

  const YoDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.icon,
    this.iconColor,
    this.maxWidth,
    this.maxHeight,
    this.showCloseButton = false,
    this.onClose,
    this.customContent,
    this.centerTitle = true,
    this.centerContent = true,
    this.contentPadding,
    this.backgroundColor,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String content,
    List<Widget>? actions,
    Widget? icon,
    Color? iconColor,
    bool barrierDismissible = true,
    double? maxWidth,
    double? maxHeight,
    bool showCloseButton = false,
    VoidCallback? onClose,
    Widget? customContent,
    bool centerTitle = true,
    bool centerContent = true,
    EdgeInsetsGeometry? contentPadding,
    Color? backgroundColor,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => YoDialog(
        title: title,
        content: content,
        actions: actions,
        icon: icon,
        iconColor: iconColor,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        showCloseButton: showCloseButton,
        onClose: onClose,
        customContent: customContent,
        centerTitle: centerTitle,
        centerContent: centerContent,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor ?? YoColors.background(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 4,
      shadowColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.5)
          : Colors.black.withOpacity(0.1),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 400,
          maxHeight: maxHeight ?? 600,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              _buildHeader(context),

              if (icon != null) ...[
                _buildIcon(context),
                const SizedBox(height: 16),
              ],

              // Title
              _buildTitle(context),

              const SizedBox(height: 12),

              // Content
              _buildContent(context),

              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildActions(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    if (!showCloseButton) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            Icons.close_rounded,
            size: 20,
            color: YoColors.gray500(context),
          ),
          onPressed: onClose ?? () => Navigator.of(context).pop(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          splashRadius: 16,
        ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              iconColor?.withOpacity(0.1) ??
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor ?? Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          child: icon!,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return centerTitle
        ? Center(
            child: YoText.titleLarge(
              title,
              align: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : YoText.titleLarge(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          );
  }

  Widget _buildContent(BuildContext context) {
    if (customContent != null) {
      return customContent!;
    }

    final contentWidget = YoText.bodyMedium(
      content,
      color: YoColors.gray600(context),
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
    );

    return centerContent ? Center(child: contentWidget) : contentWidget;
  }

  Widget _buildActions(BuildContext context) {
    if (actions!.length == 1) {
      return SizedBox(width: double.infinity, child: actions!.first);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _buildActionButtons(),
    );
  }

  List<Widget> _buildActionButtons() {
    final List<Widget> widgets = [];

    for (int i = 0; i < actions!.length; i++) {
      widgets.add(Expanded(child: actions![i]));

      if (i < actions!.length - 1) {
        widgets.add(const SizedBox(width: 12));
      }
    }

    return widgets;
  }
}

// Specialized dialog variants
class YoInfoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String actionText;
  final VoidCallback? onAction;
  final Widget? icon;

  const YoInfoDialog({
    super.key,
    required this.title,
    required this.content,
    this.actionText = 'Mengerti',
    this.onAction,
    this.icon,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    String actionText = 'Mengerti',
    VoidCallback? onAction,
    Widget? icon,
    bool barrierDismissible = true,
  }) {
    return YoDialog.show(
      context: context,
      title: title,
      content: content,
      actions: [
        YoButton.primary(
          text: actionText,
          onPressed: onAction ?? () => Navigator.of(context).pop(),
          expanded: true,
        ),
      ],
      icon:
          icon ??
          Icon(
            Icons.info_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoDialog(
      title: title,
      content: content,
      actions: [
        YoButton.primary(
          text: actionText,
          onPressed: onAction ?? () => Navigator.of(context).pop(),
          expanded: true,
        ),
      ],
      icon:
          icon ??
          Icon(
            Icons.info_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}

class YoSuccessDialog extends StatelessWidget {
  final String title;
  final String content;
  final String actionText;
  final VoidCallback? onAction;

  const YoSuccessDialog({
    super.key,
    required this.title,
    required this.content,
    this.actionText = 'Baik',
    this.onAction,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    String actionText = 'Baik',
    VoidCallback? onAction,
    bool barrierDismissible = true,
  }) {
    return YoDialog.show(
      context: context,
      title: title,
      content: content,
      actions: [
        YoButton.primary(
          text: actionText,
          onPressed: onAction ?? () => Navigator.of(context).pop(),
          expanded: true,
        ),
      ],
      icon: Icon(
        Icons.check_circle_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoSuccessDialog(
      title: title,
      content: content,
      actionText: actionText,
      onAction: onAction,
    );
  }
}

class YoErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final String actionText;
  final VoidCallback? onAction;

  const YoErrorDialog({
    super.key,
    required this.title,
    required this.content,
    this.actionText = 'Tutup',
    this.onAction,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    String actionText = 'Tutup',
    VoidCallback? onAction,
    bool barrierDismissible = true,
  }) {
    return YoDialog.show(
      context: context,
      title: title,
      content: content,
      actions: [
        YoButton.primary(
          text: actionText,
          onPressed: onAction ?? () => Navigator.of(context).pop(),
          expanded: true,
        ),
      ],
      icon: Icon(
        Icons.error_outline_rounded,
        color: Theme.of(context).colorScheme.error,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoErrorDialog(
      title: title,
      content: content,
      actionText: actionText,
      onAction: onAction,
    );
  }
}

// Fullscreen dialog for complex content
class YoFullScreenDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final bool showCloseButton;
  final Color? backgroundColor;

  const YoFullScreenDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.showCloseButton = true,
    this.backgroundColor,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool showCloseButton = true,
    Color? backgroundColor,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => YoFullScreenDialog(
        title: title,
        content: content,
        actions: actions,
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor ?? YoColors.background(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      insetPadding: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: showCloseButton
              ? IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: YoColors.text(context),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          title: YoText.titleLarge(title),
          centerTitle: true,
          actions: actions,
        ),
        body: content,
      ),
    );
  }
}
