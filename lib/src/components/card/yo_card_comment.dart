// [file name]: yo_comment_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yo_ui/yo_ui.dart';

import '../yo_avatar.dart';

enum CommentCardVariant { default_, compact, detailed }

class YoCommentCard extends StatelessWidget {
  final String userName;
  final String? userAvatarUrl;
  final String comment;
  final DateTime timestamp;
  final int likes;
  final bool isLiked;
  final bool isVerified;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onLike;
  final VoidCallback? onReply;
  final VoidCallback? onUserTap;
  final List<YoCommentCard>? replies;
  final CommentCardVariant variant;
  final bool showActions;
  final int maxLines;

  const YoCommentCard({
    super.key,
    required this.userName,
    this.userAvatarUrl,
    required this.comment,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
    this.isVerified = false,
    this.onTap,
    this.onLongPress,
    this.onLike,
    this.onReply,
    this.onUserTap,
    this.replies,
    this.variant = CommentCardVariant.default_,
    this.showActions = true,
    this.maxLines = 10,
  });

  // Compact variant untuk list yang padat
  const YoCommentCard.compact({
    super.key,
    required this.userName,
    this.userAvatarUrl,
    required this.comment,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
    this.isVerified = false,
    this.onTap,
    this.onLongPress,
    this.onLike,
    this.onUserTap,
  }) : onReply = null,
       replies = null,
       variant = CommentCardVariant.compact,
       showActions = false,
       maxLines = 3;

