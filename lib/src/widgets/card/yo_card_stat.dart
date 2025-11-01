// [file name]: yo_stats_card.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

enum StatsCardVariant { default_, elevated, minimal, comparison }

enum StatsTrend { up, down, neutral }

class YoStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final StatsTrend trend;
  final double? trendPercentage;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;
  final VoidCallback? onTap;
  final StatsCardVariant variant;
  final bool showTrend;
  final String? comparisonText;

  const YoStatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.trend = StatsTrend.neutral,
    this.trendPercentage,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.onTap,
    this.variant = StatsCardVariant.default_,
    this.showTrend = true,
    this.comparisonText,
  });

  // Elevated variant dengan shadow
  const YoStatsCard.elevated({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.trend = StatsTrend.neutral,
    this.trendPercentage,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.onTap,
    this.showTrend = true,
    this.comparisonText,
  }) : variant = StatsCardVariant.elevated;

  // Minimal variant tanpa background
  const YoStatsCard.minimal({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.trend = StatsTrend.neutral,
    this.trendPercentage,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.onTap,
    this.showTrend = true,
    this.comparisonText,
  }) : variant = StatsCardVariant.minimal;

  // Comparison variant dengan perbandingan
  const YoStatsCard.comparison({
    super.key,
    required this.title,
    required this.value,
    required this.comparisonText,
    this.subtitle,
    this.trend = StatsTrend.neutral,
    this.trendPercentage,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.onTap,
    this.showTrend = true,
  }) : variant = StatsCardVariant.comparison;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getDecoration(context),
      child: Material(
        type: _getMaterialType(),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_getBorderRadius(context)),
          child: Padding(
            padding: _getPadding(context),
            child: _buildContent(context),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header dengan icon dan trend
        _buildHeader(context),
        SizedBox(height: _getSpacing(context, base: 8)),

        // Value
        _buildValue(context),
        SizedBox(height: _getSpacing(context, base: 4)),

        // Subtitle dan comparison
        _buildFooter(context),
      ],
    );
  }

  Widget _buildTabletContent(BuildContext context) {
    return Row(
      children: [
        // Icon section
        if (icon != null) ...[
          _buildIcon(context),
          SizedBox(width: _getSpacing(context, base: 16)),
        ],

        // Content section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: _getSpacing(context, base: 8)),
              _buildValue(context),
              SizedBox(height: _getSpacing(context, base: 4)),
              _buildFooter(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return _buildTabletContent(context);
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: _getFontSize(context, base: 12),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Trend indicator
        if (showTrend && trend != StatsTrend.neutral)
          _buildTrendIndicator(context),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getSpacing(context, base: 8)),
      decoration: BoxDecoration(
        color:
            iconColor?.withOpacity(0.1) ??
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.7),
      ),
      child: Icon(
        icon,
        size: _getIconSize(context, base: 20),
        color: iconColor ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildValue(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: valueColor ?? Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: _getFontSize(context, base: 24),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        // Subtitle
        if (subtitle != null) ...[
          Expanded(
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: _getFontSize(context, base: 11),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: _getSpacing(context, base: 8)),
        ],

        // Comparison text
        if (comparisonText != null)
          Text(
            comparisonText!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: _getFontSize(context, base: 11),
            ),
          ),
      ],
    );
  }

  Widget _buildTrendIndicator(BuildContext context) {
    final bool isPositive = trend == StatsTrend.up;
    final Color trendColor = isPositive
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
          size: _getIconSize(context, base: 14),
          color: trendColor,
        ),
        if (trendPercentage != null) ...[
          SizedBox(width: _getSpacing(context, base: 2)),
          Text(
            '${trendPercentage!.abs().toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: trendColor,
              fontWeight: FontWeight.w600,
              fontSize: _getFontSize(context, base: 11),
            ),
          ),
        ],
      ],
    );
  }

  // ========== STYLING METHODS ==========

  BoxDecoration? _getDecoration(BuildContext context) {
    switch (variant) {
      case StatsCardVariant.default_:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(_getBorderRadius(context)),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        );
      case StatsCardVariant.elevated:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(_getBorderRadius(context)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        );
      case StatsCardVariant.minimal:
        return null;
      case StatsCardVariant.comparison:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(_getBorderRadius(context)),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
        );
    }
  }

  MaterialType _getMaterialType() {
    return variant == StatsCardVariant.minimal
        ? MaterialType.transparency
        : MaterialType.canvas;
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
      phone: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );

    return EdgeInsets.all(padding);
  }
}
