part of 'conversations_bloc.dart';

abstract class ConversationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadConversations extends ConversationsEvent {}

class CreateConversation extends ConversationsEvent {
  CreateConversation(this.conversationName);

  final String conversationName;

  @override
  List<Object?> get props => [conversationName];
}

class SelectConversation extends ConversationsEvent {
  SelectConversation(this.conversationId);

  final String conversationId;

  @override
  List<Object?> get props => [conversationId];
}

class UnselectConversation extends ConversationsEvent {
  UnselectConversation();

  @override
  List<Object?> get props => [];
}

class ResetConversations extends ConversationsEvent {
  @override
  List<Object?> get props => [];
}
