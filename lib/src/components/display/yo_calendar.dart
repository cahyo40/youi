import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

enum YoCalendarView { daily, weekly, monthly }

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

class YoCalendarTheme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color headerBackgroundColor;
  final Color headerTextColor;
  final Color dayHeaderBackgroundColor;
  final Color dayHeaderTextColor;
  final Color todayHighlightColor;
  final Color todayTextColor;
  final Color eventBackgroundColor;
  final Color eventTextColor;
  final Color borderColor;
  final double eventBorderRadius;
  final EdgeInsets eventPadding;
  final double hourLabelWidth;
  final double dayHeaderHeight;

  const YoCalendarTheme({
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.headerBackgroundColor = Colors.blue,
    this.headerTextColor = Colors.white,
    this.dayHeaderBackgroundColor = Colors.grey,
    this.dayHeaderTextColor = Colors.black87,
    this.todayHighlightColor = Colors.red,
    this.todayTextColor = Colors.white,
    this.eventBackgroundColor = Colors.blue,
    this.eventTextColor = Colors.white,
    this.borderColor = Colors.grey,
    this.eventBorderRadius = 8.0,
    this.eventPadding = const EdgeInsets.all(8.0),
    this.hourLabelWidth = 60.0,
    this.dayHeaderHeight = 40.0,
  });

  factory YoCalendarTheme.fromContext(BuildContext context) {
    return YoCalendarTheme(
      primaryColor: context.primaryColor,
      backgroundColor: context.backgroundColor,
      headerBackgroundColor: context.primaryColor,
      headerTextColor: context.onPrimaryColor,
      dayHeaderBackgroundColor: context.gray100,
      dayHeaderTextColor: context.textColor,
      todayHighlightColor: context.errorColor,
      todayTextColor: context.onPrimaryColor,
      eventBackgroundColor: context.primaryColor,
      eventTextColor: context.onPrimaryColor,
      borderColor: context.gray300,
    );
  }

  YoCalendarTheme copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    Color? dayHeaderBackgroundColor,
    Color? dayHeaderTextColor,
    Color? todayHighlightColor,
    Color? todayTextColor,
    Color? eventBackgroundColor,
    Color? eventTextColor,
    Color? borderColor,
    double? eventBorderRadius,
    EdgeInsets? eventPadding,
    double? hourLabelWidth,
    double? dayHeaderHeight,
  }) {
    return YoCalendarTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      dayHeaderBackgroundColor:
          dayHeaderBackgroundColor ?? this.dayHeaderBackgroundColor,
      dayHeaderTextColor: dayHeaderTextColor ?? this.dayHeaderTextColor,
      todayHighlightColor: todayHighlightColor ?? this.todayHighlightColor,
      todayTextColor: todayTextColor ?? this.todayTextColor,
      eventBackgroundColor: eventBackgroundColor ?? this.eventBackgroundColor,
      eventTextColor: eventTextColor ?? this.eventTextColor,
      borderColor: borderColor ?? this.borderColor,
      eventBorderRadius: eventBorderRadius ?? this.eventBorderRadius,
      eventPadding: eventPadding ?? this.eventPadding,
      hourLabelWidth: hourLabelWidth ?? this.hourLabelWidth,
      dayHeaderHeight: dayHeaderHeight ?? this.dayHeaderHeight,
    );
  }
}

class YoCalendar extends StatefulWidget {
  final List<YoCalendarEvent> events;
  final YoCalendarView initialView;
  final YoCalendarTheme? theme;
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
    this.theme,
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

  YoCalendarTheme get _theme {
    if (widget.theme != null) return widget.theme!;
    return YoCalendarTheme.fromContext(context);
  }

  void _changeView(YoCalendarView? newView) {
    if (newView != null) {
      setState(() {
        _currentView = newView;
      });
      _notifyRangeChanged();
    }
  }

  void _navigateToPrevious() {
    setState(() {
      switch (_currentView) {
        case YoCalendarView.daily:
          _currentDate = _currentDate.subtract(const Duration(days: 1));
          break;
        case YoCalendarView.weekly:
          _currentDate = _currentDate.subtract(const Duration(days: 7));
          break;
        case YoCalendarView.monthly:
          _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
          break;
      }
    });
    _notifyRangeChanged();
  }

