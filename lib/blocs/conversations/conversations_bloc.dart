import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

@lazySingleton
class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc({required this.conversationService}) : super(ConversationsInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<CreateConversation>(_onCreateConversation);
    on<SelectConversation>(_onSelectConversation);
    on<UnselectConversation>(_onUnselectConversation);
    on<ResetConversations>(_onResetConversations);
  }

  final ConversationService conversationService;

  void _onLoadConversations(LoadConversations event, Emitter<ConversationsState> emit) {
    try {
      final conversations = conversationService.getAllConversations();
      emit(ConversationsLoaded(conversations));
    } catch (e) {
      emit(ConversationsLoaded(const []));
    }
  }

  void _onCreateConversation(CreateConversation event, Emitter<ConversationsState> emit) async {
    try {
      final conversationId = await conversationService.createConversation(event.conversationName);
      if (conversationId != null) {
        final conversations = conversationService.getAllConversations();
        emit(ConversationsLoaded(
          conversations,
          selectedConversationId: conversationId,
        ));
      }
    } catch (e) {
      // Handle error state if needed
    }
  }

  void _onSelectConversation(SelectConversation event, Emitter<ConversationsState> emit) {
    if (state is ConversationsLoaded) {
      final currentState = state as ConversationsLoaded;
      emit(ConversationsLoaded(
        currentState.conversations,
        selectedConversationId: event.conversationId,
      ));
    }
  }

  void _onUnselectConversation(UnselectConversation event, Emitter<ConversationsState> emit) {
    if (state is ConversationsLoaded) {
      final currentState = state as ConversationsLoaded;
      emit(ConversationsLoaded(currentState.conversations));
    }
  }

  void _onResetConversations(ResetConversations event, Emitter<ConversationsState> emit) {
    debugPrint('resetting');
    emit(ConversationsInitial());
  }
}
