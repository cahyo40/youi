import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

/// Calendar view type
enum YoCalendarView { daily, weekly, monthly }

/// Calendar event model
class YoCalendarEvent {
  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final Color? color;
  final bool isAllDay;
  final List<Widget> children;

  const YoCalendarEvent({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.description,
    this.color,
    this.isAllDay = false,
    this.children = const [],
  });

  Duration get duration => endTime.difference(startTime);
}

/// Calendar widget with daily, weekly, and monthly views
class YoCalendar extends StatefulWidget {
  final List<YoCalendarEvent> events;
  final YoCalendarView initialView;
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final Function(YoCalendarEvent)? onEventTap;
  final Function(DateTime, DateTime)? onRangeChanged;
  final bool showViewSelector;
  final bool showNavigation;
  final String? title;
  final Widget? headerTrailing;

  const YoCalendar({
    super.key,
    required this.events,
    this.initialView = YoCalendarView.monthly,
    this.initialDate,
    this.onDateSelected,
    this.onEventTap,
    this.onRangeChanged,
    this.showViewSelector = true,
    this.showNavigation = true,
    this.title,
    this.headerTrailing,
  });

  @override
  State<YoCalendar> createState() => _YoCalendarState();
}

class _YoCalendarState extends State<YoCalendar> {
  late YoCalendarView _currentView;
  late DateTime _currentDate;
  late DateTime _selectedDate;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentView = widget.initialView;
    _currentDate = widget.initialDate ?? DateTime.now();
    _selectedDate = _currentDate;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Navigation helpers
  void _changeView(YoCalendarView? newView) {
    if (newView == null) return;
    setState(() => _currentView = newView);
    _notifyRangeChanged();
  }

  void _navigateToPrevious() {
    setState(() {
      _currentDate = switch (_currentView) {
        YoCalendarView.daily => _currentDate.subtract(const Duration(days: 1)),
        YoCalendarView.weekly => _currentDate.subtract(const Duration(days: 7)),
        YoCalendarView.monthly => DateTime(
          _currentDate.year,
          _currentDate.month - 1,
        ),
      };
    });
    _notifyRangeChanged();
  }

  void _navigateToNext() {
    setState(() {
      _currentDate = switch (_currentView) {
        YoCalendarView.daily => _currentDate.add(const Duration(days: 1)),
        YoCalendarView.weekly => _currentDate.add(const Duration(days: 7)),
        YoCalendarView.monthly => DateTime(
          _currentDate.year,
          _currentDate.month + 1,
        ),
      };
    });
    _notifyRangeChanged();
  }

