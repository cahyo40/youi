// File: yo_spacing.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoSpace extends StatelessWidget {
  final double width;
  final double height;

  const YoSpace({super.key, this.width = 0, this.height = 0});

  const YoSpace.width(this.width, {super.key}) : height = 0;

  const YoSpace.height(this.height, {super.key}) : width = 0;

  // Predefined spacing using context extensions
  const YoSpace.xs({super.key}) : width = 4, height = 4;
  const YoSpace.sm({super.key}) : width = 8, height = 8;
  const YoSpace.md({super.key}) : width = 16, height = 16;
  const YoSpace.lg({super.key}) : width = 24, height = 24;
  const YoSpace.xl({super.key}) : width = 32, height = 32;

  // Width-only spacers
  const YoSpace.widthXs({super.key}) : width = 4, height = 0;
  const YoSpace.widthSm({super.key}) : width = 8, height = 0;
  const YoSpace.widthMd({super.key}) : width = 16, height = 0;
  const YoSpace.widthLg({super.key}) : width = 24, height = 0;
  const YoSpace.widthXl({super.key}) : width = 32, height = 0;

  // Height-only spacers
  const YoSpace.heightXs({super.key}) : width = 0, height = 4;
  const YoSpace.heightSm({super.key}) : width = 0, height = 8;
  const YoSpace.heightMd({super.key}) : width = 0, height = 16;
  const YoSpace.heightLg({super.key}) : width = 0, height = 24;
  const YoSpace.heightXl({super.key}) : width = 0, height = 32;

  // Factory methods using context for dynamic spacing
  factory YoSpace.autoWidth(BuildContext context, {double multiplier = 1.0}) {
    final baseSpacing = context.yoSpacingMd;
    return YoSpace.width(baseSpacing * multiplier);
  }

  factory YoSpace.autoHeight(BuildContext context, {double multiplier = 1.0}) {
    final baseSpacing = context.yoSpacingMd;
    return YoSpace.height(baseSpacing * multiplier);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
