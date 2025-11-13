// File: yo_chat_bubble.dart
import 'package:flutter/material.dart';

import '../../../yo_ui.dart';

class YoChatMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isSentByMe;
  final String? senderAvatar;
  final String? senderName;
  final MessageStatus status;
  final MessageType type;
  final String? attachmentUrl;
  final String? attachmentType;

  const YoChatMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isSentByMe,
    this.senderAvatar,
    this.senderName,
    this.status = MessageStatus.sent,
    this.type = MessageType.text,
    this.attachmentUrl,
    this.attachmentType,
  });
}

enum MessageStatus { sending, sent, delivered, read, failed }

enum MessageType { text, image, file, system }

class YoChatBubble extends StatelessWidget {
  final YoChatMessage message;
  final Function(YoChatMessage)? onTap;
  final Function(YoChatMessage)? onLongPress;
  final Function(YoChatMessage)? onReply;
  final bool showAvatar;
  final bool showTimestamp;
  final bool showStatus;
  final Color? sentColor;
  final Color? receivedColor;

  const YoChatBubble({
    super.key,
    required this.message,
    this.onTap,
    this.onLongPress,
    this.onReply,
    this.showAvatar = true,
    this.showTimestamp = true,
    this.showStatus = true,
    this.sentColor,
    this.receivedColor,
  });

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.system) {
      return _buildSystemMessage(context);
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.yoSpacingMd,
        vertical: context.yoSpacingXs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: message.isSentByMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isSentByMe && showAvatar && message.senderAvatar != null)
            Padding(
              padding: EdgeInsets.only(right: context.yoSpacingSm),
              child: YoAvatar.image(
                imageUrl: message.senderAvatar!,
                size: YoAvatarSize.sm,
              ),
            ),

          Flexible(
            child: Column(
              crossAxisAlignment: message.isSentByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Sender name (for group chats)
                if (!message.isSentByMe && message.senderName != null)
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.yoSpacingSm,
                      bottom: 2,
                    ),
                    child: YoText.bodySmall(
                      message.senderName!,
                      color: context.gray500,
                    ),
                  ),

                // Message bubble
                GestureDetector(
                  onTap: () => onTap?.call(message),
                  onLongPress: () => onLongPress?.call(message),
                  child: Container(
                    padding: EdgeInsets.all(context.yoSpacingMd),
                    decoration: BoxDecoration(
                      color: message.isSentByMe
                          ? (sentColor ?? context.primaryColor)
                          : (receivedColor ?? context.gray100),
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomLeft: message.isSentByMe
                            ? Radius.circular(16)
                            : Radius.circular(4),
                        bottomRight: message.isSentByMe
                            ? Radius.circular(4)
                            : Radius.circular(16),
                      ),
                    ),
                    child: _buildMessageContent(context),
                  ),
                ),

                // Timestamp and status
                if (showTimestamp || (showStatus && message.isSentByMe))
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: message.isSentByMe ? 0 : context.yoSpacingSm,
                      right: message.isSentByMe ? context.yoSpacingSm : 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showTimestamp)
                          YoText.bodySmall(
                            _formatTime(message.timestamp),
                            color: context.gray400,
                          ),
                        if (showTimestamp && showStatus && message.isSentByMe)
                          SizedBox(width: 4),
                        if (showStatus && message.isSentByMe)
                          _buildStatusIcon(context),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          if (message.isSentByMe && showAvatar && message.senderAvatar != null)
            Padding(
              padding: EdgeInsets.only(left: context.yoSpacingSm),
              child: YoAvatar.image(
                imageUrl: message.senderAvatar!,
                size: YoAvatarSize.sm,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return YoText.bodyMedium(
          message.text,
          color: message.isSentByMe
              ? context.onPrimaryColor
              : context.textColor,
        );

      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                message.attachmentUrl!,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 150,
                    color: context.gray200,
                    child: Icon(Icons.broken_image, color: context.gray400),
                  );
                },
              ),
            ),
            if (message.text.isNotEmpty) ...[
              SizedBox(height: context.yoSpacingSm),
              YoText.bodyMedium(
                message.text,
                color: message.isSentByMe
                    ? context.onPrimaryColor
                    : context.textColor,
              ),
            ],
          ],
        );

      case MessageType.file:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getFileIcon(message.attachmentType),
              color: message.isSentByMe
                  ? context.onPrimaryColor
                  : context.primaryColor,
            ),
            SizedBox(width: context.yoSpacingSm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoText.bodyMedium(
                    message.text,
                    color: message.isSentByMe
                        ? context.onPrimaryColor
                        : context.textColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (message.attachmentType != null)
                    YoText.bodySmall(
                      message.attachmentType!.toUpperCase(),
                      color: message.isSentByMe
                          ? context.onPrimaryColor.withOpacity(0.8)
                          : context.gray500,
                    ),
                ],
              ),
            ),
          ],
        );

      default:
        return YoText.bodyMedium(message.text);
    }
  }

  Widget _buildSystemMessage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.yoSpacingMd,
        vertical: context.yoSpacingSm,
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.yoSpacingMd,
            vertical: context.yoSpacingSm,
          ),
          decoration: BoxDecoration(
            color: context.gray100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: YoText.bodySmall(
            message.text,
            color: context.gray600,
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    IconData icon;
    Color color;

    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        color = context.gray400;
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        color = context.gray400;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = context.gray400;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = context.primaryColor;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = context.errorColor;
        break;
    }

    return Icon(icon, size: 12, color: color);
  }

  IconData _getFileIcon(String? fileType) {
    if (fileType == null) return Icons.insert_drive_file;

    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'zip':
      case 'rar':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

class YoChatList extends StatelessWidget {
  final List<YoChatMessage> messages;
  final ScrollController? scrollController;
  final Function(YoChatMessage)? onMessageTap;
  final Function(YoChatMessage)? onMessageLongPress;
  final bool showAvatars;
  final bool showTimestamps;
  final bool showStatus;
  final Color? sentColor;
  final Color? receivedColor;
  final Widget? loadingWidget;
  final bool isLoading;

  const YoChatList({
    super.key,
    required this.messages,
    this.scrollController,
    this.onMessageTap,
    this.onMessageLongPress,
    this.showAvatars = true,
    this.showTimestamps = true,
    this.showStatus = true,
    this.sentColor,
    this.receivedColor,
    this.loadingWidget,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            reverse: true,
            padding: EdgeInsets.all(context.yoSpacingSm),
            itemCount: messages.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (isLoading && index == 0) {
                return loadingWidget ?? _buildLoadingWidget(context);
              }

              final messageIndex = isLoading ? index - 1 : index;
              final message = messages[messageIndex];

              return YoChatBubble(
                message: message,
                onTap: onMessageTap,
                onLongPress: onMessageLongPress,
                showAvatar: showAvatars,
                showTimestamp: showTimestamps,
                showStatus: showStatus,
                sentColor: sentColor,
                receivedColor: receivedColor,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.yoSpacingMd),
      child: Center(child: YoProgress.circular(size: YoProgressSize.small)),
    );
  }
}