  void _navigateToNext() {
    setState(() {
      switch (_currentView) {
        case YoCalendarView.daily:
          _currentDate = _currentDate.add(const Duration(days: 1));
          break;
        case YoCalendarView.weekly:
          _currentDate = _currentDate.add(const Duration(days: 7));
          break;
        case YoCalendarView.monthly:
          _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
          break;
      }
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
      if (_currentView == YoCalendarView.monthly) {
        _currentDate = date;
      }
    });
    widget.onDateSelected?.call(date);
  }

  void _notifyRangeChanged() {
    final range = _getCurrentRange();
    widget.onRangeChanged?.call(range.$1, range.$2);
  }

  (DateTime, DateTime) _getCurrentRange() {
    switch (_currentView) {
      case YoCalendarView.daily:
        final start = DateTime(
          _currentDate.year,
          _currentDate.month,
          _currentDate.day,
        );
        final end = start.add(const Duration(days: 1));
        return (start, end);
      case YoCalendarView.weekly:
        final start = _currentDate.subtract(
          Duration(days: _currentDate.weekday - 1),
        );
        final end = start.add(const Duration(days: 7));
        return (start, end);
      case YoCalendarView.monthly:
        final start = DateTime(_currentDate.year, _currentDate.month, 1);
        final end = DateTime(_currentDate.year, _currentDate.month + 1, 1);
        return (start, end);
    }
  }

