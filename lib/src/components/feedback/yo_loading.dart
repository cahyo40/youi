import 'package:flutter/material.dart';

import '../../../yo_ui_base.dart';

class YoLoading extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;
  final YoLoadingType type;

  const YoLoading({
    super.key,
    this.size = 24,
    this.color,
    this.strokeWidth = 2.0,
    this.type = YoLoadingType.spinner,
  });

  const YoLoading.spinner({
    super.key,
    this.size = 24,
    this.color,
    this.strokeWidth = 2.0,
  }) : type = YoLoadingType.spinner;

  const YoLoading.dots({super.key, this.size = 24, this.color})
    : type = YoLoadingType.dots,
      strokeWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? YoColors.primary(context);

    switch (type) {
      case YoLoadingType.spinner:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
            strokeWidth: strokeWidth,
          ),
        );
      case YoLoadingType.dots:
        return _DotsLoading(size: size, color: loadingColor);
    }
  }
}

class _DotsLoading extends StatefulWidget {
  final double size;
  final Color color;

  const _DotsLoading({required this.size, required this.color});

  @override
  State<_DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<_DotsLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
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
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final animation = _controller.drive(
                  CurveTween(curve: Interval(index * 0.2, 0.6 + index * 0.2)),
                );
                return ScaleTransition(
                  scale: animation,
                  child: Container(
                    width: widget.size / 4,
                    height: widget.size / 4,
                    margin: EdgeInsets.symmetric(horizontal: widget.size / 16),
                    decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

enum YoLoadingType { spinner, dots }
