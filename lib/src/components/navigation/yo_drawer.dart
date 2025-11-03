// File: yo_drawer.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoDrawer extends StatelessWidget {
  final Widget? header;
  final List<YoDrawerItem> items;
  final Widget? footer;
  final double width;
  final Color? backgroundColor;
  final double elevation;

  const YoDrawer({
    super.key,
    this.header,
    required this.items,
    this.footer,
    this.width = 280,
    this.backgroundColor,
    this.elevation = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: width,
      elevation: elevation,
      backgroundColor: backgroundColor ?? context.backgroundColor,
      child: Column(
        children: [
          // Header
          if (header != null) header!,

          // Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [...items.map((item) => item.build(context))],
            ),
          ),

          // Footer
          if (footer != null) footer!,
        ],
      ),
    );
  }
}

class YoDrawerItem {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? selectedColor;
  final Color? iconColor;
  final Color? textColor;

  const YoDrawerItem({
    this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isSelected = false,
    this.selectedColor,
    this.iconColor,
    this.textColor,
  });

  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color:
                  iconColor ??
                  (isSelected
                      ? selectedColor ?? context.primaryColor
                      : context.gray600),
            )
          : null,
      title: Text(
        title,
        style: context.yoBodyMedium.copyWith(
          color:
              textColor ??
              (isSelected
                  ? selectedColor ?? context.primaryColor
                  : context.textColor),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.yoBodySmall.copyWith(color: context.gray500),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
      selected: isSelected,
      selectedColor: selectedColor ?? context.primaryColor,
      selectedTileColor: (selectedColor ?? context.primaryColor).withOpacity(
        0.1,
      ),
    );
  }
}

// Prebuilt drawer header
class YoDrawerHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? imageUrl;
  final Widget? userWidget;
  final VoidCallback? onTap;

  const YoDrawerHeader({
    super.key,
    this.title,
    this.subtitle,
    this.imageUrl,
    this.userWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: title != null
          ? Text(
              title!,
              style: context.yoTitleMedium.copyWith(
                color: context.onPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      accountEmail: subtitle != null
          ? Text(
              subtitle!,
              style: context.yoBodySmall.copyWith(
                color: context.onPrimaryColor.withOpacity(0.8),
              ),
            )
          : null,
      currentAccountPicture:
          userWidget ??
          (imageUrl != null
              ? YoAvatar.image(imageUrl: imageUrl!, size: YoAvatarSize.lg)
              : const YoAvatar.icon(icon: Icons.person)),
      decoration: BoxDecoration(
        color: context.primaryColor,
        gradient: context.primaryGradient,
      ),
      onDetailsPressed: onTap,
    );
  }
}