  String _getHeaderTitle() {
    switch (_currentView) {
      case YoCalendarView.daily:
        return '${_formatDate(_currentDate)}';
      case YoCalendarView.weekly:
        final range = _getCurrentRange();
        return '${_formatDate(range.$1)} - ${_formatDate(range.$2.subtract(const Duration(days: 1)))}';
      case YoCalendarView.monthly:
        return '${_getMonthName(_currentDate.month)} ${_currentDate.year}';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  // Sort events by date and time
  List<YoCalendarEvent> _getSortedEventsForDay(DateTime day) {
    final events = widget.events.where((event) {
      final eventDay = DateTime(
        event.startTime.year,
        event.startTime.month,
        event.startTime.day,
      );
      final targetDay = DateTime(day.year, day.month, day.day);
      return eventDay == targetDay;
    }).toList();

    // Sort by start time
    events.sort((a, b) => a.startTime.compareTo(b.startTime));
    return events;
  }

  List<YoCalendarEvent> _getSortedEventsForTimeRange(DateTime day, int hour) {
    final events = widget.events.where((event) {
      final eventDay = DateTime(
        event.startTime.year,
        event.startTime.month,
        event.startTime.day,
      );
      final targetDay = DateTime(day.year, day.month, day.day);
      return eventDay == targetDay && event.startTime.hour == hour;
    }).toList();

    // Sort by start time
    events.sort((a, b) => a.startTime.compareTo(b.startTime));
    return events;
  }

  List<YoCalendarEvent> _getAllSortedEvents() {
    final events = List<YoCalendarEvent>.from(widget.events);
    // Sort by start time
    events.sort((a, b) => a.startTime.compareTo(b.startTime));
    return events;
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top row: Title, Navigation, and Controls
          Row(
            children: [
              if (widget.showNavigation) ...[
                YoButton.outline(
                  text: 'Today',
                  onPressed: _goToToday,
                  textColor: _theme.headerTextColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: (widget.title != null)
                      ? YoText.titleMedium(
                          widget.title!,
                          fontWeight: FontWeight.bold,
                          align: TextAlign.center,
                          color: _theme.headerTextColor.withOpacity(0.9),
                        )
                      : SizedBox(),
                ),

                const SizedBox(width: 16),
              ],

              if (widget.showViewSelector) _buildViewSelector(),

              if (widget.headerTrailing != null) ...[
                const SizedBox(width: 16),
                widget.headerTrailing!,
              ],
            ],
          ),

          // Bottom row: Date range
          const SizedBox(height: 18),
          Row(
            spacing: 8,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, color: _theme.headerTextColor),
                onPressed: _navigateToPrevious,
              ),
              Expanded(
                child: YoText.titleMedium(
                  _getHeaderTitle(),

                  color: _theme.headerTextColor.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  align: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: _theme.headerTextColor),
                onPressed: _navigateToNext,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewSelector() {
    return Container(
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor, // Background sesuai primary color
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButton<YoCalendarView>(
        value: _currentView,
        onChanged: _changeView,
        dropdownColor:
            _theme.headerBackgroundColor, // Background sesuai primary color
        underline: const SizedBox(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: context.onPrimaryColor,
        ), // Icon color onPrimaryBW
        style: TextStyle(
          color: context.onPrimaryColor, // Text color onPrimaryBW
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          DropdownMenuItem(
            value: YoCalendarView.daily,
            child: Text('Daily View'),
          ),
          DropdownMenuItem(
            value: YoCalendarView.weekly,
            child: Text('Weekly View'),
          ),
          DropdownMenuItem(
            value: YoCalendarView.monthly,
            child: Text('Monthly View'),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyView() {
    final hours = List.generate(24, (index) => index);

    return Column(
      children: [
        // Day header
        Container(
          height: _theme.dayHeaderHeight,
          decoration: BoxDecoration(
            color: _theme.dayHeaderBackgroundColor,
            border: Border(bottom: BorderSide(color: _theme.borderColor)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: _theme.hourLabelWidth,
                child: Text(
                  'Time',
                  style: TextStyle(
                    color: _theme.dayHeaderTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    _formatDate(_currentDate),
                    style: TextStyle(
                      color: _theme.dayHeaderTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Events list for the day
        Expanded(
          child: _buildEventsList(
            _getSortedEventsForDay(_currentDate),
            showDate: false,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyView() {
    final today = DateTime.now();
    final weekStart = _currentDate.subtract(
      Duration(days: _currentDate.weekday - 1),
    );
    final days = List.generate(
      7,
      (index) => weekStart.add(Duration(days: index)),
    );

    // Get all events for the week and sort them
    final weekEvents = <YoCalendarEvent>[];
    for (final day in days) {
      final dayEvents = _getSortedEventsForDay(day);
      for (final event in dayEvents) {
        weekEvents.add(event);
      }
    }
    weekEvents.sort((a, b) => a.startTime.compareTo(b.startTime));

    return Column(
      children: [
        // Week days header
        Container(
          height: _theme.dayHeaderHeight,
          decoration: BoxDecoration(
            color: _theme.dayHeaderBackgroundColor,
            border: Border(bottom: BorderSide(color: _theme.borderColor)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: _theme.hourLabelWidth,
                child: Text(
                  'Date',
                  style: TextStyle(
                    color: _theme.dayHeaderTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...days.map(
                (day) => Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(day),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: _theme.borderColor),
                        ),
                        color: _isSameDay(day, today)
                            ? _theme.todayHighlightColor
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getDayName(day.weekday),
                            style: TextStyle(
                              color: _isSameDay(day, today)
                                  ? _theme.todayTextColor
                                  : _theme.dayHeaderTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            day.day.toString(),
                            style: TextStyle(
                              color: _isSameDay(day, today)
                                  ? _theme.todayTextColor
                                  : _theme.dayHeaderTextColor,
                              fontWeight: _isSameDay(day, today)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Events list for the week
        Expanded(child: _buildEventsList(weekEvents, showDate: true)),
      ],
    );
  }

  Widget _buildMonthlyView() {
    final today = DateTime.now();
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDayOfMonth = DateTime(
      _currentDate.year,
      _currentDate.month + 1,
      0,
    );

    final startDate = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday - 1),
    );
    final endDate = lastDayOfMonth.add(
      Duration(days: 7 - lastDayOfMonth.weekday),
    );

    final totalDays = endDate.difference(startDate).inDays;
    final weeks = (totalDays / 7).ceil();

    // Get all events for the month and sort them
    final monthEvents = <YoCalendarEvent>[];
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      final dayEvents = _getSortedEventsForDay(currentDay);
      for (final event in dayEvents) {
        monthEvents.add(event);
      }
      currentDay = currentDay.add(const Duration(days: 1));
    }
    monthEvents.sort((a, b) => a.startTime.compareTo(b.startTime));

    return Column(
      children: [
        // Calendar grid header
        Container(
          height: _theme.dayHeaderHeight,
          decoration: BoxDecoration(
            color: _theme.dayHeaderBackgroundColor,
            border: Border(bottom: BorderSide(color: _theme.borderColor)),
          ),
          child: Row(
            children: List.generate(
              7,
              (index) => Expanded(
                child: Center(
                  child: Text(
                    _getDayName(index + 1),
                    style: TextStyle(
                      color: _theme.dayHeaderTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Calendar grid with dates
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.3,
            ),
            itemCount: weeks * 7,
            itemBuilder: (context, index) {
              final currentDay = startDate.add(Duration(days: index));
              final isCurrentMonth = currentDay.month == _currentDate.month;
              final isToday = _isSameDay(currentDay, today);
              final isSelected = _isSameDay(currentDay, _selectedDate);
              final hasEvents = _getSortedEventsForDay(currentDay).isNotEmpty;

              return GestureDetector(
                onTap: () => _selectDate(currentDay),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: _theme.borderColor),
                      bottom: BorderSide(color: _theme.borderColor),
                    ),
                    color: isToday
                        ? _theme.todayHighlightColor
                        : (isSelected
                              ? _theme.primaryColor.withOpacity(0.1)
                              : _theme.backgroundColor),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentDay.day.toString(),
                        style: TextStyle(
                          color: isToday
                              ? _theme.todayTextColor
                              : (isCurrentMonth
                                    ? _theme.dayHeaderTextColor
                                    : _theme.dayHeaderTextColor.withOpacity(
                                        0.3,
                                      )),
                          fontWeight: isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Event dots indicator
                      if (hasEvents && isCurrentMonth)
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _theme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Events list for selected date
        if (_currentView == YoCalendarView.monthly)
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _theme.borderColor)),
            ),
            child: _buildEventsList(
              _getSortedEventsForDay(_selectedDate),
              showDate: false,
            ),
          ),
      ],
    );
  }

  Widget _buildEventsList(
    List<YoCalendarEvent> events, {
    bool showDate = true,
  }) {
    if (events.isEmpty) {
      return Center(
        child: Text(
          'No events',
          style: TextStyle(
            color: _theme.dayHeaderTextColor.withOpacity(0.5),
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildEventCard(event, showDate: showDate);
      },
    );
  }

  Widget _buildEventCard(YoCalendarEvent event, {bool showDate = true}) {
    final eventColor = event.color ?? _theme.eventBackgroundColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_theme.eventBorderRadius),
      ),
      child: InkWell(
        onTap: () => widget.onEventTap?.call(event),
        borderRadius: BorderRadius.circular(_theme.eventBorderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: eventColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(_theme.eventBorderRadius),
            border: Border.all(color: eventColor.withOpacity(0.3), width: 1),
          ),
          padding: _theme.eventPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Color indicator
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: eventColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              // Event content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showDate) ...[
                      Text(
                        _formatDate(event.startTime),
                        style: TextStyle(
                          color: _theme.dayHeaderTextColor.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                    Text(
                      event.title,
                      style: TextStyle(
                        color: _theme.dayHeaderTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (event.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        event.description!,
                        style: TextStyle(
                          color: _theme.dayHeaderTextColor.withOpacity(0.7),
                          fontSize: 12,
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
                          color: _theme.dayHeaderTextColor.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatEventTime(event),
                          style: TextStyle(
                            color: _theme.dayHeaderTextColor.withOpacity(0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    if (event.children.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: event.children.map((child) => child).toList(),
                      ),
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

  String _formatEventTime(YoCalendarEvent event) {
    if (event.isAllDay) {
      return 'All day';
    }

    final start = event.startTime;
    final end = event.endTime;

    if (_isSameDay(start, end)) {
      return '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    } else {
      return '${_formatDate(start)} - ${_formatDate(end)}';
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: _theme.borderColor),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildCalendarView()),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    switch (_currentView) {
      case YoCalendarView.daily:
        return _buildDailyView();
      case YoCalendarView.weekly:
        return _buildWeeklyView();
      case YoCalendarView.monthly:
        return _buildMonthlyView();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
