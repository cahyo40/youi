// File: yo_timeline.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoTimelineEvent {
  final String title;
  final String? description;
  final DateTime date;
  final IconData? icon;
  final Color? color;
  final Widget? customDot;
  final List<Widget>? actions;

  const YoTimelineEvent({
    required this.title,
    this.description,
    required this.date,
    this.icon,
    this.color,
    this.customDot,
    this.actions,
  });
}

class YoTimeline extends StatelessWidget {
  final List<YoTimelineEvent> events;
  final TimelineDirection direction;
  final Color? lineColor;
  final double lineWidth;
  final double dotSize;
  final bool showConnectingLine;
  final EdgeInsetsGeometry itemPadding;

  const YoTimeline({
    super.key,
    required this.events,
    this.direction = TimelineDirection.vertical,
    this.lineColor,
    this.lineWidth = 2.0,
    this.dotSize = 24.0,
    this.showConnectingLine = true,
    this.itemPadding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == TimelineDirection.horizontal) {
      return _buildHorizontalTimeline(context);
    }
    return _buildVerticalTimeline(context);
  }

  Widget _buildVerticalTimeline(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: context.yoSpacingLg),
      itemBuilder: (context, index) {
        return _buildTimelineItem(context, events[index], index);
      },
    );
  }

  Widget _buildHorizontalTimeline(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.yoSpacingXl),
        itemBuilder: (context, index) {
          return _buildHorizontalTimelineItem(context, events[index], index);
        },
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    YoTimelineEvent event,
    int index,
  ) {
    return Padding(
      padding: itemPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Line and Dot
          Column(
            children: [
              // Dot
              Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: event.color ?? context.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.backgroundColor, width: 2),
                ),
                child:
                    event.customDot ??
                    (event.icon != null
                        ? Icon(
                            event.icon,
                            size: dotSize * 0.6,
                            color: context.onPrimaryColor,
                          )
                        : null),
              ),
              // Connecting Line
              if (showConnectingLine && index < events.length - 1)
                Container(
                  width: lineWidth,
                  height: 40,
                  color: lineColor ?? context.gray300,
                ),
            ],
          ),

          SizedBox(width: context.yoSpacingMd),

          // Content
          Expanded(
            child: Card(
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(context.yoSpacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: YoText.bodyLarge(
                            event.title,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        YoText.bodySmall(
                          YoDateFormatter.formatDate(event.date),
                          color: context.gray500,
                        ),
                      ],
                    ),

                    if (event.description != null) ...[
                      SizedBox(height: context.yoSpacingSm),
                      YoText.bodyMedium(
                        event.description!,
                        color: context.gray600,
                      ),
                    ],

                    if (event.actions != null && event.actions!.isNotEmpty) ...[
                      SizedBox(height: context.yoSpacingSm),
                      Row(
                        children: [
                          for (final action in event.actions!) ...[
                            action,
                            if (action != event.actions!.last)
                              SizedBox(width: context.yoSpacingSm),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalTimelineItem(
    BuildContext context,
    YoTimelineEvent event,
    int index,
  ) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          // Dot and Line
          Stack(
            children: [
              if (showConnectingLine && index < events.length - 1)
                Positioned(
                  left: dotSize / 2,
                  top: dotSize / 2 - lineWidth / 2,
                  child: Container(
                    width: 200 - dotSize,
                    height: lineWidth,
                    color: lineColor ?? context.gray300,
                  ),
                ),
              Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: event.color ?? context.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.backgroundColor, width: 2),
                ),
                child:
                    event.customDot ??
                    (event.icon != null
                        ? Icon(
                            event.icon,
                            size: dotSize * 0.6,
                            color: context.onPrimaryColor,
                          )
                        : null),
              ),
            ],
          ),

          SizedBox(height: context.yoSpacingSm),

          // Content
          Expanded(
            child: Card(
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(context.yoSpacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoText.bodyMedium(
                      event.title,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: context.yoSpacingXs),

                    YoText.bodySmall(
                      YoDateFormatter.formatDate(event.date),
                      color: context.gray500,
                    ),

                    if (event.description != null) ...[
                      SizedBox(height: context.yoSpacingSm),
                      Expanded(
                        child: YoText.bodySmall(
                          event.description!,
                          color: context.gray600,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum TimelineDirection { vertical, horizontal }
