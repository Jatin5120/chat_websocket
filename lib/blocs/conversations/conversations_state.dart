part of 'conversations_bloc.dart';

abstract class ConversationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConversationsInitial extends ConversationsState {}

class ConversationsLoaded extends ConversationsState {
  ConversationsLoaded(this.conversations, {this.selectedConversationId});

  final List<ConversationModel> conversations;
  final String? selectedConversationId;

  @override
  List<Object?> get props => [conversations, selectedConversationId];
}

class ConversationCreated extends ConversationsState {
  ConversationCreated(this.conversation);

  final ConversationModel conversation;

  @override
  List<Object?> get props => [conversation];
}

class ConversationsError extends ConversationsState {
  ConversationsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
