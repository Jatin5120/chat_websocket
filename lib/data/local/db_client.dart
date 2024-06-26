import 'dart:developer';

import 'package:chat_assignment/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DbClient {
  static const String _authBoxName = 'authBox';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';

  static const String _conversationsBoxName = 'conversationsBox';
  static const String _messagesBoxName = 'messagesBox';
  static const String _usersBoxName = 'usersBox';

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ConversationModelAdapter());
    Hive.registerAdapter(MessageModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    await Future.wait([
      Hive.openBox(_authBoxName),
      Hive.openBox<UserModel>(_usersBoxName),
      Hive.openBox<ConversationModel>(_conversationsBoxName),
      Hive.openBox<MessageModel>(_messagesBoxName),
    ]);
  }

  Box get _authBox => Hive.box(_authBoxName);

  Box<ConversationModel> get _conversationBox => Hive.box<ConversationModel>(_conversationsBoxName);

  Box<MessageModel> get _messageBox => Hive.box<MessageModel>(_messagesBoxName);

  Box<UserModel> get _usersBox => Hive.box<UserModel>(_usersBoxName);

  // -------------- Auth-related methods --------------

  bool getIsLoggedIn() => _authBox.get(_isLoggedInKey, defaultValue: false);

  Future<void> setIsLoggedIn(bool value) async {
    await _authBox.put(_isLoggedInKey, value);
  }

  String getUserId() => _authBox.get(_userIdKey, defaultValue: '');

  Future<void> setUserId(String userId) async {
    await _authBox.put(_userIdKey, userId);
  }

  // -------------- Conversation-related methods --------------

  Future<void> addConversation(String conversationId, ConversationModel conversationData) => _conversationBox.put(conversationId, conversationData);

  ConversationModel? getConversation(String conversationId) => _conversationBox.get(conversationId);

  List<ConversationModel> getAllConversations(String userId) => _conversationBox.values.where((e) => e.userId == userId).toList();

  //-------------- Message-related methods --------------

  Future<void> addMessage(String messageId, MessageModel messageData) => _messageBox.put(messageId, messageData);

  MessageModel? getMessage(String messageId) => _messageBox.get(messageId);

  List<MessageModel> getConversationMessages(String conversationId) =>
      _messageBox.values.where((message) => message.conversationId == conversationId).toList();

  //-------------- Message-related methods --------------

  Future<void> addUser(String userId, UserModel user) async {
    try {
      await _usersBox.put(userId, user);
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
    }
  }

  List<UserModel> getAllUsers() => _usersBox.values.toList();

  UserModel? getUser(String userId) => _usersBox.get(userId);

  Future<void> updateUser(String userId, UserModel user) async {
    await _usersBox.put(userId, user);
  }
}
