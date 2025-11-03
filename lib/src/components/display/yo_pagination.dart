// File: yo_pagination.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int visiblePages;
  final bool showFirstLast;
  final bool showPreviousNext;

  const YoPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.visiblePages = 5,
    this.showFirstLast = true,
    this.showPreviousNext = true,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox();

    final List<Widget> pages = [];

    // First page button
    if (showFirstLast && currentPage > 1) {
      pages.add(_buildPageButton(context, 1, '1'));
      if (currentPage > 2) {
        pages.add(YoText.bodyMedium('...', color: context.gray400));
      }
    }

    // Visible pages
    final int start = _calculateStartPage();
    final int end = _calculateEndPage();

    for (int i = start; i <= end; i++) {
      pages.add(_buildPageButton(context, i, i.toString()));
    }

    // Last page button
    if (showFirstLast && currentPage < totalPages - 1) {
      if (currentPage < totalPages - 2) {
        pages.add(YoText.bodyMedium('...', color: context.gray400));
      }
      pages.add(_buildPageButton(context, totalPages, totalPages.toString()));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        if (showPreviousNext && currentPage > 1)
          _buildNavButton(
            context,
            Icons.chevron_left,
            'Previous',
            () => onPageChanged(currentPage - 1),
          ),

        // Pages
        Wrap(spacing: 8, children: pages),

        // Next button
        if (showPreviousNext && currentPage < totalPages)
          _buildNavButton(
            context,
            Icons.chevron_right,
            'Next',
            () => onPageChanged(currentPage + 1),
          ),
      ],
    );
  }

  int _calculateStartPage() {
    return (currentPage - (visiblePages ~/ 2)).clamp(1, totalPages);
  }

  int _calculateEndPage() {
    return (currentPage + (visiblePages ~/ 2)).clamp(1, totalPages);
  }

  Widget _buildPageButton(BuildContext context, int page, String label) {
    final bool isActive = page == currentPage;

    return InkWell(
      onTap: () => onPageChanged(page),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.yoSpacingMd,
          vertical: context.yoSpacingSm,
        ),
        decoration: BoxDecoration(
          color: isActive ? context.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? context.primaryColor : context.gray300,
          ),
        ),
        child: YoText.bodyMedium(
          label,
          color: isActive ? context.onPrimaryColor : context.textColor,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    IconData icon,
    String tooltip,
    VoidCallback onTap,
  ) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: context.primaryColor),
      tooltip: tooltip,
    );
  }
}
