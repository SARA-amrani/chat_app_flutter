import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/mock_data.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<LoadMessages>(_onLoadMessages);
  }

  void _onLoadConversations(
    LoadConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationLoading());
    try {
      // Simuler un délai de chargement
      await Future.delayed(const Duration(seconds: 1));
      emit(ConversationLoaded(conversations: MockData.mockConversations));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  void _onLoadMessages(
    LoadMessages event,
    Emitter<ConversationState> emit,
  ) async {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      final messages = MockData.mockMessages
          .where((message) => message.conversationId == event.conversationId)
          .toList();
      
      emit(currentState.copyWith(messages: messages));
    }
  }

  void _onSendMessage(
    SendMessage event,
    Emitter<ConversationState> emit,
  ) async {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      
      // Créer le nouveau message
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: event.conversationId,
        content: event.content,
        isMe: true,
        timestamp: DateTime.now(),
      );

      // Ajouter le message à la liste
      final updatedMessages = [...currentState.messages, newMessage];
      
      // Mettre à jour la conversation
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(
            lastMessage: event.content,
            timestamp: DateTime.now(),
          );
        }
        return conv;
      }).toList();

      emit(currentState.copyWith(
        conversations: updatedConversations,
        messages: updatedMessages,
      ));

      // Simuler une réponse automatique après 2 secondes
      await Future.delayed(const Duration(seconds: 2));
      add(ReceiveMessage(message: Message(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        conversationId: event.conversationId,
        content: 'Message reçu automatiquement !',
        isMe: false,
        timestamp: DateTime.now(),
      )));
    }
  }

  void _onReceiveMessage(
    ReceiveMessage event,
    Emitter<ConversationState> emit,
  ) {
    if (state is ConversationLoaded) {
      final currentState = state as ConversationLoaded;
      final updatedMessages = [...currentState.messages, event.message];
      
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.message.conversationId) {
          return conv.copyWith(
            lastMessage: event.message.content,
            timestamp: event.message.timestamp,
            unreadCount: conv.unreadCount + 1,
          );
        }
        return conv;
      }).toList();

      emit(currentState.copyWith(
        conversations: updatedConversations,
        messages: updatedMessages,
      ));
    }
  }
}