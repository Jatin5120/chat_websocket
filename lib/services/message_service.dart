import 'dart:async';

import 'package:chat_assignment/data/data.dart';
import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class MessageService {
  MessageService(this._dbClient);

  final DbClient _dbClient;

  final Uuid _uuid = const Uuid();

  List<MessageModel> getConversationMessages(String conversationId) {
    try {
      return _dbClient.getConversationMessages(conversationId);
    } catch (e) {
      return [];
    }
  }

  Future<MessageModel?> sendMessage({
    required String conversationId,
    required String body,
    required bool sendByMe,
    DateTime? sentAt,
  }) async {
    try {
      var message = MessageModel(
        messageId: _uuid.v4(),
        conversationId: conversationId,
        body: body,
        sendByMe: sendByMe,
        sentAt: sentAt ?? DateTime.now(),
      );

      await addMessage(message);

      return message;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<void> addMessage(MessageModel message) => _dbClient.addMessage(message.messageId!, message);
}
