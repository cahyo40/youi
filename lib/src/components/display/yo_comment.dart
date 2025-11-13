// File: yo_comment.dart
import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

enum YoCommentVariant { normal, compact, detailed }

class YoComment {
  final String id;
  final String userAvatar;
  final String userName;
  final String text;
  final DateTime timestamp;
  final int likes;
  final bool isLiked;
  final List<YoComment> replies;
  final bool isEdited;
  final String? userRole;
  final String? userTitle;

  const YoComment({
    required this.id,
    required this.userAvatar,
    required this.userName,
    required this.text,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
    this.replies = const [],
    this.isEdited = false,
    this.userRole,
    this.userTitle,
  });
}

class YoCommentWidget extends StatelessWidget {
  final YoComment comment;
  final YoCommentVariant variant;
  final Function(YoComment)? onLike;
  final Function(YoComment)? onReply;
  final Function(YoComment)? onEdit;
  final Function(YoComment)? onDelete;
  final bool showReplies;
  final int maxReplyDepth;
  final Color? backgroundColor;
  final bool showActions;
  final bool showLikes;

  const YoCommentWidget({
    super.key,
    required this.comment,
    this.variant = YoCommentVariant.normal,
    this.onLike,
    this.onReply,
    this.onEdit,
    this.onDelete,
    this.showReplies = true,
    this.maxReplyDepth = 3,
    this.backgroundColor,
    this.showActions = true,
    this.showLikes = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComment(context),

        // Replies
        if (showReplies &&
            comment.replies.isNotEmpty &&
            variant != YoCommentVariant.compact)
          Padding(
            padding: EdgeInsets.only(
              left: _getReplyIndent(context),
              top: context.yoSpacingMd,
            ),
            child: Column(
              children: comment.replies
                  .map(
                    (reply) => YoCommentWidget(
                      comment: reply,
                      variant: variant,
                      onLike: onLike,
                      onReply: onReply,
                      onEdit: onEdit,
                      onDelete: onDelete,
                      showReplies: maxReplyDepth > 1,
                      maxReplyDepth: maxReplyDepth - 1,
                      backgroundColor: backgroundColor?.withOpacity(0.1),
                      showActions: showActions,
                      showLikes: showLikes,
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildComment(BuildContext context) {
    switch (variant) {
      case YoCommentVariant.normal:
        return _buildNormalComment(context);
      case YoCommentVariant.compact:
        return _buildCompactComment(context);
      case YoCommentVariant.detailed:
        return _buildDetailedComment(context);
    }
  }

  Widget _buildNormalComment(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.yoSpacingMd),
      padding: EdgeInsets.all(context.yoSpacingMd),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.gray50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - User info and timestamp
          Row(
            children: [
              YoAvatar.image(
                imageUrl: comment.userAvatar,
                size: YoAvatarSize.sm,
              ),
              SizedBox(width: context.yoSpacingSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        YoText.bodyMedium(
                          comment.userName,
                          fontWeight: FontWeight.w600,
                        ),
                        if (comment.userRole != null) ...[
                          SizedBox(width: context.yoSpacingXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.yoSpacingXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: YoText.bodySmall(
                              comment.userRole!,
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    YoText.bodySmall(
                      _formatTimestamp(comment.timestamp),
                      color: context.gray500,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: context.yoSpacingSm),

          // Comment text
          YoText.bodyMedium(comment.text),

          SizedBox(height: context.yoSpacingSm),

          // Footer - Actions and likes
          if (showActions)
            Row(
              children: [
                // Like button
                if (showLikes)
                  InkWell(
                    onTap: () => onLike?.call(comment),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.yoSpacingSm,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            comment.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 16,
                            color: comment.isLiked
                                ? context.errorColor
                                : context.gray500,
                          ),
                          SizedBox(width: 4),
                          YoText.bodySmall(
                            comment.likes.toString(),
                            color: comment.isLiked
                                ? context.errorColor
                                : context.gray500,
                          ),
                        ],
                      ),
                    ),
                  ),

                // Reply button
                InkWell(
                  onTap: () => onReply?.call(comment),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.yoSpacingSm,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.reply, size: 16, color: context.gray500),
                        SizedBox(width: 4),
                        YoText.bodySmall('Reply', color: context.gray500),
                      ],
                    ),
                  ),
                ),

                Spacer(),

                // Edited indicator
                if (comment.isEdited)
                  YoText.bodySmall('edited', color: context.gray400),

                // More actions menu
                if (onEdit != null || onDelete != null)
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                      color: context.gray500,
                    ),
                    itemBuilder: (context) => [
                      if (onEdit != null)
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 16,
                                color: context.gray600,
                              ),
                              SizedBox(width: 8),
                              YoText.bodySmall('Edit'),
                            ],
                          ),
                        ),
                      if (onDelete != null)
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 16,
                                color: context.errorColor,
                              ),
                              SizedBox(width: 8),
                              YoText.bodySmall(
                                'Delete',
                                color: context.errorColor,
                              ),
                            ],
                          ),
                        ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        onEdit?.call(comment);
                      } else if (value == 'delete') {
                        onDelete?.call(comment);
                      }
                    },
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCompactComment(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.yoSpacingSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          YoAvatar.image(imageUrl: comment.userAvatar, size: YoAvatarSize.xs),
          SizedBox(width: context.yoSpacingSm),

          // Content
          Expanded(
            child: Container(
              padding: EdgeInsets.all(context.yoSpacingSm),
              decoration: BoxDecoration(
                color: backgroundColor ?? context.gray100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info and timestamp
                  Row(
                    children: [
                      YoText.bodySmall(
                        comment.userName,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: context.yoSpacingXs),
                      YoText.bodySmall(
                        _formatTimestamp(comment.timestamp),
                        color: context.gray500,
                      ),
                      if (comment.isEdited) ...[
                        SizedBox(width: context.yoSpacingXs),
                        YoText.bodySmall('• edited', color: context.gray400),
                      ],
                    ],
                  ),

                  SizedBox(height: context.yoSpacingXs),

                  // Comment text
                  YoText.bodySmall(comment.text),

                  // Actions (minimal)
                  if (showActions)
                    Padding(
                      padding: EdgeInsets.only(top: context.yoSpacingXs),
                      child: Row(
                        children: [
                          if (showLikes && onLike != null)
                            GestureDetector(
                              onTap: () => onLike?.call(comment),
                              child: Icon(
                                comment.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 14,
                                color: comment.isLiked
                                    ? context.errorColor
                                    : context.gray500,
                              ),
                            ),
                          if (showLikes && onLike != null)
                            SizedBox(width: context.yoSpacingMd),
                          if (onReply != null)
                            GestureDetector(
                              onTap: () => onReply?.call(comment),
                              child: Icon(
                                Icons.reply,
                                size: 14,
                                color: context.gray500,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedComment(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.yoSpacingLg),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user info
          Container(
            padding: EdgeInsets.all(context.yoSpacingMd),
            decoration: BoxDecoration(
              color: context.gray50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                YoAvatar.image(
                  imageUrl: comment.userAvatar,
                  size: YoAvatarSize.md,
                ),
                SizedBox(width: context.yoSpacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          YoText.bodyLarge(
                            comment.userName,
                            fontWeight: FontWeight.w700,
                          ),
                          if (comment.userRole != null) ...[
                            SizedBox(width: context.yoSpacingSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.yoSpacingSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: context.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: YoText.bodySmall(
                                comment.userRole!,
                                color: context.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (comment.userTitle != null) ...[
                        SizedBox(height: 2),
                        YoText.bodySmall(
                          comment.userTitle!,
                          color: context.gray600,
                        ),
                      ],
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: context.gray500,
                          ),
                          SizedBox(width: 4),
                          YoText.bodySmall(
                            YoDateFormatter.formatRelativeTime(
                              comment.timestamp,
                            ),
                            color: context.gray500,
                          ),
                          if (comment.isEdited) ...[
                            SizedBox(width: 8),
                            YoText.bodySmall(
                              '• Edited',
                              color: context.gray400,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Comment content
          Padding(
            padding: EdgeInsets.all(context.yoSpacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoText.bodyLarge(comment.text),

                // Stats and actions
                Padding(
                  padding: EdgeInsets.only(top: context.yoSpacingMd),
                  child: Row(
                    children: [
                      // Likes count
                      if (showLikes)
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 16,
                              color: context.gray500,
                            ),
                            SizedBox(width: 4),
                            YoText.bodySmall(
                              '${comment.likes} ${comment.likes == 1 ? 'like' : 'likes'}',
                              color: context.gray600,
                            ),
                            SizedBox(width: context.yoSpacingMd),
                          ],
                        ),

                      // Replies count
                      if (comment.replies.isNotEmpty)
                        Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 16,
                              color: context.gray500,
                            ),
                            SizedBox(width: 4),
                            YoText.bodySmall(
                              '${comment.replies.length} ${comment.replies.length == 1 ? 'reply' : 'replies'}',
                              color: context.gray600,
                            ),
                            SizedBox(width: context.yoSpacingMd),
                          ],
                        ),

                      Spacer(),

                      // Action buttons
                      if (showActions)
                        Row(
                          children: [
                            if (showLikes && onLike != null)
                              _buildDetailedActionButton(
                                context,
                                comment.isLiked ? 'Liked' : 'Like',
                                comment.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                () => onLike?.call(comment),
                                isActive: comment.isLiked,
                              ),
                            if (onReply != null)
                              _buildDetailedActionButton(
                                context,
                                'Reply',
                                Icons.reply,
                                () => onReply?.call(comment),
                              ),
                            if (onEdit != null)
                              _buildDetailedActionButton(
                                context,
                                'Edit',
                                Icons.edit,
                                () => onEdit?.call(comment),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap, {
    bool isActive = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: context.yoSpacingSm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.yoSpacingSm,
            vertical: context.yoSpacingXs,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? context.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? context.primaryColor : context.gray600,
              ),
              SizedBox(width: 4),
              YoText.bodySmall(
                text,
                color: isActive ? context.primaryColor : context.gray600,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getReplyIndent(BuildContext context) {
    switch (variant) {
      case YoCommentVariant.normal:
        return context.yoSpacingXl;
      case YoCommentVariant.compact:
        return context.yoSpacingLg;
      case YoCommentVariant.detailed:
        return context.yoSpacingXl * 1.5;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class YoCommentList extends StatelessWidget {
  final List<YoComment> comments;
  final YoCommentVariant variant;
  final Function(YoComment)? onLike;
  final Function(YoComment)? onReply;
  final Function(YoComment)? onEdit;
  final Function(YoComment)? onDelete;
  final bool showReplies;
  final bool showLikes;
  final Widget? emptyState;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const YoCommentList({
    super.key,
    required this.comments,
    this.variant = YoCommentVariant.normal,
    this.onLike,
    this.onReply,
    this.onEdit,
    this.onDelete,
    this.showReplies = true,
    this.showLikes = true,
    this.emptyState,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return emptyState ?? _buildEmptyState(context);
    }

    return ListView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return YoCommentWidget(
          comment: comments[index],
          variant: variant,
          onLike: onLike,
          onReply: onReply,
          onEdit: onEdit,
          onDelete: onDelete,
          showReplies: showReplies,
          showLikes: showLikes,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.yoSpacingXl),
      child: Column(
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: context.gray300),
          SizedBox(height: context.yoSpacingMd),
          YoText.titleMedium(
            'No comments yet',
            color: context.gray500,
            align: TextAlign.center,
          ),
          SizedBox(height: context.yoSpacingSm),
          YoText.bodyMedium(
            'Be the first to share your thoughts!',
            color: context.gray400,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Extension untuk mudah membuat comment list dengan variant tertentu
extension YoCommentListExtensions on List<YoComment> {
  YoCommentList toCommentList({
    Key? key,
    YoCommentVariant variant = YoCommentVariant.normal,
    Function(YoComment)? onLike,
    Function(YoComment)? onReply,
    Function(YoComment)? onEdit,
    Function(YoComment)? onDelete,
    bool showReplies = true,
    bool showLikes = true,
    Widget? emptyState,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
  }) {
    return YoCommentList(
      key: key,
      comments: this,
      variant: variant,
      onLike: onLike,
      onReply: onReply,
      onEdit: onEdit,
      onDelete: onDelete,
      showReplies: showReplies,
      showLikes: showLikes,
      emptyState: emptyState,
      physics: physics,
      shrinkWrap: shrinkWrap,
    );
  }

  YoCommentList toCompactCommentList({
    Key? key,
    Function(YoComment)? onLike,
    Function(YoComment)? onReply,
    Function(YoComment)? onEdit,
    Function(YoComment)? onDelete,
    bool showLikes = true,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
  }) {
    return YoCommentList(
      key: key,
      comments: this,
      variant: YoCommentVariant.compact,
      onLike: onLike,
      onReply: onReply,
      onEdit: onEdit,
      onDelete: onDelete,
      showReplies: false,
      showLikes: showLikes,
      physics: physics,
      shrinkWrap: shrinkWrap,
    );
  }

  YoCommentList toDetailedCommentList({
    Key? key,
    Function(YoComment)? onLike,
    Function(YoComment)? onReply,
    Function(YoComment)? onEdit,
    Function(YoComment)? onDelete,
    bool showReplies = true,
    bool showLikes = true,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
  }) {
    return YoCommentList(
      key: key,
      comments: this,
      variant: YoCommentVariant.detailed,
      onLike: onLike,
      onReply: onReply,
      onEdit: onEdit,
      onDelete: onDelete,
      showReplies: showReplies,
      showLikes: showLikes,
      physics: physics,
      shrinkWrap: shrinkWrap,
    );
  }
}
