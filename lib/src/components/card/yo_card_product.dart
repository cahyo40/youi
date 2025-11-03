// [file name]: yo_product_card.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

import '../yo_badge.dart';

enum ProductCardVariant { default_, compact, detailed, wishlist }

class YoProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String? originalPrice;
  final String? imageUrl;
  final double rating;
  final int reviewCount;
  final bool isWishlisted;
  final bool isInStock;
  final List<String>? tags;
  final VoidCallback? onTap;
  final VoidCallback? onWishlist;
  final VoidCallback? onAddToCart;
  final ProductCardVariant variant;
  final String? category;
  final String? brand;

  const YoProductCard({
    super.key,
    required this.name,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isWishlisted = false,
    this.isInStock = true,
    this.tags,
    this.onTap,
    this.onWishlist,
    this.onAddToCart,
    this.variant = ProductCardVariant.default_,
    this.category,
    this.brand,
  });

  // Compact variant untuk grid view
  const YoProductCard.compact({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.rating = 0.0,
    this.isWishlisted = false,
    this.isInStock = true,
    this.onTap,
    this.onWishlist,
  }) : originalPrice = null,
       reviewCount = 0,
       tags = null,
       onAddToCart = null,
       variant = ProductCardVariant.compact,
       category = null,
       brand = null;

  // Detailed variant dengan semua info
  const YoProductCard.detailed({
    super.key,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.isInStock,
    this.tags,
    this.onTap,
    this.onWishlist,
    this.onAddToCart,
    this.category,
    this.brand,
  }) : isWishlisted = false,
       variant = ProductCardVariant.detailed;

  // Wishlist variant
  const YoProductCard.wishlist({
    super.key,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    this.onTap,
    required this.onWishlist,
    this.onAddToCart,
  }) : isWishlisted = true,
       isInStock = true,
       tags = null,
       variant = ProductCardVariant.wishlist,
       category = null,
       brand = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(_getBorderRadius(context)),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
          width: 1,
        ),
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
      case ProductCardVariant.default_:
        return _buildDefaultMobileContent(context);
      case ProductCardVariant.compact:
        return _buildCompactMobileContent(context);
      case ProductCardVariant.detailed:
        return _buildDetailedMobileContent(context);
      case ProductCardVariant.wishlist:
        return _buildWishlistMobileContent(context);
    }
  }

  Widget _buildTabletContent(BuildContext context) {
    switch (variant) {
      case ProductCardVariant.default_:
        return _buildDefaultTabletContent(context);
      case ProductCardVariant.compact:
        return _buildCompactTabletContent(context);
      case ProductCardVariant.detailed:
        return _buildDetailedTabletContent(context);
      case ProductCardVariant.wishlist:
        return _buildWishlistTabletContent(context);
    }
  }

  Widget _buildDesktopContent(BuildContext context) {
    switch (variant) {
      case ProductCardVariant.default_:
        return _buildDefaultDesktopContent(context);
      case ProductCardVariant.compact:
        return _buildCompactDesktopContent(context);
      case ProductCardVariant.detailed:
        return _buildDetailedDesktopContent(context);
      case ProductCardVariant.wishlist:
        return _buildWishlistDesktopContent(context);
    }
  }

  // ========== MOBILE LAYOUTS ==========

  Widget _buildDefaultMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image dengan wishlist button
        Stack(
          children: [
            _buildProductImage(context),
            Positioned(
              top: _getSpacing(context, base: 8),
              right: _getSpacing(context, base: 8),
              child: _buildWishlistButton(context),
            ),
            // Out of stock overlay
            if (!isInStock) _buildOutOfStockOverlay(context),
            // Tags
            if (tags != null && tags!.isNotEmpty) _buildTagsOverlay(context),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 8)),

        // Product info
        _buildProductInfo(context),

        SizedBox(height: _getSpacing(context, base: 8)),

        // Rating dan add to cart
        _buildProductFooter(context),
      ],
    );
  }

  Widget _buildCompactMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _buildProductImage(context),
            Positioned(
              top: _getSpacing(context, base: 4),
              right: _getSpacing(context, base: 4),
              child: _buildWishlistButton(context, compact: true),
            ),
            if (!isInStock) _buildOutOfStockOverlay(context),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 6)),

        _buildCompactProductInfo(context),
      ],
    );
  }

  Widget _buildDetailedMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _buildDetailedProductImage(context),
            Positioned(
              top: _getSpacing(context, base: 12),
              right: _getSpacing(context, base: 12),
              child: _buildWishlistButton(context),
            ),
            if (!isInStock) _buildOutOfStockOverlay(context),
            if (tags != null && tags!.isNotEmpty) _buildTagsOverlay(context),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 12)),

        _buildDetailedProductInfo(context),

        SizedBox(height: _getSpacing(context, base: 12)),

        _buildDetailedProductFooter(context),
      ],
    );
  }

  Widget _buildWishlistMobileContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(context, size: 80),

        SizedBox(width: _getSpacing(context, base: 12)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWishlistProductInfo(context),
              SizedBox(height: _getSpacing(context, base: 8)),
              _buildWishlistActions(context),
            ],
          ),
        ),
      ],
    );
  }

  // ========== TABLET LAYOUTS ==========

  Widget _buildDefaultTabletContent(BuildContext context) {
    return _buildDefaultMobileContent(context);
  }

  Widget _buildCompactTabletContent(BuildContext context) {
    return _buildCompactMobileContent(context);
  }

  Widget _buildDetailedTabletContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _buildDetailedProductImage(context, height: 200),
            Positioned(
              top: _getSpacing(context, base: 16),
              right: _getSpacing(context, base: 16),
              child: _buildWishlistButton(context),
            ),
            if (!isInStock) _buildOutOfStockOverlay(context),
            if (tags != null && tags!.isNotEmpty) _buildTagsOverlay(context),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 16)),

        _buildDetailedProductInfo(context),

        SizedBox(height: _getSpacing(context, base: 16)),

        _buildDetailedProductFooter(context),
      ],
    );
  }

  Widget _buildWishlistTabletContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(context, size: 100),

        SizedBox(width: _getSpacing(context, base: 16)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWishlistProductInfo(context),
              SizedBox(height: _getSpacing(context, base: 12)),
              _buildWishlistActions(context),
            ],
          ),
        ),
      ],
    );
  }

  // ========== DESKTOP LAYOUTS ==========

  Widget _buildDefaultDesktopContent(BuildContext context) {
    return _buildDefaultTabletContent(context);
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
            _buildDetailedProductImage(context, height: 240),
            Positioned(
              top: _getSpacing(context, base: 20),
              right: _getSpacing(context, base: 20),
              child: _buildWishlistButton(context),
            ),
            if (!isInStock) _buildOutOfStockOverlay(context),
            if (tags != null && tags!.isNotEmpty) _buildTagsOverlay(context),
          ],
        ),

        SizedBox(height: _getSpacing(context, base: 20)),

        _buildDetailedProductInfo(context),

        SizedBox(height: _getSpacing(context, base: 20)),

        _buildDetailedProductFooter(context),
      ],
    );
  }

  Widget _buildWishlistDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(context, size: 120),

        SizedBox(width: _getSpacing(context, base: 20)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWishlistProductInfo(context),
              SizedBox(height: _getSpacing(context, base: 16)),
              _buildWishlistActions(context),
            ],
          ),
        ),
      ],
    );
  }

  // ========== SHARED COMPONENTS ==========

  Widget _buildProductImage(BuildContext context, {double? size}) {
    final imageSize = size ?? _getImageHeight(context);

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

  Widget _buildDetailedProductImage(BuildContext context, {double? height}) {
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
        Icons.image_not_supported_rounded,
        size: _getIconSize(context, base: 32),
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildWishlistButton(BuildContext context, {bool compact = false}) {
    return GestureDetector(
      onTap: onWishlist,
      child: Container(
        padding: EdgeInsets.all(compact ? 6 : 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: compact ? 16 : 18,
          color: isWishlisted
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildOutOfStockOverlay(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.8),
        ),
        child: Center(
          child: Text(
            'Out of Stock',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagsOverlay(BuildContext context) {
    return Positioned(
      top: _getSpacing(context, base: 8),
      left: _getSpacing(context, base: 8),
      child: Wrap(
        spacing: _getSpacing(context, base: 4),
        children: tags!.take(2).map((tag) {
          return YoBadge(
            text: tag,
            variant: YoBadgeVariant.primary,
            size: YoBadgeSize.small,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand
        if (brand != null) ...[
          Text(
            brand!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: _getFontSize(context, base: 11),
            ),
          ),
          SizedBox(height: _getSpacing(context, base: 2)),
        ],

        // Product name
        Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: _getFontSize(context, base: 14),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: _getSpacing(context, base: 4)),

        // Price
        _buildPriceSection(context),
      ],
    );
  }

  Widget _buildCompactProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: _getFontSize(context, base: 13),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: _getSpacing(context, base: 2)),

        _buildPriceSection(context),

        if (rating > 0) ...[
          SizedBox(height: _getSpacing(context, base: 2)),
          _buildRatingSection(context, compact: true),
        ],
      ],
    );
  }

  Widget _buildDetailedProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category & Brand
        if (category != null || brand != null) ...[
          Row(
            children: [
              if (category != null) ...[
                Text(
                  category!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: _getFontSize(context, base: 12),
                  ),
                ),
                if (brand != null) ...[
                  SizedBox(width: _getSpacing(context, base: 4)),
                  Text(
                    '•',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(width: _getSpacing(context, base: 4)),
                ],
              ],
              if (brand != null)
                Text(
                  brand!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: _getFontSize(context, base: 12),
                  ),
                ),
            ],
          ),
          SizedBox(height: _getSpacing(context, base: 4)),
        ],

        // Product name
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: _getFontSize(context, base: 18),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: _getSpacing(context, base: 8)),

        // Rating
        if (rating > 0) _buildRatingSection(context),

        SizedBox(height: _getSpacing(context, base: 8)),

        // Price
        _buildPriceSection(context, large: true),

        SizedBox(height: _getSpacing(context, base: 8)),

        // Description (placeholder)
        _buildProductDescription(context),
      ],
    );
  }

  Widget _buildWishlistProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: _getFontSize(context, base: 14),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: _getSpacing(context, base: 4)),

        _buildPriceSection(context),

        if (rating > 0) ...[
          SizedBox(height: _getSpacing(context, base: 4)),
          _buildRatingSection(context),
        ],
      ],
    );
  }

  Widget _buildPriceSection(BuildContext context, {bool large = false}) {
    return Row(
      children: [
        Text(
          price,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: large
                ? _getFontSize(context, base: 20)
                : _getFontSize(context, base: 16),
          ),
        ),

        if (originalPrice != null) ...[
          SizedBox(width: _getSpacing(context, base: 4)),
          Text(
            originalPrice!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              decoration: TextDecoration.lineThrough,
              fontSize: large
                  ? _getFontSize(context, base: 14)
                  : _getFontSize(context, base: 12),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProductDescription(BuildContext context) {
    // Placeholder untuk product description
    return Text(
      'High-quality product with excellent features and durability. Perfect for everyday use.',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        fontSize: _getFontSize(context, base: 14),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductFooter(BuildContext context) {
    return Row(
      children: [
        // Rating
        if (rating > 0) _buildRatingSection(context),

        const Spacer(),

        // Add to cart button
        if (onAddToCart != null && isInStock) _buildAddToCartButton(context),
      ],
    );
  }

  Widget _buildDetailedProductFooter(BuildContext context) {
    return Row(
      children: [
        // Rating dengan review count
        if (rating > 0) _buildDetailedRatingSection(context),

        const Spacer(),

        // Action buttons
        if (onAddToCart != null && isInStock)
          _buildDetailedActionButtons(context),
      ],
    );
  }

  Widget _buildWishlistActions(BuildContext context) {
    return Row(
      children: [
        if (onAddToCart != null && isInStock) _buildAddToCartButton(context),

        const Spacer(),

        // Remove from wishlist
        _buildRemoveFromWishlistButton(context),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context, {bool compact = false}) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          size: compact ? 12 : _getIconSize(context, base: 14),
          color: const Color(0xFFF59E0B),
        ),
        SizedBox(width: _getSpacing(context, base: 2)),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: compact
                ? _getFontSize(context, base: 11)
                : _getFontSize(context, base: 12),
          ),
        ),
        if (reviewCount > 0 && !compact) ...[
          SizedBox(width: _getSpacing(context, base: 2)),
          Text(
            '($reviewCount)',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: _getFontSize(context, base: 11),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailedRatingSection(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          size: _getIconSize(context, base: 18),
          color: const Color(0xFFF59E0B),
        ),
        SizedBox(width: _getSpacing(context, base: 4)),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: _getFontSize(context, base: 16),
          ),
        ),
        SizedBox(width: _getSpacing(context, base: 4)),
        Text(
          '($reviewCount reviews)',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontSize: _getFontSize(context, base: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return GestureDetector(
      onTap: onAddToCart,
      child: Container(
        padding: EdgeInsets.all(_getSpacing(context, base: 6)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.5),
        ),
        child: Icon(
          Icons.add_shopping_cart_rounded,
          size: _getIconSize(context, base: 16),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildDetailedActionButtons(BuildContext context) {
    return Row(
      children: [
        // Wishlist button
        _buildWishlistButton(context),
        SizedBox(width: _getSpacing(context, base: 8)),

        // Add to cart button
        GestureDetector(
          onTap: onAddToCart,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _getSpacing(context, base: 16),
              vertical: _getSpacing(context, base: 8),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(
                _getBorderRadius(context) * 0.5,
              ),
            ),
            child: Text(
              'Add to Cart',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRemoveFromWishlistButton(BuildContext context) {
    return GestureDetector(
      onTap: onWishlist,
      child: Container(
        padding: EdgeInsets.all(_getSpacing(context, base: 6)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(_getBorderRadius(context) * 0.5),
        ),
        child: Icon(
          Icons.delete_rounded,
          size: _getIconSize(context, base: 16),
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
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

  double _getImageHeight(BuildContext context) {
    return context.responsiveValue(phone: 120.0, tablet: 140.0, desktop: 160.0);
  }

  double _getDetailedImageHeight(BuildContext context) {
    return context.responsiveValue(phone: 180.0, tablet: 200.0, desktop: 240.0);
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
