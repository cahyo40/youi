// File: yo_bottom_bar.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<YoBottomBarItem> items;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double elevation;
  final bool showLabel;
  final double iconSize;
  final double itemPadding;

  const YoBottomBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.elevation = 8.0,
    this.showLabel = true,
    this.iconSize = 24.0,
    this.itemPadding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.gray300.withOpacity(0.3),
            blurRadius: elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: backgroundColor ?? context.backgroundColor,
        selectedItemColor: selectedColor ?? context.primaryColor,
        unselectedItemColor: unselectedColor ?? context.gray500,
        showSelectedLabels: showLabel,
        showUnselectedLabels: showLabel,
        iconSize: iconSize,
        type: BottomNavigationBarType.fixed,
        items: items
            .map((item) => item.toBottomNavigationBarItem(context))
            .toList(),
      ),
    );
  }
}

class YoBottomBarItem {
  final IconData icon;
  final String label;
  final Widget? activeIcon;
  final String? badge;
  final Color? badgeColor;

  const YoBottomBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badge,
    this.badgeColor,
  });

  BottomNavigationBarItem toBottomNavigationBarItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: _buildIcon(context, false),
      activeIcon: _buildIcon(context, true),
      label: label,
    );
  }

  Widget _buildIcon(BuildContext context, bool isActive) {
    Widget iconWidget = activeIcon != null && isActive
        ? activeIcon!
        : Icon(icon);

    if (badge != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          iconWidget,
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: badgeColor ?? context.errorColor,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                badge!,
                style: TextStyle(
                  color: context.onPrimaryColor,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return iconWidget;
  }
}
