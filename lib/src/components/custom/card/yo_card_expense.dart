// [file name]: yo_expense_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yo_ui/yo_ui.dart';

enum ExpenseType { expense, income }

enum ExpenseCardVariant { default_, compact, detailed, summary }

class ExpenseCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const ExpenseCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  // Default categories untuk contoh
  static const List<ExpenseCategory> defaultCategories = [
    ExpenseCategory(
      id: 'food',
      name: 'Food',
      icon: Icons.restaurant_rounded,
      color: Color(0xFFEF4444),
    ),
    ExpenseCategory(
      id: 'transportation',
      name: 'Transport',
      icon: Icons.directions_car_rounded,
      color: Color(0xFF3B82F6),
    ),
    ExpenseCategory(
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFF8B5CF6),
    ),
    ExpenseCategory(
      id: 'entertainment',
      name: 'Entertainment',
      icon: Icons.movie_rounded,
      color: Color(0xFFEC4899),
    ),
    ExpenseCategory(
      id: 'bills',
      name: 'Bills',
      icon: Icons.receipt_long_rounded,
      color: Color(0xFF06B6D4),
    ),
    ExpenseCategory(
      id: 'healthcare',
      name: 'Healthcare',
      icon: Icons.medical_services_rounded,
      color: Color(0xFF10B981),
    ),
    ExpenseCategory(
      id: 'education',
      name: 'Education',
      icon: Icons.school_rounded,
      color: Color(0xFFF59E0B),
    ),
    ExpenseCategory(
      id: 'salary',
      name: 'Salary',
      icon: Icons.work_rounded,
      color: Color(0xFF84CC16),
    ),
    ExpenseCategory(
      id: 'other',
      name: 'Other',
      icon: Icons.category_rounded,
      color: Color(0xFF6B7280),
    ),
  ];
}

class YoExpenseCard extends StatelessWidget {
  final String title;
  final String amount;
  final ExpenseType type;
  final ExpenseCategory category;
  final DateTime date;
  final String? description;
  final String? location;
  final bool isRecurring;
  final bool isVerified;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final ExpenseCardVariant variant;
  final Color? accentColor;
  final double? maxWidth;

  const YoExpenseCard({
    super.key,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.description,
    this.location,
    this.isRecurring = false,
    this.isVerified = false,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.variant = ExpenseCardVariant.default_,
    this.accentColor,
    this.maxWidth,
  });

  // Compact variant untuk list view
  const YoExpenseCard.compact({
    super.key,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.maxWidth,
  }) : description = null,
       location = null,
       isRecurring = false,
       isVerified = false,
       variant = ExpenseCardVariant.compact,
       accentColor = null;

  // Detailed variant dengan semua informasi
  const YoExpenseCard.detailed({
    super.key,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    required this.description,
    this.location,
    this.isRecurring = false,
    this.isVerified = false,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.maxWidth,
  }) : variant = ExpenseCardVariant.detailed,
       accentColor = null;

