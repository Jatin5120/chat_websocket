import 'dart:convert';

import 'package:chat_assignment/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class MessageModel {
  const MessageModel({
    required this.conversationId,
    this.messageId,
    required this.body,
    this.sentAt,
    this.sendByMe = true,
    this.messageType = MessageType.text,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        conversationId: map['conversationId'] as String,
        messageId: map['messageId'] as String?,
        body: map['body'] as String,
        sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt'] as int),
        messageType: MessageType.fromName(map['messageType'] as String? ?? ''),
        sendByMe: map['sendByMe'] as bool? ?? true,
      );

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @HiveField(0)
  final String conversationId;

  @HiveField(1)
  final String? messageId;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final DateTime? sentAt;

  @HiveField(4)
  final bool sendByMe;

  @HiveField(5)
  final MessageType messageType;

  String get senderName => sendByMe ? 'You' : 'Server';

  MessageModel copyWith({
    String? conversationId,
    String? messageId,
    String? body,
    DateTime? sentAt,
    bool? sendByMe,
    MessageType? messageType,
  }) =>
      MessageModel(
        conversationId: conversationId ?? this.conversationId,
        messageId: messageId ?? this.messageId,
        body: body ?? this.body,
        sentAt: sentAt ?? this.sentAt,
        sendByMe: sendByMe ?? this.sendByMe,
        messageType: messageType ?? this.messageType,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'conversationId': conversationId,
        'messageId': messageId,
        'body': body,
        'sentAt': sentAt?.millisecondsSinceEpoch,
        'sendByMe': sendByMe,
        'messageType': messageType.name,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'MessageModel(conversationId: $conversationId, messageId: $messageId, body: $body, sentAt: $sentAt, sendByMe: $sendByMe, messageType: $messageType)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.conversationId == conversationId && other.messageId == messageId;
  }

  @override
  int get hashCode => conversationId.hashCode ^ messageId.hashCode;
}
