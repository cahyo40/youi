import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

enum YoAvatarSize { xs, sm, md, lg, xl }

enum YoAvatarVariant { circle, rounded, square }

/// Avatar widget dengan berbagai konfigurasi
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
  final double? borderWidth;
  final Color? borderColor;

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
    this.borderWidth,
    this.borderColor,
  }) : assert(
         imageUrl != null || text != null || icon != null,
         'Either imageUrl, text, or icon must be provided',
       );

  /// Image avatar
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
    this.borderWidth,
    this.borderColor,
  }) : text = null,
       icon = null,
       backgroundColor = null,
       textColor = null,
       iconColor = null;

  /// Text/initials avatar
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
    this.borderWidth,
    this.borderColor,
  }) : imageUrl = null,
       icon = null,
       iconColor = null;

  /// Icon avatar
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
    this.borderWidth,
    this.borderColor,
  }) : imageUrl = null,
       text = null,
       textColor = null;

  /// Get pixel size from enum
  double get pixelSize => sizeMap[size]!;

  static const sizeMap = {
    YoAvatarSize.xs: 24.0,
    YoAvatarSize.sm: 32.0,
    YoAvatarSize.md: 40.0,
    YoAvatarSize.lg: 56.0,
    YoAvatarSize.xl: 72.0,
  };

  static const _textSizeMap = {
    YoAvatarSize.xs: 10.0,
    YoAvatarSize.sm: 12.0,
    YoAvatarSize.md: 14.0,
    YoAvatarSize.lg: 18.0,
    YoAvatarSize.xl: 24.0,
  };

  static const _iconSizeMap = {
    YoAvatarSize.xs: 12.0,
    YoAvatarSize.sm: 16.0,
    YoAvatarSize.md: 20.0,
    YoAvatarSize.lg: 28.0,
    YoAvatarSize.xl: 36.0,
  };

  static const _badgeSizeMap = {
    YoAvatarSize.xs: 8.0,
    YoAvatarSize.sm: 10.0,
    YoAvatarSize.md: 12.0,
    YoAvatarSize.lg: 14.0,
    YoAvatarSize.xl: 16.0,
  };

  @override
  Widget build(BuildContext context) {
    final avatarSize = sizeMap[size]!;
    final effectiveBorderRadius = _getBorderRadius(avatarSize);

    Widget avatarContent = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        color:
            backgroundColor ??
            Theme.of(context).colorScheme.surfaceContainerHighest,
        border: borderWidth != null
            ? Border.all(
                color: borderColor ?? context.backgroundColor,
                width: borderWidth!,
              )
            : null,
      ),
      child: _buildContent(context),
    );

    if (onTap != null) {
      avatarContent = GestureDetector(onTap: onTap, child: avatarContent);
    }

    if (showBadge || customBadge != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          avatarContent,
          Positioned(
            top: -2,
            right: -2,
            child: customBadge ?? _buildBadge(context),
          ),
        ],
      );
    }

    return avatarContent;
  }

  Widget _buildContent(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: _getBorderRadius(sizeMap[size]!),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => _buildFallback(context),
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return Center(
              child: SizedBox(
                width: _iconSizeMap[size],
                height: _iconSizeMap[size],
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      );
    }
    return _buildFallback(context);
  }

  Widget _buildFallback(BuildContext context) {
    if (text != null) {
      return Center(
        child: Text(
          _getInitials(text!),
          style: TextStyle(
            color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: _textSizeMap[size],
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Center(
      child: Icon(
        icon ?? Icons.person,
        size: _iconSizeMap[size],
        color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Container(
      width: _badgeSizeMap[size],
      height: _badgeSizeMap[size],
      decoration: BoxDecoration(
        color: badgeColor ?? context.primaryColor,
        shape: BoxShape.circle,
        border: Border.all(color: context.backgroundColor, width: 1.5),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0].length > 1
          ? parts[0].substring(0, 2).toUpperCase()
          : parts[0].toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  BorderRadius _getBorderRadius(double avatarSize) {
    switch (variant) {
      case YoAvatarVariant.circle:
        return BorderRadius.circular(avatarSize / 2);
      case YoAvatarVariant.rounded:
        return BorderRadius.circular(borderRadius ?? 8);
      case YoAvatarVariant.square:
        return BorderRadius.circular(borderRadius ?? 4);
    }
  }
}
