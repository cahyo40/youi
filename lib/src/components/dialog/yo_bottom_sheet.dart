import 'package:flutter/material.dart';

import '../../../yo_ui_base.dart';

class YoBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final double? maxHeight;
  final EdgeInsetsGeometry? contentPadding;
  final bool showDragHandle;
  final bool showDivider;

  const YoBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.maxHeight,
    this.contentPadding,
    this.showDragHandle = true,
    this.showDivider = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    List<Widget>? actions,
    double? maxHeight,
    EdgeInsetsGeometry? contentPadding,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool showDragHandle = true,
    bool showDivider = true,
    RouteSettings? routeSettings,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      isDismissible: true,
      enableDrag: true,
      routeSettings: routeSettings,
      builder: (context) => YoBottomSheet(
        title: title,
        actions: actions,
        maxHeight: maxHeight,
        contentPadding: contentPadding,
        showDragHandle: showDragHandle,
        showDivider: showDivider,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxSheetHeight =
        maxHeight ?? MediaQuery.of(context).size.height * 0.8;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + safeAreaBottom, // Account for bottom safe area
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          if (showDragHandle) ...[
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: YoColors.gray400(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
          ],
          // Content
          Container(
            constraints: BoxConstraints(maxHeight: maxSheetHeight),
            decoration: BoxDecoration(
              color: YoColors.background(context),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: YoText.titleLarge(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (actions != null) ...[
                        const SizedBox(width: 12),
                        ...actions!,
                      ],
                    ],
                  ),
                ),
                // Divider
                if (showDivider) ...[
                  Container(height: 1, color: YoColors.gray200(context)),
                ],
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: contentPadding ?? const EdgeInsets.all(20),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
