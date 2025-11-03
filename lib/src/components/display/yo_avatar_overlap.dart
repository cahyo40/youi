// File: yo_avatar_overlap.dart
import 'package:flutter/material.dart';

import '../../../yo_ui.dart';

class YoAvatarOverlap extends StatelessWidget {
  final List<String> imageUrls;
  final double overlap;
  final YoAvatarSize size;
  final int maxDisplay;
  final Widget? moreBuilder;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final YoAvatarVariant variant;
  final double? borderRadius;
  final VoidCallback? onTapMore;

  const YoAvatarOverlap({
    super.key,
    required this.imageUrls,
    this.overlap = 0.7,
    this.size = YoAvatarSize.md,
    this.maxDisplay = 4,
    this.moreBuilder,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.variant = YoAvatarVariant.circle,
    this.borderRadius,
    this.onTapMore,
  });

  // Horizontal constructor
  const YoAvatarOverlap.horizontal({
    super.key,
    required this.imageUrls,
    this.overlap = 0.7,
    this.size = YoAvatarSize.md,
    this.maxDisplay = 4,
    this.moreBuilder,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.variant = YoAvatarVariant.circle,
    this.borderRadius,
    this.onTapMore,
  })  : direction = Axis.horizontal;

  // Vertical constructor
  const YoAvatarOverlap.vertical({
    super.key,
    required this.imageUrls,
    this.overlap = 0.7,
    this.size = YoAvatarSize.md,
    this.maxDisplay = 4,
    this.moreBuilder,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.variant = YoAvatarVariant.circle,
    this.borderRadius,
    this.onTapMore,
  })  : direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final displayUrls = imageUrls.take(maxDisplay).toList();
    final remainingCount = imageUrls.length - maxDisplay;
    final double avatarSize = _getAvatarSize();

    if (direction == Axis.vertical) {
      return _buildVerticalOverlap(
        context,
        displayUrls,
        remainingCount,
        avatarSize,
      );
    }

    return _buildHorizontalOverlap(
      context,
      displayUrls,
      remainingCount,
      avatarSize,
    );
  }

  Widget _buildHorizontalOverlap(
    BuildContext context,
    List<String> displayUrls,
    int remainingCount,
    double avatarSize,
  ) {
    return SizedBox(
      height: avatarSize,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          ...displayUrls.asMap().entries.map((entry) {
            final index = entry.key;
            final imageUrl = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                left: index > 0 ? -avatarSize * (1 - overlap) : 0,
              ),
              child: YoAvatar.image(
                imageUrl: imageUrl,
                size: size,
                variant: variant,
                borderRadius: borderRadius,
              ),
            );
          }),
          if (remainingCount > 0)
            Padding(
              padding: EdgeInsets.only(
                left: displayUrls.isNotEmpty 
                    ? -avatarSize * (1 - overlap) 
                    : 0,
              ),
              child: _buildMoreWidget(remainingCount, context),
            ),
        ],
      ),
    );
  }

  Widget _buildVerticalOverlap(
    BuildContext context,
    List<String> displayUrls,
    int remainingCount,
    double avatarSize,
  ) {
    return SizedBox(
      width: avatarSize,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...displayUrls.asMap().entries.map((entry) {
            final index = entry.key;
            final imageUrl = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                top: index > 0 ? -avatarSize * (1 - overlap) : 0,
              ),
              child: YoAvatar.image(
                imageUrl: imageUrl,
                size: size,
                variant: variant,
                borderRadius: borderRadius,
              ),
            );
          }),
          if (remainingCount > 0)
            Padding(
              padding: EdgeInsets.only(
                top: displayUrls.isNotEmpty 
                    ? -avatarSize * (1 - overlap) 
                    : 0,
              ),
              child: _buildMoreWidget(remainingCount, context),
            ),
        ],
      ),
    );
  }

  Widget _buildMoreWidget(int count, BuildContext context) {
    final widget = moreBuilder ?? _buildDefaultMoreAvatar(count, context);
    
    if (onTapMore != null) {
      return GestureDetector(
        onTap: onTapMore,
        child: widget,
      );
    }
    
    return widget;
  }

  Widget _buildDefaultMoreAvatar(int count, BuildContext context) {
    return YoAvatar.text(
      text: '+$count',
      size: size,
      backgroundColor: context.gray300,
      textColor: context.gray700,
      variant: variant,
      borderRadius: borderRadius,
    );
  }

  double _getAvatarSize() {
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

// Extension methods untuk mudah digunakan
extension AvatarOverlapExtensions on List<String> {
  YoAvatarOverlap toAvatarOverlap({
    Key? key,
    double overlap = 0.7,
    YoAvatarSize size = YoAvatarSize.md,
    int maxDisplay = 4,
    Widget? moreBuilder,
    Axis direction = Axis.horizontal,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    YoAvatarVariant variant = YoAvatarVariant.circle,
    double? borderRadius,
    VoidCallback? onTapMore,
  }) {
    return YoAvatarOverlap(
      key: key,
      imageUrls: this,
      overlap: overlap,
      size: size,
      maxDisplay: maxDisplay,
      moreBuilder: moreBuilder,
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      variant: variant,
      borderRadius: borderRadius,
      onTapMore: onTapMore,
    );
  }

  YoAvatarOverlap toHorizontalAvatarOverlap({
    Key? key,
    double overlap = 0.7,
    YoAvatarSize size = YoAvatarSize.md,
    int maxDisplay = 4,
    Widget? moreBuilder,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    YoAvatarVariant variant = YoAvatarVariant.circle,
    double? borderRadius,
    VoidCallback? onTapMore,
  }) {
    return YoAvatarOverlap.horizontal(
      key: key,
      imageUrls: this,
      overlap: overlap,
      size: size,
      maxDisplay: maxDisplay,
      moreBuilder: moreBuilder,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      variant: variant,
      borderRadius: borderRadius,
      onTapMore: onTapMore,
    );
  }

  YoAvatarOverlap toVerticalAvatarOverlap({
    Key? key,
    double overlap = 0.7,
    YoAvatarSize size = YoAvatarSize.md,
    int maxDisplay = 4,
    Widget? moreBuilder,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    YoAvatarVariant variant = YoAvatarVariant.circle,
    double? borderRadius,
    VoidCallback? onTapMore,
  }) {
    return YoAvatarOverlap.vertical(
      key: key,
      imageUrls: this,
      overlap: overlap,
      size: size,
      maxDisplay: maxDisplay,
      moreBuilder: moreBuilder,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      variant: variant,
      borderRadius: borderRadius,
      onTapMore: onTapMore,
    );
  }
}