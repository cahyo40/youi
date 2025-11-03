import 'package:flutter/material.dart';

import '../../../yo_ui_base.dart';

class YoLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final String? message;
  final Widget child;
  final Color? overlayColor;

  const YoLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.overlayColor,
  });

  static void show({
    required BuildContext context,
    String? message,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => _FullScreenLoading(message: message),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: overlayColor ?? Colors.black.withValues(alpha: 0.5),
            child: Center(
              child: _LoadingContent(message: message),
            ),
          ),
      ],
    );
  }
}

class _FullScreenLoading extends StatelessWidget {
  final String? message;

  const _FullScreenLoading({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(40),
      child: _LoadingContent(message: message),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  final String? message;

  const _LoadingContent({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: YoColors.background(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const YoLoading.spinner(size: 32),
          if (message != null) ...[
            const SizedBox(height: 16),
            YoText.bodyMedium(
              message!,
              color: YoColors.gray600(context),
              align: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}