  // Summary variant untuk dashboard
  YoExpenseCard.summary({
    super.key,
    required this.title,
    required this.amount,
    required this.type,
    this.onTap,
    this.accentColor,
    this.maxWidth,
  }) : category = const ExpenseCategory(
         id: 'summary',
         name: 'Summary',
         icon: Icons.attach_money_rounded,
         color: Colors.blue,
       ),
       date = DateTime.now(),
       description = null,
       location = null,
       isRecurring = false,
       isVerified = false,
       onLongPress = null,
       isSelected = false,
       variant = ExpenseCardVariant.summary;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: _getVerticalMargin(context),
          horizontal: _getHorizontalMargin(context),
        ),
        decoration: BoxDecoration(
          color: _getCardColor(context),
          borderRadius: BorderRadius.circular(_getBorderRadius(context)),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  width: 2,
                )
              : Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                  width: 1,
                ),
          boxShadow: _getBoxShadow(context),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
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
    // Gunakan YoResponsive untuk menentukan layout
    return YoResponsive.responsiveWidget(
      context: context,
      mobile: _buildMobileContent(context),
      tablet: _buildTabletContent(context),
      desktop: _buildDesktopContent(context),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    final bool isVerySmallScreen = context.yoWidth < 350;

    // Untuk screen sangat kecil, gunakan compact layout meskipun variant default
    if (isVerySmallScreen && variant == ExpenseCardVariant.default_) {
      return _buildCompactContent(context);
    }

    switch (variant) {
      case ExpenseCardVariant.default_:
        return _buildDefaultMobileContent(context);
      case ExpenseCardVariant.compact:
        return _buildCompactContent(context);
      case ExpenseCardVariant.detailed:
        return _buildDetailedMobileContent(context);
      case ExpenseCardVariant.summary:
        return _buildSummaryMobileContent(context);
    }
  }

  Widget _buildTabletContent(BuildContext context) {
    switch (variant) {
      case ExpenseCardVariant.default_:
        return _buildDefaultTabletContent(context);
      case ExpenseCardVariant.compact:
        return _buildCompactTabletContent(context);
      case ExpenseCardVariant.detailed:
        return _buildDetailedTabletContent(context);
      case ExpenseCardVariant.summary:
        return _buildSummaryTabletContent(context);
    }
  }

  Widget _buildDesktopContent(BuildContext context) {
    switch (variant) {
      case ExpenseCardVariant.default_:
        return _buildDefaultDesktopContent(context);
      case ExpenseCardVariant.compact:
        return _buildCompactDesktopContent(context);
      case ExpenseCardVariant.detailed:
        return _buildDetailedDesktopContent(context);
      case ExpenseCardVariant.summary:
        return _buildSummaryDesktopContent(context);
    }
  }

  // ========== MOBILE LAYOUTS ==========

  Widget _buildDefaultMobileContent(BuildContext context) {
    final bool isVerySmallScreen = context.yoWidth < 350;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Icon
        _buildCategoryIcon(context),
        SizedBox(width: _getSpacing(context, base: 12)),

        // Main Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleRow(context),
              SizedBox(height: _getSpacing(context, base: 4)),
              _buildMetaInfo(context),
            ],
          ),
        ),

        // Amount Section
        _buildAmountSection(context),

        // Verification Badge - hidden di screen sangat kecil
        if (isVerified && !isVerySmallScreen) ...[
          SizedBox(width: _getSpacing(context, base: 8)),
          _buildVerificationBadge(context),
        ],
      ],
    );
  }

  Widget _buildCompactContent(BuildContext context) {
    return Row(
      children: [
        // Category Icon
        Container(
          width: _getIconSize(context, base: 32),
          height: _getIconSize(context, base: 32),
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              _getBorderRadius(context) * 0.8,
            ),
          ),
          child: Icon(
            category.icon,
            size: _getIconSize(context, base: 16) * 0.5,
            color: category.color,
          ),
        ),
        SizedBox(width: _getSpacing(context, base: 12)),

        // Title and Date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: _getFontSize(context, base: 14),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: _getSpacing(context, base: 2)),
              Text(
                _formatDate(date, context),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: _getFontSize(context, base: 12),
                ),
              ),
            ],
          ),
        ),

        // Amount
        _buildAmountSection(context, compact: true),
      ],
    );
  }

  Widget _buildDetailedMobileContent(BuildContext context) {
    final bool isVerySmallScreen = context.yoWidth < 350;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row - stack vertikal di screen sangat kecil
        if (isVerySmallScreen) ..._buildDetailedContentSmallMobile(context),
        if (!isVerySmallScreen) ..._buildDetailedContentLargeMobile(context),

        // Description
        if (description != null && description!.isNotEmpty) ...[
          SizedBox(height: _getSpacing(context, base: 8)),
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

        // Location and Recurring Badge
        if (location != null || isRecurring) ...[
          SizedBox(height: _getSpacing(context, base: 8)),
          _buildAdditionalInfo(context),
        ],
      ],
    );
  }

  List<Widget> _buildDetailedContentSmallMobile(BuildContext context) {
    return [
      Row(
        children: [
          _buildCategoryIcon(context),
          SizedBox(width: _getSpacing(context, base: 12)),
          Expanded(child: _buildTitleRow(context)),
        ],
      ),
      SizedBox(height: _getSpacing(context, base: 8)),
      Row(
        children: [
          Expanded(child: _buildMetaInfo(context)),
          _buildAmountSection(context),
          if (isVerified) ...[
            SizedBox(width: _getSpacing(context, base: 8)),
            _buildVerificationBadge(context),
          ],
        ],
      ),
    ];
  }

  List<Widget> _buildDetailedContentLargeMobile(BuildContext context) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryIcon(context),
          SizedBox(width: _getSpacing(context, base: 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(context),
                SizedBox(height: _getSpacing(context, base: 2)),
                _buildMetaInfo(context),
              ],
            ),
          ),
          _buildAmountSection(context),
          if (isVerified) ...[
            SizedBox(width: _getSpacing(context, base: 8)),
            _buildVerificationBadge(context),
          ],
        ],
      ),
    ];
  }

  Widget _buildSummaryMobileContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getSpacing(context, base: 16)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor ?? _getTypeColor(context),
            (accentColor ?? _getTypeColor(context)).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(_getBorderRadius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: _getFontSize(context, base: 16),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: _getSpacing(context, base: 8)),
          Text(
            amount,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: _getFontSize(context, base: 20),
            ),
          ),
          SizedBox(height: _getSpacing(context, base: 4)),
          _buildTypeBadge(context),
        ],
      ),
    );
  }

  // ========== TABLET LAYOUTS ==========

  Widget _buildDefaultTabletContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryIcon(context),
        SizedBox(width: _getSpacing(context, base: 16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleRow(context),
              SizedBox(height: _getSpacing(context, base: 6)),
              _buildMetaInfo(context),
              if (description != null && description!.isNotEmpty) ...[
                SizedBox(height: _getSpacing(context, base: 6)),
                Text(
                  description!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: _getSpacing(context, base: 16)),
        _buildAmountSection(context),
        if (isVerified) ...[
          SizedBox(width: _getSpacing(context, base: 12)),
          _buildVerificationBadge(context),
        ],
      ],
    );
  }

  Widget _buildCompactTabletContent(BuildContext context) {
    return Row(
      children: [
        Container(
          width: _getIconSize(context, base: 36),
          height: _getIconSize(context, base: 36),
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              _getBorderRadius(context) * 0.8,
            ),
          ),
          child: Icon(
            category.icon,
            size: _getIconSize(context, base: 18) * 0.5,
            color: category.color,
          ),
        ),
        SizedBox(width: _getSpacing(context, base: 16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: _getSpacing(context, base: 4)),
              _buildMetaInfo(context),
            ],
          ),
        ),
        _buildAmountSection(context),
      ],
    );
  }

  Widget _buildDetailedTabletContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryIcon(context),
            SizedBox(width: _getSpacing(context, base: 16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleRow(context),
                  SizedBox(height: _getSpacing(context, base: 4)),
                  _buildMetaInfo(context),
                ],
              ),
            ),
            _buildAmountSection(context),
            if (isVerified) ...[
              SizedBox(width: _getSpacing(context, base: 12)),
              _buildVerificationBadge(context),
            ],
          ],
        ),
        if (description != null && description!.isNotEmpty) ...[
          SizedBox(height: _getSpacing(context, base: 12)),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
        if (location != null || isRecurring) ...[
          SizedBox(height: _getSpacing(context, base: 12)),
          _buildAdditionalInfo(context),
        ],
      ],
    );
  }

  Widget _buildSummaryTabletContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getSpacing(context, base: 24)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor ?? _getTypeColor(context),
            (accentColor ?? _getTypeColor(context)).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(_getBorderRadius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: _getSpacing(context, base: 12)),
          Text(
            amount,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: _getSpacing(context, base: 8)),
          _buildTypeBadge(context),
        ],
      ),
    );
  }

  // ========== DESKTOP LAYOUTS ==========

  Widget _buildDefaultDesktopContent(BuildContext context) {
    return _buildDefaultTabletContent(
      context,
    ); // Reuse tablet layout untuk desktop
  }

  Widget _buildCompactDesktopContent(BuildContext context) {
    return _buildCompactTabletContent(
      context,
    ); // Reuse tablet layout untuk desktop
  }

  Widget _buildDetailedDesktopContent(BuildContext context) {
    return _buildDetailedTabletContent(
      context,
    ); // Reuse tablet layout untuk desktop
  }

  Widget _buildSummaryDesktopContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getSpacing(context, base: 32)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor ?? _getTypeColor(context),
            (accentColor ?? _getTypeColor(context)).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(_getBorderRadius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: _getSpacing(context, base: 16)),
          Text(
            amount,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: _getSpacing(context, base: 12)),
          _buildTypeBadge(context),
        ],
      ),
    );
  }

  // ========== SHARED COMPONENTS ==========

  Widget _buildCategoryIcon(BuildContext context) {
    final iconSize = YoResponsive.responsiveValue(
      context,
      mobile: 40.0,
      tablet: 48.0,
      desktop: 56.0,
    );

    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: category.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.8),
      ),
      child: Icon(category.icon, size: iconSize * 0.5, color: category.color),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: _getFontSize(context, base: 16),
            ),
            maxLines: context.yoIsSmallScreen ? 1 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isRecurring &&
            variant != ExpenseCardVariant.compact &&
            !context.yoIsSmallScreen) ...[
          SizedBox(width: _getSpacing(context, base: 4)),
          Icon(
            Icons.repeat_rounded,
            size: _getIconSize(context, base: 16),
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ],
      ],
    );
  }

  Widget _buildMetaInfo(BuildContext context) {
    return Row(
      children: [
        Text(
          _formatDate(date, context),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontSize: _getFontSize(context, base: 12),
          ),
        ),
        SizedBox(width: _getSpacing(context, base: 8)),
        Container(
          width: _getSpacing(context, base: 4),
          height: _getSpacing(context, base: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: _getSpacing(context, base: 8)),
        Expanded(
          child: Text(
            category.name,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: _getFontSize(context, base: 12),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSection(BuildContext context, {bool compact = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: _getTypeColor(context),
            fontSize: compact
                ? _getFontSize(context, base: 14)
                : _getFontSize(context, base: 16),
          ),
        ),
        if (!compact && !context.yoIsSmallScreen) ...[
          SizedBox(height: _getSpacing(context, base: 2)),
          Text(
            type == ExpenseType.income ? 'Income' : 'Expense',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVerificationBadge(BuildContext context) {
    return Icon(
      Icons.verified_rounded,
      size: _getIconSize(context, base: 16),
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Wrap(
      spacing: _getSpacing(context, base: 8),
      runSpacing: _getSpacing(context, base: 4),
      children: [
        if (location != null) _buildLocationChip(context),
        if (isRecurring) _buildRecurringChip(context),
      ],
    );
  }

  Widget _buildLocationChip(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getSpacing(context, base: 8),
        vertical: _getSpacing(context, base: 4),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_rounded,
            size: _getIconSize(context, base: 12),
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: _getSpacing(context, base: 4)),
          Text(
            location!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringChip(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getSpacing(context, base: 8),
        vertical: _getSpacing(context, base: 4),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.repeat_rounded,
            size: _getIconSize(context, base: 12),
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: _getSpacing(context, base: 4)),
          Text(
            'Recurring',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getSpacing(context, base: 12),
        vertical: _getSpacing(context, base: 6),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.5),
      ),
      child: Text(
        type == ExpenseType.income ? 'Income' : 'Expense',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ========== RESPONSIVE HELPER METHODS ==========

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
    return context.responsiveValue(phone: 10.0, tablet: 12.0, desktop: 16.0);
  }

  EdgeInsets _getPadding(BuildContext context) {
    final basePadding = switch (variant) {
      ExpenseCardVariant.default_ => 16.0,
      ExpenseCardVariant.compact => 12.0,
      ExpenseCardVariant.detailed => 16.0,
      ExpenseCardVariant.summary => 0.0,
    };

    final padding = context.responsiveValue(
      phone: basePadding * 0.8,
      tablet: basePadding * 1.0,
      desktop: basePadding * 1.2,
    );

    return EdgeInsets.all(padding);
  }

  double _getVerticalMargin(BuildContext context) {
    return context.responsiveValue(phone: 2.0, tablet: 4.0, desktop: 6.0);
  }

  double _getHorizontalMargin(BuildContext context) {
    return 0.0; // No horizontal margin
  }

  // ========== OTHER HELPER METHODS ==========

  Color _getCardColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  Color _getTypeColor(BuildContext context) {
    return type == ExpenseType.income
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;
  }

  String _formatDate(DateTime date, BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateDay = DateTime(date.year, date.month, date.day);

    final useShortFormat = context.yoIsSmallScreen;

    if (dateDay == today) {
      return 'Today';
    } else if (dateDay == yesterday) {
      return 'Yesterday';
    } else {
      return useShortFormat
          ? DateFormat('MMM dd').format(date)
          : DateFormat('MMM dd, yyyy').format(date);
    }
  }

  List<BoxShadow>? _getBoxShadow(BuildContext context) {
    if (variant == ExpenseCardVariant.summary) return null;

    return [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }
}
