// [file name]: yo_avatar.dart
import 'package:flutter/material.dart';

import '../../yo_ui.dart';

enum YoAvatarSize { xs, sm, md, lg, xl }

enum YoAvatarVariant { circle, rounded, square }

class YoAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final YoAvatarSize size;
  final YoAvatarVariant variant;
  final double? borderRadius;
  final bool showBadge;
  final Color? badgeColor;
  final Widget? customBadge;
  final VoidCallback? onTap;

  const YoAvatar({
    super.key,
    this.imageUrl,
    this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.size = YoAvatarSize.md,
    this.variant = YoAvatarVariant.circle,
    this.borderRadius,
    this.showBadge = false,
    this.badgeColor,
    this.customBadge,
    this.onTap,
  }) : assert(
         imageUrl != null || text != null || icon != null,
         'Either imageUrl, text, or icon must be provided',
       );

  // Named constructor untuk image avatar
  const YoAvatar.image({
    super.key,
    required this.imageUrl,
    this.size = YoAvatarSize.md,
    this.variant = YoAvatarVariant.circle,
    this.borderRadius,
    this.showBadge = false,
    this.badgeColor,
    this.customBadge,
    this.onTap,
  }) : text = null,
       icon = null,
       backgroundColor = null,
       textColor = null,
       iconColor = null;

  // Named constructor untuk text avatar
  const YoAvatar.text({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.size = YoAvatarSize.md,
    this.variant = YoAvatarVariant.circle,
    this.borderRadius,
    this.showBadge = false,
    this.badgeColor,
    this.customBadge,
    this.onTap,
  }) : imageUrl = null,
       icon = null,
       iconColor = null;

  // Named constructor untuk icon avatar
  const YoAvatar.icon({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size = YoAvatarSize.md,
    this.variant = YoAvatarVariant.circle,
    this.borderRadius,
    this.showBadge = false,
    this.badgeColor,
    this.customBadge,
    this.onTap,
  }) : imageUrl = null,
       text = null,
       textColor = null;

  @override
  Widget build(BuildContext context) {
    final double avatarSize = _getSize();
    final BorderRadius effectiveBorderRadius = _getBorderRadius();

    Widget avatarContent = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        color: backgroundColor ?? _getDefaultBackgroundColor(context),
      ),
      child: _buildAvatarContent(context),
    );

    // Wrap dengan GestureDetector jika ada onTap
    if (onTap != null) {
      avatarContent = GestureDetector(onTap: onTap, child: avatarContent);
    }

    // Tambahkan badge jika diperlukan
    if (showBadge || customBadge != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          avatarContent,
          Positioned(
            top: -2,
            right: -2,
            child: customBadge ?? _buildDefaultBadge(context),
          ),
        ],
      );
    }

    return avatarContent;
  }

  Widget _buildAvatarContent(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: _getBorderRadius(),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackContent(context);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
              ),
            );
          },
        ),
      );
    }

    return _buildFallbackContent(context);
  }

  Widget _buildFallbackContent(BuildContext context) {
    if (text != null) {
      return Center(
        child: YoText(
          _getInitials(text!),
          style: TextStyle(
            color: textColor ?? _getDefaultTextColor(context),
            fontSize: _getTextSize(),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    if (icon != null) {
      return Center(
        child: Icon(
          icon,
          size: _getIconSize(),
          color: iconColor ?? _getDefaultIconColor(context),
        ),
      );
    }

    // Fallback ke icon user
    return Center(
      child: Icon(
        Icons.person,
        size: _getIconSize(),
        color: iconColor ?? _getDefaultIconColor(context),
      ),
    );
  }

  Widget _buildDefaultBadge(BuildContext context) {
    final Color effectiveBadgeColor =
        badgeColor ?? Theme.of(context).colorScheme.primary;

    return Container(
      width: _getBadgeSize(),
      height: _getBadgeSize(),
      decoration: BoxDecoration(
        color: effectiveBadgeColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.background,
          width: 1.5,
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0].length > 2
          ? parts[0].substring(0, 2).toUpperCase()
          : parts[0].toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  double _getSize() {
    switch (size) {
      case YoAvatarSize.xs:
        return 24;
      case YoAvatarSize.sm:
        return 32;
      case YoAvatarSize.md:
        return 40;
      case YoAvatarSize.lg:
        return 56;
      case YoAvatarSize.xl:
        return 72;
    }
  }

  double _getTextSize() {
    switch (size) {
      case YoAvatarSize.xs:
        return 10;
      case YoAvatarSize.sm:
        return 12;
      case YoAvatarSize.md:
        return 14;
      case YoAvatarSize.lg:
        return 16;
      case YoAvatarSize.xl:
        return 18;
    }
  }

  double _getIconSize() {
    switch (size) {
      case YoAvatarSize.xs:
        return 12;
      case YoAvatarSize.sm:
        return 16;
      case YoAvatarSize.md:
        return 20;
      case YoAvatarSize.lg:
        return 24;
      case YoAvatarSize.xl:
        return 28;
    }
  }

  double _getBadgeSize() {
    switch (size) {
      case YoAvatarSize.xs:
        return 8;
      case YoAvatarSize.sm:
        return 10;
      case YoAvatarSize.md:
        return 12;
      case YoAvatarSize.lg:
        return 14;
      case YoAvatarSize.xl:
        return 16;
    }
  }

  BorderRadius _getBorderRadius() {
    final double radius = borderRadius ?? _getDefaultBorderRadius();

    switch (variant) {
      case YoAvatarVariant.circle:
        return BorderRadius.circular(_getSize() / 2);
      case YoAvatarVariant.rounded:
        return BorderRadius.circular(radius);
      case YoAvatarVariant.square:
        return BorderRadius.circular(radius);
    }
  }

  double _getDefaultBorderRadius() {
    switch (variant) {
      case YoAvatarVariant.circle:
        return _getSize() / 2;
      case YoAvatarVariant.rounded:
        return 8;
      case YoAvatarVariant.square:
        return 4;
    }
  }

  Color _getDefaultBackgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return colorScheme.surfaceVariant;
  }

  Color _getDefaultTextColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return colorScheme.onSurfaceVariant;
  }

  Color _getDefaultIconColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return colorScheme.onSurfaceVariant;
  }
}

// Group Avatar untuk menampilkan multiple avatars
class YoAvatarGroup extends StatelessWidget {
  final List<YoAvatar> avatars;
  final double overlap;
  final YoAvatarSize size;
  final int maxDisplay;
  final Widget? moreBuilder;

  const YoAvatarGroup({
    super.key,
    required this.avatars,
    this.overlap = 0.7,
    this.size = YoAvatarSize.md,
    this.maxDisplay = 4,
    this.moreBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final displayAvatars = avatars.take(maxDisplay).toList();
    final remainingCount = avatars.length - maxDisplay;

    return SizedBox(
      height: _getSize(),
      child: Stack(
        children: [
          ...displayAvatars.asMap().entries.map((entry) {
            final index = entry.key;
            final avatar = entry.value;
            return Positioned(
              left: index * _getSize() * (1 - overlap),
              child: avatar,
            );
          }),
          if (remainingCount > 0)
            Positioned(
              left: displayAvatars.length * _getSize() * (1 - overlap),
              child: moreBuilder ?? _buildMoreAvatar(remainingCount, context),
            ),
        ],
      ),
    );
  }

  Widget _buildMoreAvatar(int count, BuildContext context) {
    return YoAvatar.text(
      text: '+$count',
      size: size,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      textColor: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  double _getSize() {
    switch (size) {
      case YoAvatarSize.xs:
        return 24;
      case YoAvatarSize.sm:
        return 32;
      case YoAvatarSize.md:
        return 40;
      case YoAvatarSize.lg:
        return 56;
      case YoAvatarSize.xl:
        return 72;
    }
  }
}
