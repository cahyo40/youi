// [file name]: yo_booking_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../yo_ui_base.dart';
import '../../display/yo_avatar.dart';

enum BookingStatus { pending, confirmed, cancelled, completed, inProgress }

enum BookingCardVariant { default_, compact, detailed }

class YoBookingCard extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final BookingStatus status;
  final String? imageUrl;
  final String? location;
  final String? guestName;
  final String? guestAvatarUrl;
  final int guestCount;
  final String price;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onModify;
  final BookingCardVariant variant;
  final String? bookingId;

  const YoBookingCard({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.price,
    this.imageUrl,
    this.location,
    this.guestName,
    this.guestAvatarUrl,
    this.guestCount = 1,
    this.onTap,
    this.onCancel,
    this.onModify,
    this.variant = BookingCardVariant.default_,
    this.bookingId,
  });

  // Compact variant untuk list view
  const YoBookingCard.compact({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.price,
    this.onTap,
    this.bookingId,
  }) : imageUrl = null,
       location = null,
       guestName = null,
       guestAvatarUrl = null,
       guestCount = 1,
       onCancel = null,
       onModify = null,
       variant = BookingCardVariant.compact;

  // Detailed variant dengan semua info
  const YoBookingCard.detailed({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.imageUrl,
    required this.location,
    required this.guestName,
    required this.guestAvatarUrl,
    required this.guestCount,
    required this.price,
    this.onTap,
    this.onCancel,
    this.onModify,
    this.bookingId,
  }) : variant = BookingCardVariant.detailed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getCardColor(context),
        borderRadius: BorderRadius.circular(_getBorderRadius(context)),
        border: Border.all(color: _getBorderColor(context), width: 1),
        boxShadow: _getBoxShadow(context),
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
    switch (variant) {
      case BookingCardVariant.default_:
        return _buildDefaultMobileContent(context);
      case BookingCardVariant.compact:
        return _buildCompactMobileContent(context);
      case BookingCardVariant.detailed:
        return _buildDetailedMobileContent(context);
    }
  }

  Widget _buildTabletContent(BuildContext context) {
    switch (variant) {
      case BookingCardVariant.default_:
        return _buildDefaultTabletContent(context);
      case BookingCardVariant.compact:
        return _buildCompactTabletContent(context);
      case BookingCardVariant.detailed:
        return _buildDetailedTabletContent(context);
    }
  }

  Widget _buildDesktopContent(BuildContext context) {
    switch (variant) {
      case BookingCardVariant.default_:
        return _buildDefaultDesktopContent(context);
      case BookingCardVariant.compact:
        return _buildCompactDesktopContent(context);
      case BookingCardVariant.detailed:
        return _buildDetailedDesktopContent(context);
    }
  }

  // ========== MOBILE LAYOUTS ==========

  Widget _buildDefaultMobileContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section
        if (imageUrl != null) ...[
          _buildImageSection(context),
          SizedBox(width: _getSpacing(context, base: 12)),
        ],

        // Content section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan status
              _buildHeader(context),
              SizedBox(height: _getSpacing(context, base: 8)),

              // Date range
              _buildDateSection(context),
              SizedBox(height: _getSpacing(context, base: 4)),

              // Location dan guest info
              _buildInfoSection(context),
              SizedBox(height: _getSpacing(context, base: 8)),

              // Footer dengan price dan actions
              _buildFooter(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactMobileContent(BuildContext context) {
    return Row(
      children: [
        // Status indicator
        _buildStatusIndicator(context),
        SizedBox(width: _getSpacing(context, base: 12)),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _getFontSize(context, base: 14),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: _getSpacing(context, base: 2)),
              Text(
                '${_formatDate(startDate)} - ${_formatDate(endDate)}',
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

        // Price
        Text(
          price,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: _getFontSize(context, base: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        Stack(
          children: [
            _buildDetailedImageSection(context),
            Positioned(
              top: _getSpacing(context, base: 12),
              right: _getSpacing(context, base: 12),
              child: _buildStatusBadge(context),
            ),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 12)),

        // Content
        _buildDetailedContent(context),

        SizedBox(height: _getSpacing(context, base: 12)),

        // Actions
        _buildDetailedActions(context),
      ],
    );
  }

  // ========== TABLET LAYOUTS ==========

  Widget _buildDefaultTabletContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageSection(context, size: 80),
        SizedBox(width: _getSpacing(context, base: 16)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: _getSpacing(context, base: 12)),
              _buildDateSection(context),
              SizedBox(height: _getSpacing(context, base: 8)),
              _buildInfoSection(context),
              SizedBox(height: _getSpacing(context, base: 12)),
              _buildFooter(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactTabletContent(BuildContext context) {
    return Row(
      children: [
        _buildStatusIndicator(context),
        SizedBox(width: _getSpacing(context, base: 16)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _getFontSize(context, base: 16),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: _getSpacing(context, base: 4)),
              Text(
                '${_formatDate(startDate)} - ${_formatDate(endDate)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: _getFontSize(context, base: 14),
                ),
              ),
            ],
          ),
        ),

        Text(
          price,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: _getFontSize(context, base: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedTabletContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _buildDetailedImageSection(context, height: 200),
            Positioned(
              top: _getSpacing(context, base: 16),
              right: _getSpacing(context, base: 16),
              child: _buildStatusBadge(context),
            ),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 16)),

        _buildDetailedContent(context),

        SizedBox(height: _getSpacing(context, base: 16)),

        _buildDetailedActions(context),
      ],
    );
  }

  // ========== DESKTOP LAYOUTS ==========

  Widget _buildDefaultDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageSection(context, size: 100),
        SizedBox(width: _getSpacing(context, base: 20)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: _getSpacing(context, base: 16)),
              _buildDateSection(context),
              SizedBox(height: _getSpacing(context, base: 12)),
              _buildInfoSection(context),
              SizedBox(height: _getSpacing(context, base: 16)),
              _buildFooter(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactDesktopContent(BuildContext context) {
    return _buildCompactTabletContent(context);
  }

  Widget _buildDetailedDesktopContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _buildDetailedImageSection(context, height: 240),
            Positioned(
              top: _getSpacing(context, base: 20),
              right: _getSpacing(context, base: 20),
              child: _buildStatusBadge(context),
            ),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 20)),

        _buildDetailedContent(context),

        SizedBox(height: _getSpacing(context, base: 20)),

        _buildDetailedActions(context),
      ],
    );
  }

  // ========== SHARED COMPONENTS ==========

  Widget _buildImageSection(BuildContext context, {double? size}) {
    final imageSize = size ?? _getImageSize(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.8),
      child: Container(
        width: imageSize,
        height: imageSize,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildImagePlaceholder(context);
                },
              )
            : _buildImagePlaceholder(context),
      ),
    );
  }

  Widget _buildDetailedImageSection(BuildContext context, {double? height}) {
    final imageHeight = height ?? _getDetailedImageHeight(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.8),
      child: Container(
        width: double.infinity,
        height: imageHeight,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildImagePlaceholder(context);
                },
              )
            : _buildImagePlaceholder(context),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Center(
      child: Icon(
        Icons.calendar_today_rounded,
        size: _getIconSize(context, base: 24),
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: _getFontSize(context, base: 16),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Status badge
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final (String text, Color color) = _getStatusInfo();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getSpacing(context, base: 8),
        vertical: _getSpacing(context, base: 4),
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.5),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: _getFontSize(context, base: 10),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    final (_, Color color) = _getStatusInfo();

    return Container(
      width: _getSpacing(context, base: 8),
      height: _getSpacing(context, base: 8),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildDateSection(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: _getIconSize(context, base: 14),
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        SizedBox(width: _getSpacing(context, base: 4)),
        Text(
          '${_formatDate(startDate)} - ${_formatDate(endDate)}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: _getFontSize(context, base: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (location != null) _buildLocationInfo(context),
        if (guestName != null) _buildGuestInfo(context),
      ],
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          size: _getIconSize(context, base: 12),
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        SizedBox(width: _getSpacing(context, base: 4)),
        Expanded(
          child: Text(
            location!,
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

  Widget _buildGuestInfo(BuildContext context) {
    return Row(
      children: [
        if (guestAvatarUrl != null) ...[
          YoAvatar.image(
            imageUrl: guestAvatarUrl,
            size: YoAvatarSize.xs,
            variant: YoAvatarVariant.circle,
          ),
          SizedBox(width: _getSpacing(context, base: 4)),
        ],
        Expanded(
          child: Text(
            guestName!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: _getFontSize(context, base: 12),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (guestCount > 1) ...[
          SizedBox(width: _getSpacing(context, base: 4)),
          Text(
            '+${guestCount - 1}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              fontSize: _getFontSize(context, base: 11),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        // Price
        Text(
          price,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: _getFontSize(context, base: 16),
          ),
        ),

        const Spacer(),

        // Actions
        if (onCancel != null || onModify != null) _buildActionButtons(context),
      ],
    );
  }

  Widget _buildDetailedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: _getFontSize(context, base: 20),
          ),
        ),

        SizedBox(height: _getSpacing(context, base: 12)),

        _buildDetailedDateSection(context),

        SizedBox(height: _getSpacing(context, base: 12)),

        if (location != null) _buildDetailedLocationInfo(context),

        if (guestName != null) ...[
          SizedBox(height: _getSpacing(context, base: 12)),
          _buildDetailedGuestInfo(context),
        ],

        SizedBox(height: _getSpacing(context, base: 12)),

        _buildDetailedPriceSection(context),
      ],
    );
  }

  Widget _buildDetailedDateSection(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: _getIconSize(context, base: 18),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: _getSpacing(context, base: 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Check-in',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                _formatDate(startDate),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Check-out',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                _formatDate(endDate),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedLocationInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          size: _getIconSize(context, base: 18),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: _getSpacing(context, base: 8)),
        Expanded(
          child: Text(
            location!,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedGuestInfo(BuildContext context) {
    return Row(
      children: [
        if (guestAvatarUrl != null)
          YoAvatar.image(
            imageUrl: guestAvatarUrl,
            size: YoAvatarSize.sm,
            variant: YoAvatarVariant.circle,
          ),
        SizedBox(width: _getSpacing(context, base: 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guest',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                guestName!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (guestCount > 1)
                Text(
                  '+ ${guestCount - 1} guest${guestCount > 2 ? 's' : ''}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedPriceSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: _getFontSize(context, base: 24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedActions(BuildContext context) {
    return Row(
      children: [
        if (onModify != null)
          _buildDetailedActionButton(
            context,
            'Modify Booking',
            Icons.edit_rounded,
            onModify!,
          ),

        if (onCancel != null && status != BookingStatus.cancelled) ...[
          SizedBox(width: _getSpacing(context, base: 12)),
          _buildDetailedActionButton(
            context,
            'Cancel Booking',
            Icons.cancel_rounded,
            onCancel!,
            isDestructive: true,
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        if (onModify != null) ...[
          _buildActionButton(context, 'Modify', Icons.edit_rounded, onModify!),
          SizedBox(width: _getSpacing(context, base: 8)),
        ],

        if (onCancel != null && status != BookingStatus.cancelled)
          _buildActionButton(
            context,
            'Cancel',
            Icons.cancel_rounded,
            onCancel!,
            isDestructive: true,
          ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed, {
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _getSpacing(context, base: 8),
          vertical: _getSpacing(context, base: 4),
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: _getIconSize(context, base: 12), color: color),
            SizedBox(width: _getSpacing(context, base: 4)),
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: _getFontSize(context, base: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed, {
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(_getSpacing(context, base: 12)),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              _getBorderRadius(context) * 0.8,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: _getIconSize(context, base: 16), color: color),
              SizedBox(width: _getSpacing(context, base: 8)),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== HELPER METHODS ==========

  (String, Color) _getStatusInfo() {
    switch (status) {
      case BookingStatus.pending:
        return ('Pending', const Color(0xFFF59E0B));
      case BookingStatus.confirmed:
        return ('Confirmed', const Color(0xFF10B981));
      case BookingStatus.cancelled:
        return ('Cancelled', const Color(0xFFEF4444));
      case BookingStatus.completed:
        return ('Completed', const Color(0xFF6B7280));
      case BookingStatus.inProgress:
        return ('In Progress', const Color(0xFF3B82F6));
    }
  }

  Color _getCardColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  Color _getBorderColor(BuildContext context) {
    final (_, Color color) = _getStatusInfo();
    return color.withOpacity(0.2);
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
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

  double _getImageSize(BuildContext context) {
    return context.responsiveValue(phone: 60.0, tablet: 80.0, desktop: 100.0);
  }

  double _getDetailedImageHeight(BuildContext context) {
    return context.responsiveValue(phone: 160.0, tablet: 200.0, desktop: 240.0);
  }

  EdgeInsets _getPadding(BuildContext context) {
    final padding = context.responsiveValue(
      phone: 12.0,
      tablet: 16.0,
      desktop: 20.0,
    );

    return EdgeInsets.all(padding);
  }

  List<BoxShadow>? _getBoxShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }
}
