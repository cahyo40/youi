// [file name]: yo_skeleton.dart
import 'package:flutter/material.dart';

import '../../../yo_ui_base.dart';

class YoSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final YoSkeletonType type;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const YoSkeleton({
    super.key,
    this.width,
    this.height = 20,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.type = YoSkeletonType.shimmer,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  const YoSkeleton.circle({
    super.key,
    required double size,
    this.type = YoSkeletonType.shimmer,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  }) : width = size,
       height = size,
       borderRadius = const BorderRadius.all(Radius.circular(100));

  const YoSkeleton.line({
    super.key,
    this.width,
    this.height = 16,
    this.type = YoSkeletonType.shimmer,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  }) : borderRadius = const BorderRadius.all(Radius.circular(4));

  const YoSkeleton.rounded({
    super.key,
    this.width,
    this.height = 20,
    this.type = YoSkeletonType.shimmer,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  }) : borderRadius = const BorderRadius.all(Radius.circular(8));

  const YoSkeleton.square({
    super.key,
    required double size,
    this.type = YoSkeletonType.shimmer,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  }) : width = size,
       height = size,
       borderRadius = const BorderRadius.all(Radius.circular(0));

  @override
  State<YoSkeleton> createState() => _YoSkeletonState();
}

class _YoSkeletonState extends State<YoSkeleton> {
  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return const SizedBox.shrink();
    }

    final effectiveBaseColor = widget.baseColor ?? YoColors.gray300(context);
    final effectiveHighlightColor =
        widget.highlightColor ?? YoColors.gray100(context);

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: effectiveBaseColor,
      ),
      child: widget.type == YoSkeletonType.shimmer
          ? _ShimmerEffect(
              baseColor: effectiveBaseColor,
              highlightColor: effectiveHighlightColor,
              borderRadius: widget.borderRadius,
            )
          : null,
    );
  }
}

class _ShimmerEffect extends StatefulWidget {
  final Color baseColor;
  final Color highlightColor;
  final BorderRadius borderRadius;

  const _ShimmerEffect({
    required this.baseColor,
    required this.highlightColor,
    required this.borderRadius,
  });

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: widget.borderRadius,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  widget.baseColor,
                  widget.highlightColor,
                  widget.baseColor,
                ],
                stops: const [0.0, 0.5, 1.0],
                transform: _SlidingGradientTransform(_controller.value),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Container(color: widget.baseColor),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double percent;

  const _SlidingGradientTransform(this.percent);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * 2 * percent - bounds.width,
      0.0,
      0.0,
    );
  }
}

enum YoSkeletonType { static, shimmer }
