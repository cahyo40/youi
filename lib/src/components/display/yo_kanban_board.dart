// File: yo_kanban_board.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoKanbanItem {
  final String id;
  final String title;
  final String? description;
  final Color? color;
  final Widget? leading;
  final List<String> tags;
  final DateTime? dueDate;
  final int priority;
  final List<Widget> customWidgets; // NEW: List widget custom

  const YoKanbanItem({
    required this.id,
    required this.title,
    this.description,
    this.color,
    this.leading,
    this.tags = const [],
    this.dueDate,
    this.priority = 0,
    this.customWidgets = const [], // NEW: Default empty list
  });

  YoKanbanItem copyWith({
    String? id,
    String? title,
    String? description,
    Color? color,
    Widget? leading,
    List<String>? tags,
    DateTime? dueDate,
    int? priority,
    List<Widget>? customWidgets, // NEW: Add customWidgets to copyWith
  }) {
    return YoKanbanItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      leading: leading ?? this.leading,
      tags: tags ?? this.tags,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      customWidgets: customWidgets ?? this.customWidgets, // NEW
    );
  }
}

class YoKanbanColumn {
  final String id;
  final String title;
  final Color? color;
  final IconData? icon;
  final List<YoKanbanItem> items;
  final int maxItems;

  const YoKanbanColumn({
    required this.id,
    required this.title,
    this.color,
    this.icon,
    required this.items,
    this.maxItems = 10,
  });

  YoKanbanColumn copyWith({
    String? id,
    String? title,
    Color? color,
    IconData? icon,
    List<YoKanbanItem>? items,
    int? maxItems,
  }) {
    return YoKanbanColumn(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      items: items ?? this.items,
      maxItems: maxItems ?? this.maxItems,
    );
  }
}

class YoKanbanBoard extends StatefulWidget {
  final List<YoKanbanColumn> columns;
  final Function(YoKanbanItem, String fromColumnId, String toColumnId)?
  onItemMoved;
  final Function(YoKanbanItem, String columnId)? onItemTap;
  final Function(YoKanbanColumn)? onColumnTap;
  final double columnWidth;
  final double columnSpacing;
  final bool scrollable;
  final double height;
  final bool dragEnabled;

  const YoKanbanBoard({
    super.key,
    required this.columns,
    this.onItemMoved,
    this.onItemTap,
    this.onColumnTap,
    this.columnWidth = 280,
    this.columnSpacing = 16,
    this.scrollable = true,
    this.height = 400,
    this.dragEnabled = true,
  });

  @override
  State<YoKanbanBoard> createState() => _YoKanbanBoardState();
}

class _YoKanbanBoardState extends State<YoKanbanBoard> {
  late List<YoKanbanColumn> _columns;
  String? _draggedItemId;
  String? _draggedFromColumnId;

  @override
  void initState() {
    super.initState();
    _columns = widget.columns;
  }

