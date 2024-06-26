import 'dart:convert';

import 'package:chat_assignment/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ConversationModel {
  const ConversationModel({
    required this.userId,
    this.conversationId,
    this.conversationName,
    this.lastMessage,
    this.messages = const [],
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) => ConversationModel(
        userId: map['userId'] as String,
        conversationId: map['conversationId'] as String?,
        conversationName: map['conversationName'] as String?,
        lastMessage: map['lastMessage'] != null ? MessageModel.fromMap(map['lastMessage'] as Map<String, dynamic>) : null,
        messages: (map['messages'] as List? ?? []).map((x) => MessageModel.fromMap(x as Map<String, dynamic>)).toList(),
      );

  factory ConversationModel.fromJson(
    String source,
  ) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String? conversationId;

  @HiveField(2)
  final String? conversationName;

  @HiveField(3)
  final MessageModel? lastMessage;

  @HiveField(4)
  final List<MessageModel> messages;

  ConversationModel copyWith({
    String? userId,
    String? conversationId,
    String? conversationName,
    MessageModel? lastMessage,
    List<MessageModel>? messages,
  }) =>
      ConversationModel(
        userId: userId ?? this.userId,
        conversationId: conversationId ?? this.conversationId,
        conversationName: conversationName ?? this.conversationName,
        lastMessage: lastMessage ?? this.lastMessage,
        messages: messages ?? this.messages,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': userId,
        'conversationId': conversationId,
        'conversationName': conversationName,
        'lastMessage': lastMessage?.toMap(),
        'messages': messages.map((x) => x.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ConversationModel(userId: $userId, conversationId: $conversationId, conversationName: $conversationName, lastMessage: $lastMessage, messages: $messages)';

  @override
  bool operator ==(covariant ConversationModel other) {
    if (identical(this, other)) return true;

    return userId == other.userId && conversationId == other.conversationId;
  }

  @override
  int get hashCode => userId.hashCode ^ conversationId.hashCode;
}
