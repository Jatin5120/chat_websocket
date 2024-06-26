import 'dart:math';

import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
    this.message, {
    super.key,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    if (message.messageType == MessageType.date) {
      return DateMessage(message);
    }
    return TextMessage(message);
  }
}

class DateMessage extends StatelessWidget {
  const DateMessage(this.message, {super.key});

  final MessageModel message;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Text(
              message.body,
              style: context.textTheme.labelMedium,
            ),
          ),
        ),
      );
}

class TextMessage extends StatelessWidget {
  const TextMessage(this.message, {super.key});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: message.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: UnconstrainedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: message.sendByMe ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(12).copyWith(
              bottomRight: Radius.circular(message.sendByMe ? 0 : 12),
              bottomLeft: Radius.circular(message.sendByMe ? 12 : 0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: message.sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 24,
                    maxWidth: min(400, size.width * 0.7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      message.body,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: message.sendByMe ? AppColors.white : AppColors.black,
                      ),
                      softWrap: true,
                      maxLines: null,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    message.sentAt!.formatTime,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: message.sendByMe ? AppColors.white : AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