  void _goToToday() {
    setState(() {
      _currentDate = DateTime.now();
      _selectedDate = DateTime.now();
    });
    _notifyRangeChanged();
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      if (_currentView == YoCalendarView.monthly) _currentDate = date;
    });
    widget.onDateSelected?.call(date);
  }

  void _notifyRangeChanged() {
    final range = _getCurrentRange();
    widget.onRangeChanged?.call(range.$1, range.$2);
  }

  (DateTime, DateTime) _getCurrentRange() {
    return switch (_currentView) {
      YoCalendarView.daily => (
        DateTime(_currentDate.year, _currentDate.month, _currentDate.day),
        DateTime(_currentDate.year, _currentDate.month, _currentDate.day + 1),
      ),
      YoCalendarView.weekly => (
        _currentDate.subtract(Duration(days: _currentDate.weekday - 1)),
        _currentDate
            .subtract(Duration(days: _currentDate.weekday - 1))
            .add(const Duration(days: 7)),
      ),
      YoCalendarView.monthly => (
        DateTime(_currentDate.year, _currentDate.month, 1),
        DateTime(_currentDate.year, _currentDate.month + 1, 1),
      ),
    };
  }

  // Date/Time helpers
  List<YoCalendarEvent> _getEventsForDay(DateTime day) {
    return widget.events.where((e) {
      return e.startTime.year == day.year &&
          e.startTime.month == day.month &&
          e.startTime.day == day.day;
    }).toList()..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatDate(DateTime d) => '${d.day} ${_monthName(d.month)} ${d.year}';
  String _monthName(int m) => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m - 1];
  String _dayName(int w) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][w - 1];

  String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  String _getHeaderTitle() {
    return switch (_currentView) {
      YoCalendarView.daily => _formatDate(_currentDate),
      YoCalendarView.weekly => () {
        final range = _getCurrentRange();
        return '${_formatDate(range.$1)} - ${_formatDate(range.$2.subtract(const Duration(days: 1)))}';
      }(),
      YoCalendarView.monthly =>
        '${_monthName(_currentDate.month)} ${_currentDate.year}',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.gray200),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(child: _buildView(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Top row
          Row(
            children: [
              if (widget.showNavigation) ...[
                YoButton.outline(
                  text: 'Today',
                  onPressed: _goToToday,
                  textColor: context.onPrimaryColor,
                ),
                const SizedBox(width: 16),
              ],
              if (widget.title != null)
                Expanded(
                  child: Text(
                    widget.title!,
                    style: context.yoTitleMedium.copyWith(
                      color: context.onPrimaryColor.withAlpha(230),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                const Expanded(child: SizedBox()),
              if (widget.showViewSelector) _buildViewSelector(context),
              if (widget.headerTrailing != null) ...[
                const SizedBox(width: 16),
                widget.headerTrailing!,
              ],
            ],
          ),

          // Navigation row
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, color: context.onPrimaryColor),
                onPressed: _navigateToPrevious,
              ),
              Expanded(
                child: Text(
                  _getHeaderTitle(),
                  style: context.yoBodyLarge.copyWith(
                    color: context.onPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: context.onPrimaryColor),
                onPressed: _navigateToNext,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewSelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: context.onPrimaryColor.withAlpha(77)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<YoCalendarView>(
        value: _currentView,
        onChanged: _changeView,
        dropdownColor: context.primaryColor,
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: context.onPrimaryColor),
        style: TextStyle(color: context.onPrimaryColor, fontSize: 14),
        items: YoCalendarView.values.map((v) {
          final label = switch (v) {
            YoCalendarView.daily => 'Day',
            YoCalendarView.weekly => 'Week',
            YoCalendarView.monthly => 'Month',
          };
          return DropdownMenuItem(value: v, child: Text(label));
        }).toList(),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return switch (_currentView) {
      YoCalendarView.daily => _buildDailyView(context),
      YoCalendarView.weekly => _buildWeeklyView(context),
      YoCalendarView.monthly => _buildMonthlyView(context),
    };
  }

  Widget _buildDailyView(BuildContext context) {
    final events = _getEventsForDay(_currentDate);
    return Column(
      children: [
        _buildDayHeader(context, _currentDate, showLabel: true),
        Expanded(child: _buildEventsList(context, events)),
      ],
    );
  }

  Widget _buildWeeklyView(BuildContext context) {
    final weekStart = _currentDate.subtract(
      Duration(days: _currentDate.weekday - 1),
    );
    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));
    final today = DateTime.now();

    final weekEvents = <YoCalendarEvent>[];
    for (final day in days) {
      weekEvents.addAll(_getEventsForDay(day));
    }
    weekEvents.sort((a, b) => a.startTime.compareTo(b.startTime));

    return Column(
      children: [
        // Week header
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: context.gray50,
            border: Border(bottom: BorderSide(color: context.gray200)),
          ),
          child: Row(
            children: days.map((day) {
              final isToday = _isSameDay(day, today);
              return Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(day),
                  child: Container(
                    color: isToday ? context.errorColor : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _dayName(day.weekday),
                          style: context.yoBodySmall.copyWith(
                            color: isToday
                                ? context.onPrimaryColor
                                : context.gray500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${day.day}',
                          style: context.yoBodyMedium.copyWith(
                            color: isToday
                                ? context.onPrimaryColor
                                : context.textColor,
                            fontWeight: isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(child: _buildEventsList(context, weekEvents, showDate: true)),
      ],
    );
  }

  Widget _buildMonthlyView(BuildContext context) {
    final today = DateTime.now();
    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDay = DateTime(_currentDate.year, _currentDate.month + 1, 0);
    final startDate = firstDay.subtract(Duration(days: firstDay.weekday - 1));
    final totalDays =
        ((lastDay.difference(startDate).inDays + 7 - lastDay.weekday) / 7)
            .ceil() *
        7;

    return Column(
      children: [
        // Day names header
        Container(
          height: 40,
          color: context.gray50,
          child: Row(
            children: List.generate(
              7,
              (i) => Expanded(
                child: Center(
                  child: Text(
                    _dayName(i + 1),
                    style: context.yoBodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Calendar grid
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: totalDays,
            itemBuilder: (ctx, index) {
              final day = startDate.add(Duration(days: index));
              final isCurrentMonth = day.month == _currentDate.month;
              final isToday = _isSameDay(day, today);
              final isSelected = _isSameDay(day, _selectedDate);
              final hasEvents = _getEventsForDay(day).isNotEmpty;

              return GestureDetector(
                onTap: () => _selectDate(day),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.gray100),
                    color: isToday
                        ? context.errorColor
                        : isSelected
                        ? context.primaryColor.withAlpha(26)
                        : context.backgroundColor,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${day.day}',
                        style: context.yoBodySmall.copyWith(
                          color: isToday
                              ? context.onPrimaryColor
                              : isCurrentMonth
                              ? context.textColor
                              : context.gray300,
                          fontWeight: isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (hasEvents && isCurrentMonth)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: context.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Selected date events
        Container(
          height: 180,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: context.gray200)),
          ),
          child: _buildEventsList(context, _getEventsForDay(_selectedDate)),
        ),
      ],
    );
  }

  Widget _buildDayHeader(
    BuildContext context,
    DateTime day, {
    bool showLabel = false,
  }) {
    return Container(
      height: 40,
      color: context.gray50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (showLabel)
            Text(
              'Date:',
              style: context.yoBodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
          const SizedBox(width: 8),
          Expanded(child: Text(_formatDate(day), style: context.yoBodyMedium)),
        ],
      ),
    );
  }

  Widget _buildEventsList(
    BuildContext context,
    List<YoCalendarEvent> events, {
    bool showDate = false,
  }) {
    if (events.isEmpty) {
      return Center(
        child: Text(
          'No events',
          style: context.yoBodyMedium.copyWith(color: context.gray400),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      itemBuilder: (ctx, i) =>
          _buildEventCard(context, events[i], showDate: showDate),
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    YoCalendarEvent event, {
    bool showDate = false,
  }) {
    final color = event.color ?? context.primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => widget.onEventTap?.call(event),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(26),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withAlpha(77)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Color indicator
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showDate) ...[
                      Text(
                        _formatDate(event.startTime),
                        style: context.yoBodySmall.copyWith(
                          color: context.gray500,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                    Text(
                      event.title,
                      style: context.yoBodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (event.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        event.description!,
                        style: context.yoBodySmall.copyWith(
                          color: context.gray600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: context.gray500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.isAllDay
                              ? 'All day'
                              : '${_formatTime(event.startTime)} - ${_formatTime(event.endTime)}',
                          style: context.yoBodySmall.copyWith(
                            color: context.gray500,
                          ),
                        ),
                      ],
                    ),
                    if (event.children.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(spacing: 8, runSpacing: 4, children: event.children),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
