part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  ChatLoaded(this.messages);

  final List<MessageModel> messages;

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  ChatError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
