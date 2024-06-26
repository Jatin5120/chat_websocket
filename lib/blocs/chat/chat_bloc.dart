import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/services/message_service.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@lazySingleton
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required MessageService messageService})
      : _messageService = messageService,
        super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onMessageReceived);
  }

  final MessageService _messageService;

  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) {
    try {
      var messages = _messageService.getConversationMessages(event.conversationId);
      messages.sort((a, b) => (a.sentAt ?? DateTime.now()).compareTo(b.sentAt ?? DateTime.now()));

      // Create a new list to hold messages along with date headers
      var messagesWithDates = <MessageModel>[];

      DateTime? lastDate;

      for (var message in messages) {
        var messageDate = message.sentAt ?? DateTime.now();
        var currentDate = DateTime(messageDate.year, messageDate.month, messageDate.day);

        if (lastDate == null || lastDate != currentDate) {
          messagesWithDates.add(
            MessageModel(
              conversationId: message.conversationId,
              body: currentDate.messageDate(),
              sentAt: currentDate,
              sendByMe: false,
              messageType: MessageType.date,
            ),
          );
          lastDate = currentDate;
        }

        messagesWithDates.add(message);
      }
      emit(ChatLoaded(messagesWithDates));
    } catch (e) {
      emit(ChatLoaded(const []));
    }
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      final message = await _messageService.sendMessage(
        conversationId: event.conversationId,
        body: event.body,
        sendByMe: true,
      );
      if (message != null) {
        final currentState = state;
        event.onSend?.call(message);
        if (currentState is ChatLoaded) {
          final updatedMessages = [...currentState.messages, message];
          emit(ChatLoaded(updatedMessages));
        } else {
          emit(ChatLoaded([message]));
        }
      } else {
        emit(ChatError('Failed to send message'));
      }
    } on AppException catch (e) {
      emit(ChatError(e.message));
    }
  }

  void _onMessageReceived(ReceiveMessage event, Emitter<ChatState> emit) {
    final currentState = state;
    if (currentState is ChatLoaded) {
      _messageService.addMessage(event.message);
      final updatedMessages = [...currentState.messages, event.message];
      emit(ChatLoaded(updatedMessages));
    } else {
      emit(ChatLoaded([event.message]));
    }
  }
}
