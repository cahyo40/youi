// [file name]: yo_notification_card.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../display/yo_avatar.dart';

enum NotificationType { message, system, alert, promotion, reminder }

enum NotificationPriority { low, medium, high, urgent }

class YoNotificationCard extends StatelessWidget {
  final String title;
  final String? description;
  final DateTime timestamp;
  final NotificationType type;
  final NotificationPriority priority;
  final String? imageUrl;
  final IconData? icon;
  final Color? iconColor;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;
  final List<Widget>? actions;
  final String? senderName;
  final String? senderAvatarUrl;

  const YoNotificationCard({
    super.key,
    required this.title,
    this.description,
    required this.timestamp,
    this.type = NotificationType.system,
    this.priority = NotificationPriority.medium,
    this.imageUrl,
    this.icon,
    this.iconColor,
    this.isRead = false,
    this.onTap,
    this.onDismiss,
    this.actions,
    this.senderName,
    this.senderAvatarUrl,
  });

  // Message notification dengan sender
  const YoNotificationCard.message({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.senderName,
    required this.senderAvatarUrl,
    this.isRead = false,
    this.onTap,
    this.onDismiss,
    this.actions,
  }) : type = NotificationType.message,
       priority = NotificationPriority.medium,
       imageUrl = null,
       icon = null,
       iconColor = null;

  // Alert notification
  const YoNotificationCard.alert({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    this.priority = NotificationPriority.high,
    this.isRead = false,
    this.onTap,
    this.onDismiss,
    this.actions,
  }) : type = NotificationType.alert,
       imageUrl = null,
       icon = Icons.warning_rounded,
       iconColor = const Color(0xFFEF4444),
       senderName = null,
       senderAvatarUrl = null;

