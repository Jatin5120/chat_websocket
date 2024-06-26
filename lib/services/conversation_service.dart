import 'package:chat_assignment/data/data.dart';
import 'package:chat_assignment/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class ConversationService {
  ConversationService(this._dbClient);

  final DbClient _dbClient;

  final Uuid _uuid = const Uuid();

  Future<String?> createConversation(String name) async {
    try {
      var conversation = ConversationModel(
        userId: _dbClient.getUserId(),
        conversationId: _uuid.v4(),
        conversationName: name,
      );

      await _dbClient.addConversation(conversation.conversationId!, conversation);
      return conversation.conversationId;
    } catch (e) {
      return null;
    }
  }

  List<ConversationModel> getAllConversations() {
    try {
      var conversations = _dbClient.getAllConversations(_dbClient.getUserId());
      return conversations;
    } catch (e) {
      return [];
    }
  }

  Future<ConversationModel?> getConversation(String conversationId) async {
    try {
      final localConversation = _dbClient.getConversation(conversationId);
      if (localConversation == null) {
        return null;
      }
      return localConversation;
    } catch (e) {
      return null;
    }
  }
}
