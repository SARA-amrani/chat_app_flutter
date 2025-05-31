import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/bloc/conversation_event.dart';
import 'package:chat_app_flutter/bloc/conversation_state.dart';
import 'package:chat_app_flutter/models/conversation.dart';
import 'package:chat_app_flutter/models/message.dart';
import 'package:chat_app_flutter/data/mock_data.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  List<Conversation> _conversations = [];
  List<Message> _messages = [];

  ConversationBloc() : super(ConversationInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<LoadMessages>(_onLoadMessages);
    on<CreateConversation>(_onCreateConversation);
  }

  void _onLoadConversations(LoadConversations event, Emitter<ConversationState> emit) {
    try {
      emit(ConversationLoading());
      _conversations = MockData.mockConversations;
      _messages = MockData.mockMessages;
      emit(ConversationLoaded(
        conversations: _conversations,
        messages: _messages,
      ));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  void _onSendMessage(SendMessage event, Emitter<ConversationState> emit) {
    try {
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: event.conversationId,
        content: event.content,
        isMe: true,
        timestamp: DateTime.now(),
      );

      _messages = [..._messages, newMessage];

      // Update last message in conversation
      _conversations = _conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return Conversation(
            id: conv.id,
            contactName: conv.contactName,
            lastMessage: event.content,
            timestamp: DateTime.now(),
            unreadCount: conv.unreadCount,
            isOnline: conv.isOnline,
          );
        }
        return conv;
      }).toList();

      emit(ConversationLoaded(
        conversations: _conversations,
        messages: _messages,
        selectedConversationId: event.conversationId,
      ));

      // Simulate receiving a response after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        add(ReceiveMessage(
          conversationId: event.conversationId,
          content: "Merci pour votre message !",
        ));
      });
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  void _onReceiveMessage(ReceiveMessage event, Emitter<ConversationState> emit) {
    try {
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: event.conversationId,
        content: event.content,
        isMe: false,
        timestamp: DateTime.now(),
      );

      _messages = [..._messages, newMessage];

      // Update conversation with new message and increment unread count
      _conversations = _conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return Conversation(
            id: conv.id,
            contactName: conv.contactName,
            lastMessage: event.content,
            timestamp: DateTime.now(),
            unreadCount: conv.unreadCount + 1,
            isOnline: conv.isOnline,
          );
        }
        return conv;
      }).toList();

      emit(ConversationLoaded(
        conversations: _conversations,
        messages: _messages,
        selectedConversationId: event.conversationId,
      ));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  void _onLoadMessages(LoadMessages event, Emitter<ConversationState> emit) {
    try {
      // Mark messages as read by resetting unread count
      _conversations = _conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return Conversation(
            id: conv.id,
            contactName: conv.contactName,
            lastMessage: conv.lastMessage,
            timestamp: conv.timestamp,
            unreadCount: 0,
            isOnline: conv.isOnline,
          );
        }
        return conv;
      }).toList();

      emit(ConversationLoaded(
        conversations: _conversations,
        messages: _messages,
        selectedConversationId: event.conversationId,
      ));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  void _onCreateConversation(CreateConversation event, Emitter<ConversationState> emit) {
    try {
      final newConversation = Conversation(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        contactName: event.contactName,
        lastMessage: "Nouvelle conversation",
        timestamp: DateTime.now(),
        unreadCount: 0,
        isOnline: true,
      );

      _conversations = [newConversation, ..._conversations];

      emit(ConversationLoaded(
        conversations: _conversations,
        messages: _messages,
      ));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }
}