part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMessages extends ChatEvent {
  LoadMessages(this.conversationId);

  final String conversationId;

  @override
  List<Object?> get props => [conversationId];
}

class SendMessage extends ChatEvent {
  SendMessage({
    required this.conversationId,
    required this.body,
    this.onSend,
  });

  final String conversationId;
  final String body;
  final void Function(MessageModel)? onSend;

  @override
  List<Object?> get props => [conversationId, body];
}

class ReceiveMessage extends ChatEvent {
  ReceiveMessage(this.message);

  final MessageModel message;

  @override
  List<Object?> get props => [message];
}