  void _handleItemMove(
    YoKanbanItem item,
    String fromColumnId,
    String toColumnId,
  ) {
    if (fromColumnId == toColumnId || !widget.dragEnabled) return;

    setState(() {
      // Remove from source column
      final fromColumnIndex = _columns.indexWhere(
        (col) => col.id == fromColumnId,
      );
      if (fromColumnIndex != -1) {
        final fromColumn = _columns[fromColumnIndex];
        final updatedFromItems = List<YoKanbanItem>.from(fromColumn.items)
          ..removeWhere((i) => i.id == item.id);

        _columns[fromColumnIndex] = fromColumn.copyWith(
          items: updatedFromItems,
        );
      }

      // Add to target column
      final toColumnIndex = _columns.indexWhere((col) => col.id == toColumnId);
      if (toColumnIndex != -1) {
        final toColumn = _columns[toColumnIndex];
        final updatedToItems = List<YoKanbanItem>.from(toColumn.items)
          ..add(item);

        _columns[toColumnIndex] = toColumn.copyWith(items: updatedToItems);
      }
    });

    widget.onItemMoved?.call(item, fromColumnId, toColumnId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: widget.scrollable
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(widget.columnSpacing),
              itemCount: _columns.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: widget.columnSpacing),
              itemBuilder: (context, index) {
                return _buildColumn(context, _columns[index]);
              },
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < _columns.length; i++) ...[
                  _buildColumn(context, _columns[i]),
                  if (i < _columns.length - 1)
                    SizedBox(width: widget.columnSpacing),
                ],
              ],
            ),
    );
  }

  Widget _buildColumn(BuildContext context, YoKanbanColumn column) {
    return SizedBox(
      width: widget.columnWidth,
      child: widget.dragEnabled
          ? DragTarget<Map<String, dynamic>>(
              onAccept: (data) {
                final String itemId = data['itemId'];
                final String fromColumnId = data['fromColumnId'];

                final item = _columns
                    .firstWhere((col) => col.id == fromColumnId)
                    .items
                    .firstWhere((item) => item.id == itemId);

                _handleItemMove(item, fromColumnId, column.id);
              },
              builder: (context, candidateData, rejectedData) {
                return _buildColumnContent(
                  context,
                  column,
                  candidateData.isNotEmpty,
                );
              },
            )
          : _buildColumnContent(context, column, false),
    );
  }

  Widget _buildColumnContent(
    BuildContext context,
    YoKanbanColumn column,
    bool isDragTargetActive,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDragTargetActive
              ? context.primaryColor.withOpacity(0.5)
              : context.gray200,
          width: isDragTargetActive ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Column Header
          Padding(
            padding: EdgeInsets.all(context.yoSpacingMd),
            child: Row(
              children: [
                if (column.icon != null) ...[
                  Icon(
                    column.icon,
                    color: column.color ?? context.primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: context.yoSpacingSm),
                ],
                Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onColumnTap?.call(column),
                    child: YoText.bodyLarge(
                      '${column.title} (${column.items.length})',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Column Items
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: double.infinity,
              ),
              child: column.items.isEmpty
                  ? _buildEmptyState(context)
                  : _buildItemsList(context, column),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, YoKanbanColumn column) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: context.yoSpacingSm),
      shrinkWrap: true,
      itemCount: column.items.length,
      itemBuilder: (context, index) {
        final item = column.items[index];
        return _buildKanbanItem(context, item, column.id);
      },
    );
  }

  Widget _buildKanbanItem(
    BuildContext context,
    YoKanbanItem item,
    String columnId,
  ) {
    if (widget.dragEnabled) {
      return _buildDraggableKanbanItem(context, item, columnId);
    } else {
      return _buildKanbanItemWidget(context, item, columnId, false);
    }
  }

  Widget _buildDraggableKanbanItem(
    BuildContext context,
    YoKanbanItem item,
    String columnId,
  ) {
    return LongPressDraggable<Map<String, dynamic>>(
      data: {'itemId': item.id, 'fromColumnId': columnId},
      feedback: Material(
        type: MaterialType.transparency,
        child: Container(
          width: widget.columnWidth - widget.columnSpacing * 2,
          margin: EdgeInsets.all(context.yoSpacingSm),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(context.yoSpacingMd),
              child: _buildKanbanItemContent(context, item, columnId, true),
            ),
          ),
        ),
      ),
      onDragStarted: () {
        setState(() {
          _draggedItemId = item.id;
          _draggedFromColumnId = columnId;
        });
      },
      onDragEnd: (_) {
        setState(() {
          _draggedItemId = null;
          _draggedFromColumnId = null;
        });
      },
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildKanbanItemContent(context, item, columnId, false),
      ),
      child: _buildKanbanItemWidget(context, item, columnId, false),
    );
  }

  Widget _buildKanbanItemWidget(
    BuildContext context,
    YoKanbanItem item,
    String columnId,
    bool isDragging,
  ) {
    return Container(
      margin: EdgeInsets.all(context.yoSpacingSm),
      child: Card(
        elevation: isDragging ? 4 : 1,
        color: isDragging ? context.primaryColor.withOpacity(0.1) : null,
        child: InkWell(
          onTap: () => widget.onItemTap?.call(item, columnId),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(context.yoSpacingMd),
            child: _buildKanbanItemContent(context, item, columnId, isDragging),
          ),
        ),
      ),
    );
  }

  Widget _buildKanbanItemContent(
    BuildContext context,
    YoKanbanItem item,
    String columnId,
    bool isDragging,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Item Header with Drag Handle (only show when drag enabled)
        Row(
          children: [
            if (widget.dragEnabled) ...[
              MouseRegion(
                cursor: SystemMouseCursors.grab,
                child: Icon(
                  Icons.drag_handle,
                  size: 16,
                  color: context.gray400,
                ),
              ),
              SizedBox(width: context.yoSpacingSm),
            ],

            if (item.leading != null) ...[
              item.leading!,
              SizedBox(width: context.yoSpacingSm),
            ],

            Expanded(
              child: YoText.bodyMedium(item.title, fontWeight: FontWeight.w500),
            ),

            if (item.priority > 0)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.yoSpacingSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: _getPriorityColor(context, item.priority),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: YoText.bodySmall(
                  'P${item.priority}',
                  color: context.onPrimaryColor,
                ),
              ),
          ],
        ),

        if (item.description != null) ...[
          SizedBox(height: context.yoSpacingXs),
          YoText.bodySmall(
            item.description!,
            color: context.gray600,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],

        // NEW: Custom widgets section - above tags, below description
        if (item.customWidgets.isNotEmpty) ...[
          SizedBox(height: context.yoSpacingSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: item.customWidgets.map((widget) {
              return Padding(
                padding: EdgeInsets.only(bottom: context.yoSpacingXs),
                child: widget,
              );
            }).toList(),
          ),
        ],

        if (item.tags.isNotEmpty) ...[
          SizedBox(height: context.yoSpacingSm),
          Wrap(
            spacing: 4,
            children: item.tags
                .map(
                  (tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.gray100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: YoText.bodySmall(tag, color: context.gray600),
                  ),
                )
                .toList(),
          ),
        ],

        if (item.dueDate != null) ...[
          SizedBox(height: context.yoSpacingSm),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: context.gray500),
              SizedBox(width: 4),
              YoText.bodySmall(
                _formatDate(item.dueDate!),
                color: context.gray600,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return widget.dragEnabled
        ? DragTarget<Map<String, dynamic>>(
            onAccept: (data) {
              final String itemId = data['itemId'];
              final String fromColumnId = data['fromColumnId'];

              final fromColumn = _columns.firstWhere(
                (col) => col.id == fromColumnId,
              );
              final item = fromColumn.items.firstWhere(
                (item) => item.id == itemId,
              );

              // Find the first empty column
              final emptyColumn = _columns.firstWhere(
                (col) => col.items.isEmpty,
              );
              _handleItemMove(item, fromColumnId, emptyColumn.id);
            },
            builder: (context, candidateData, rejectedData) {
              return _buildEmptyStateContent(candidateData.isNotEmpty);
            },
          )
        : _buildEmptyStateContent(false);
  }

  Widget _buildEmptyStateContent(bool isDragTargetActive) {
    return Container(
      margin: EdgeInsets.all(context.yoSpacingMd),
      padding: EdgeInsets.all(context.yoSpacingXl),
      decoration: BoxDecoration(
        border: isDragTargetActive
            ? Border.all(color: context.primaryColor, width: 2)
            : Border.all(color: context.gray300, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
        color: isDragTargetActive
            ? context.primaryColor.withOpacity(0.1)
            : context.gray50,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: isDragTargetActive
                  ? context.primaryColor
                  : context.gray300,
            ),
            SizedBox(height: context.yoSpacingSm),
            YoText.bodyMedium(
              isDragTargetActive ? 'Drop here' : 'No items',
              color: isDragTargetActive
                  ? context.primaryColor
                  : context.gray500,
              fontWeight: isDragTargetActive
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(BuildContext context, int priority) {
    switch (priority) {
      case 1:
        return context.successColor;
      case 2:
        return context.warningColor;
      case 3:
        return context.errorColor;
      default:
        return context.primaryColor;
    }
  }

  String _formatDate(DateTime date) {
    return YoDateFormatter.formatDate(date);
  }
}

// Simplified version untuk non-scrollable layout
class YoKanbanBoardSimple extends StatefulWidget {
  final List<YoKanbanColumn> columns;
  final Function(YoKanbanItem, String fromColumnId, String toColumnId)?
  onItemMoved;
  final Function(YoKanbanItem, String columnId)? onItemTap;
  final double columnWidth;
  final double columnSpacing;
  final double height;
  final bool dragEnabled;

  const YoKanbanBoardSimple({
    super.key,
    required this.columns,
    this.onItemMoved,
    this.onItemTap,
    this.columnWidth = 280,
    this.columnSpacing = 16,
    this.height = 400,
    this.dragEnabled = true,
  });

  @override
  State<YoKanbanBoardSimple> createState() => _YoKanbanBoardSimpleState();
}

class _YoKanbanBoardSimpleState extends State<YoKanbanBoardSimple> {
  late List<YoKanbanColumn> _columns;

  @override
  void initState() {
    super.initState();
    _columns = widget.columns;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < _columns.length; i++) ...[
              SizedBox(
                width: widget.columnWidth,
                child: _buildSimpleColumn(context, _columns[i]),
              ),
              if (i < _columns.length - 1)
                SizedBox(width: widget.columnSpacing),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleColumn(BuildContext context, YoKanbanColumn column) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column Header
          Padding(
            padding: EdgeInsets.all(context.yoSpacingMd),
            child: Row(
              children: [
                if (column.icon != null) ...[
                  Icon(
                    column.icon,
                    color: column.color ?? context.primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: context.yoSpacingSm),
                ],
                Expanded(
                  child: YoText.bodyLarge(
                    '${column.title} (${column.items.length})',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Column Items dengan height constraint yang jelas
          Container(
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: widget.height - 80, // Account for header height
            ),
            child: column.items.isEmpty
                ? YoEmptyState.noData()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.yoSpacingSm,
                    ),
                    itemCount: column.items.length,
                    itemBuilder: (context, index) {
                      final item = column.items[index];
                      return Container(
                        margin: EdgeInsets.all(context.yoSpacingSm),
                        child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: EdgeInsets.all(context.yoSpacingMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (widget.dragEnabled) ...[
                                      Icon(
                                        Icons.drag_handle,
                                        size: 16,
                                        color: context.gray400,
                                      ),
                                      SizedBox(width: context.yoSpacingSm),
                                    ],
                                    Expanded(
                                      child: YoText.bodyMedium(
                                        item.title,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                                // NEW: Custom widgets untuk simple version
                                if (item.customWidgets.isNotEmpty) ...[
                                  SizedBox(height: context.yoSpacingSm),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: item.customWidgets.map((widget) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: context.yoSpacingXs,
                                        ),
                                        child: widget,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