  // Promotion notification dengan image
  const YoNotificationCard.promotion({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.imageUrl,
    this.isRead = false,
    this.onTap,
    this.onDismiss,
    this.actions,
  }) : type = NotificationType.promotion,
       priority = NotificationPriority.low,
       icon = Icons.local_offer_rounded,
       iconColor = const Color(0xFF8B5CF6),
       senderName = null,
       senderAvatarUrl = null;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('notification_${timestamp.millisecondsSinceEpoch}'),
      direction: onDismiss != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: _buildDismissBackground(context),
      onDismissed: (_) => onDismiss?.call(),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: _getSpacing(context, base: 4),
          horizontal: _getSpacing(context, base: 0),
        ),
        decoration: BoxDecoration(
          color: _getCardColor(context),
          borderRadius: BorderRadius.circular(_getBorderRadius(context)),
          border: Border.all(color: _getBorderColor(context), width: 1),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(_getBorderRadius(context)),
            child: Padding(
              padding: _getPadding(context),
              child: _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return YoResponsive.responsiveWidget(
      context: context,
      mobile: _buildMobileContent(context),
      tablet: _buildTabletContent(context),
      desktop: _buildDesktopContent(context),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left section - icon/avatar & read indicator
        _buildLeftSection(context),
        SizedBox(width: _getSpacing(context, base: 12)),

        // Middle section - content
        Expanded(child: _buildContentSection(context)),

        // Right section - timestamp & actions
        _buildRightSection(context),
      ],
    );
  }

  Widget _buildTabletContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLeftSection(context),
        SizedBox(width: _getSpacing(context, base: 16)),
        Expanded(child: _buildContentSection(context)),
        SizedBox(width: _getSpacing(context, base: 16)),
        _buildRightSection(context),
      ],
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return _buildTabletContent(context);
  }

  Widget _buildLeftSection(BuildContext context) {
    return Column(
      children: [
        // Icon/Avatar
        _buildIconOrAvatar(context),

        // Read indicator
        if (!isRead) ...[
          SizedBox(height: _getSpacing(context, base: 4)),
          _buildUnreadIndicator(context),
        ],
      ],
    );
  }

  Widget _buildIconOrAvatar(BuildContext context) {
    if (senderAvatarUrl != null) {
      return YoAvatar.image(
        imageUrl: senderAvatarUrl,
        size: YoAvatarSize.md,
        variant: YoAvatarVariant.circle,
      );
    }

    if (icon != null) {
      return Container(
        width: _getIconSize(context, base: 40),
        height: _getIconSize(context, base: 40),
        decoration: BoxDecoration(
          color:
              iconColor?.withOpacity(0.1) ??
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.8),
        ),
        child: Icon(
          _getIconData(),
          size: _getIconSize(context, base: 20),
          color: iconColor ?? Theme.of(context).colorScheme.primary,
        ),
      );
    }

    return Container(
      width: _getIconSize(context, base: 40),
      height: _getIconSize(context, base: 40),
      decoration: BoxDecoration(
        color: _getDefaultIconColor(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.8),
      ),
      child: Icon(
        _getDefaultIcon(),
        size: _getIconSize(context, base: 20),
        color: _getDefaultIconColor(context),
      ),
    );
  }

  Widget _buildUnreadIndicator(BuildContext context) {
    return Container(
      width: _getSpacing(context, base: 8),
      height: _getSpacing(context, base: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sender name (jika ada)
        if (senderName != null) ...[
          Text(
            senderName!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: _getFontSize(context, base: 14),
            ),
          ),
          SizedBox(height: _getSpacing(context, base: 2)),
        ],

        // Title
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
            fontSize: _getFontSize(context, base: 14),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        // Description
        if (description != null) ...[
          SizedBox(height: _getSpacing(context, base: 4)),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: _getFontSize(context, base: 12),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],

        // Image preview
        if (imageUrl != null) ...[
          SizedBox(height: _getSpacing(context, base: 8)),
          _buildImagePreview(context),
        ],

        // Actions
        if (actions != null && actions!.isNotEmpty) ...[
          SizedBox(height: _getSpacing(context, base: 8)),
          _buildActions(context),
        ],
      ],
    );
  }

  Widget _buildRightSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Timestamp
        Text(
          _formatTimestamp(timestamp),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            fontSize: _getFontSize(context, base: 11),
          ),
        ),

        // Priority indicator
        if (priority == NotificationPriority.urgent) ...[
          SizedBox(height: _getSpacing(context, base: 4)),
          _buildPriorityIndicator(context),
        ],
      ],
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.7),
      child: Image.network(
        imageUrl!,
        width: double.infinity,
        height: _getSpacing(context, base: 80),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: _getSpacing(context, base: 80),
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Icon(
              Icons.image_not_supported_rounded,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        },
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Wrap(
      spacing: _getSpacing(context, base: 8),
      runSpacing: _getSpacing(context, base: 4),
      children: actions!,
    );
  }

  Widget _buildPriorityIndicator(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getSpacing(context, base: 6),
        vertical: _getSpacing(context, base: 2),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withOpacity(0.1),
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.3),
      ),
      child: Text(
        'Urgent',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: const Color(0xFFEF4444),
          fontWeight: FontWeight.w600,
          fontSize: _getFontSize(context, base: 10),
        ),
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(_getBorderRadius(context)),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(_getSpacing(context, base: 16)),
          child: Icon(
            Icons.delete_rounded,
            color: Theme.of(context).colorScheme.onError,
            size: _getIconSize(context, base: 24),
          ),
        ),
      ),
    );
  }

  // ========== HELPER METHODS ==========

  Color _getCardColor(BuildContext context) {
    if (!isRead) {
      return Theme.of(context).colorScheme.primary.withOpacity(0.05);
    }
    return Theme.of(context).colorScheme.surface;
  }

  Color _getBorderColor(BuildContext context) {
    if (priority == NotificationPriority.urgent) {
      return const Color(0xFFEF4444).withOpacity(0.3);
    }
    return Theme.of(context).dividerColor.withOpacity(0.1);
  }

  Color _getDefaultIconColor(BuildContext context) {
    switch (type) {
      case NotificationType.message:
        return Theme.of(context).colorScheme.primary;
      case NotificationType.system:
        return Theme.of(context).colorScheme.secondary;
      case NotificationType.alert:
        return const Color(0xFFEF4444);
      case NotificationType.promotion:
        return const Color(0xFF8B5CF6);
      case NotificationType.reminder:
        return const Color(0xFFF59E0B);
    }
  }

  IconData _getDefaultIcon() {
    switch (type) {
      case NotificationType.message:
        return Icons.message_rounded;
      case NotificationType.system:
        return Icons.notifications_rounded;
      case NotificationType.alert:
        return Icons.warning_rounded;
      case NotificationType.promotion:
        return Icons.local_offer_rounded;
      case NotificationType.reminder:
        return Icons.schedule_rounded;
    }
  }

  IconData _getIconData() {
    if (icon != null) {
      // Convert string to IconData jika diperlukan
      // Untuk simplicity, kita asumsikan icon sudah IconData
      return icon as IconData;
    }
    return _getDefaultIcon();
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'now';
    if (difference.inHours < 1) return '${difference.inMinutes}m';
    if (difference.inDays < 1) return '${difference.inHours}h';
    if (difference.inDays < 7) return '${difference.inDays}d';
    return '${(difference.inDays / 7).floor()}w';
  }

  // ========== RESPONSIVE METHODS ==========

  double _getSpacing(BuildContext context, {required double base}) {
    return context.responsiveValue(
      phone: base * 0.8,
      tablet: base * 1.0,
      desktop: base * 1.2,
    );
  }

  double _getFontSize(BuildContext context, {required double base}) {
    return context.responsiveValue(
      phone: base * 0.9,
      tablet: base * 1.0,
      desktop: base * 1.1,
    );
  }

  double _getIconSize(BuildContext context, {required double base}) {
    return context.responsiveValue(
      phone: base * 0.9,
      tablet: base * 1.0,
      desktop: base * 1.1,
    );
  }

  double _getBorderRadius(BuildContext context) {
    return context.responsiveValue(phone: 12.0, tablet: 16.0, desktop: 20.0);
  }

  EdgeInsets _getPadding(BuildContext context) {
    final padding = context.responsiveValue(
      phone: 12.0,
      tablet: 16.0,
      desktop: 20.0,
    );

    return EdgeInsets.all(padding);
  }
}
