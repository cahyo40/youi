import 'package:flutter/material.dart';

import '../../../yo_ui_base.dart';

class YoEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final Widget? icon;
  final String? actionText;
  final VoidCallback? onAction;
  final YoEmptyStateType type;

  const YoEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.actionText,
    this.onAction,
    this.type = YoEmptyStateType.general,
  });

  const YoEmptyState.noData({
    super.key,
    this.title = 'Tidak ada data',
    this.description = 'Data yang Anda cari tidak ditemukan',
    this.actionText,
    this.onAction,
  }) : icon = const Icon(Icons.inbox_outlined, size: 64),
       type = YoEmptyStateType.noData;

  const YoEmptyState.noConnection({
    super.key,
    this.title = 'Tidak ada koneksi',
    this.description = 'Periksa koneksi internet Anda dan coba lagi',
    this.actionText = 'Coba Lagi',
    this.onAction,
  }) : icon = const Icon(Icons.wifi_off, size: 64),
       type = YoEmptyStateType.noConnection;

  const YoEmptyState.error({
    super.key,
    this.title = 'Terjadi kesalahan',
    this.description = 'Maaf, terjadi kesalahan. Silakan coba lagi',
    this.actionText = 'Coba Lagi',
    this.onAction,
  }) : icon = const Icon(Icons.error_outline, size: 64),
       type = YoEmptyStateType.error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(size: 64, color: _getIconColor(context)),
                child: icon!,
              ),
              const SizedBox(height: 24),
            ],
            YoText.titleLarge(
              title,
              align: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            YoText.bodyMedium(
              description,
              align: TextAlign.center,
              color: YoColors.gray600(context),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              YoButton.primary(
                text: actionText!,
                onPressed: onAction,
                size: YoButtonSize.medium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getIconColor(BuildContext context) {
    switch (type) {
      case YoEmptyStateType.noData:
        return YoColors.gray400(context);
      case YoEmptyStateType.noConnection:
        return YoColors.warning(context);
      case YoEmptyStateType.error:
        return YoColors.error(context);
      case YoEmptyStateType.general:
        return YoColors.primary(context);
    }
  }
}

enum YoEmptyStateType { general, noData, noConnection, error }