  // Detailed variant dengan replies
  const YoCommentCard.detailed({
    super.key,
    required this.userName,
    this.userAvatarUrl,
    required this.comment,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
    this.isVerified = false,
    this.onTap,
    this.onLongPress,
    this.onLike,
    this.onReply,
    this.onUserTap,
    required this.replies,
    this.maxLines = 20,
  }) : variant = CommentCardVariant.detailed,
       showActions = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _getVerticalMargin(context)),
      decoration: BoxDecoration(
        color: _getCardColor(context),
        borderRadius: BorderRadius.circular(_getBorderRadius(context)),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
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
      case CommentCardVariant.default_:
        return _buildDefaultMobileContent(context);
      case CommentCardVariant.compact:
        return _buildCompactMobileContent(context);
      case CommentCardVariant.detailed:
        return _buildDetailedMobileContent(context);
    }
  }

  Widget _buildTabletContent(BuildContext context) {
    switch (variant) {
      case CommentCardVariant.default_:
        return _buildDefaultTabletContent(context);
      case CommentCardVariant.compact:
        return _buildCompactTabletContent(context);
      case CommentCardVariant.detailed:
        return _buildDetailedTabletContent(context);
    }
  }

  Widget _buildDesktopContent(BuildContext context) {
    switch (variant) {
      case CommentCardVariant.default_:
        return _buildDefaultDesktopContent(context);
      case CommentCardVariant.compact:
        return _buildCompactDesktopContent(context);
      case CommentCardVariant.detailed:
        return _buildDetailedDesktopContent(context);
    }
  }

  // ========== MOBILE LAYOUTS ==========

  Widget _buildDefaultMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header dengan user info
        _buildUserHeader(context),
        SizedBox(height: _getSpacing(context, base: 8)),

        // Comment text
        _buildCommentText(context),
        SizedBox(height: _getSpacing(context, base: 8)),

        // Footer dengan timestamp dan actions
        _buildFooter(context),
      ],
    );
  }

  Widget _buildCompactMobileContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar kecil
        _buildCompactAvatar(context),
        SizedBox(width: _getSpacing(context, base: 8)),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User name dan timestamp dalam satu baris
              _buildCompactHeader(context),
              SizedBox(height: _getSpacing(context, base: 2)),

              // Comment text
              _buildCommentText(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main comment
        _buildDefaultMobileContent(context),

        // Replies section
        if (replies != null && replies!.isNotEmpty) ...[
          SizedBox(height: _getSpacing(context, base: 12)),
          _buildRepliesSection(context),
        ],
      ],
    );
  }

  // ========== TABLET LAYOUTS ==========

  Widget _buildDefaultTabletContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        _buildAvatar(context),
        SizedBox(width: _getSpacing(context, base: 12)),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User header
              _buildUserHeader(context),
              SizedBox(height: _getSpacing(context, base: 8)),

              // Comment text
              _buildCommentText(context),
              SizedBox(height: _getSpacing(context, base: 8)),

              // Footer
              _buildFooter(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactTabletContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompactAvatar(context),
        SizedBox(width: _getSpacing(context, base: 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCompactHeader(context),
              SizedBox(height: _getSpacing(context, base: 4)),
              _buildCommentText(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedTabletContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(context),
        SizedBox(width: _getSpacing(context, base: 16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(context),
              SizedBox(height: _getSpacing(context, base: 12)),
              _buildCommentText(context),
              SizedBox(height: _getSpacing(context, base: 12)),
              _buildFooter(context),
              if (replies != null && replies!.isNotEmpty) ...[
                SizedBox(height: _getSpacing(context, base: 16)),
                _buildRepliesSection(context),
              ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(context),
        SizedBox(width: _getSpacing(context, base: 20)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(context),
              SizedBox(height: _getSpacing(context, base: 16)),
              _buildCommentText(context),
              SizedBox(height: _getSpacing(context, base: 16)),
              _buildFooter(context),
              if (replies != null && replies!.isNotEmpty) ...[
                SizedBox(height: _getSpacing(context, base: 20)),
                _buildRepliesSection(context),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ========== SHARED COMPONENTS ==========

  Widget _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: onUserTap,
      child: YoAvatar.image(
        imageUrl: userAvatarUrl,
        size: _getAvatarSize(context),
        variant: YoAvatarVariant.circle,
      ),
    );
  }

  Widget _buildCompactAvatar(BuildContext context) {
    return GestureDetector(
      onTap: onUserTap,
      child: YoAvatar.image(
        imageUrl: userAvatarUrl,
        size: _getCompactAvatarSize(context),
        variant: YoAvatarVariant.circle,
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    return Row(
      children: [
        // User name dengan verification badge
        Expanded(
          child: Row(
            children: [
              Text(
                userName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _getFontSize(context, base: 14),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (isVerified) ...[
                SizedBox(width: _getSpacing(context, base: 4)),
                Icon(
                  Icons.verified_rounded,
                  size: _getIconSize(context, base: 14),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ],
          ),
        ),

        // Timestamp
        Text(
          _formatTimestamp(timestamp, context),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontSize: _getFontSize(context, base: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          userName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: _getFontSize(context, base: 13),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (isVerified) ...[
          SizedBox(width: _getSpacing(context, base: 2)),
          Icon(
            Icons.verified_rounded,
            size: _getIconSize(context, base: 12),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
        SizedBox(width: _getSpacing(context, base: 4)),
        Text(
          '·',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
        ),
        SizedBox(width: _getSpacing(context, base: 4)),
        Expanded(
          child: Text(
            _formatTimestamp(timestamp, context),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: _getFontSize(context, base: 11),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCommentText(BuildContext context) {
    return Text(
      comment,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: _getFontSize(context, base: 14),
        height: 1.4,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(BuildContext context) {
    if (!showActions) return const SizedBox.shrink();

    return Row(
      children: [
        // Like button
        _buildLikeButton(context),
        SizedBox(width: _getSpacing(context, base: 16)),

        // Reply button
        _buildReplyButton(context),

        const Spacer(),

        // Additional actions bisa ditambahkan di sini
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context) {
    return GestureDetector(
      onTap: onLike,
      child: Row(
        children: [
          Icon(
            isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            size: _getIconSize(context, base: 16),
            color: isLiked
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          if (likes > 0) ...[
            SizedBox(width: _getSpacing(context, base: 4)),
            Text(
              _formatLikes(likes),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isLiked
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: _getFontSize(context, base: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReplyButton(BuildContext context) {
    return GestureDetector(
      onTap: onReply,
      child: Row(
        children: [
          Icon(
            Icons.reply_rounded,
            size: _getIconSize(context, base: 16),
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          SizedBox(width: _getSpacing(context, base: 4)),
          Text(
            'Reply',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: _getFontSize(context, base: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepliesSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: _getSpacing(context, base: 20)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.3),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          for (final reply in replies!)
            Padding(
              padding: EdgeInsets.only(bottom: _getSpacing(context, base: 8)),
              child: reply,
            ),
        ],
      ),
    );
  }

  // ========== RESPONSIVE HELPER METHODS ==========

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

  EdgeInsets _getPadding(BuildContext context) {
    final padding = context.responsiveValue(
      phone: 12.0,
      tablet: 16.0,
      desktop: 20.0,
    );

    return EdgeInsets.all(padding);
  }

  double _getVerticalMargin(BuildContext context) {
    return context.responsiveValue(phone: 4.0, tablet: 6.0, desktop: 8.0);
  }

  YoAvatarSize _getAvatarSize(BuildContext context) {
    return context.yoIsSmallScreen ? YoAvatarSize.sm : YoAvatarSize.md;
  }

  YoAvatarSize _getCompactAvatarSize(BuildContext context) {
    return context.yoIsSmallScreen ? YoAvatarSize.xs : YoAvatarSize.sm;
  }

  // ========== OTHER HELPER METHODS ==========

  Color _getCardColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  String _formatTimestamp(DateTime timestamp, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w';
    } else {
      return DateFormat('MMM dd, yyyy').format(timestamp);
    }
  }

  String _formatLikes(int likes) {
    if (likes < 1000) {
      return likes.toString();
    } else if (likes < 1000000) {
      return '${(likes / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(likes / 1000000).toStringAsFixed(1)}M';
    }
  }
}
