import 'package:equatable/equatable.dart';
import '../models/message.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class LoadConversations extends ConversationEvent {}

class SendMessage extends ConversationEvent {
  final String conversationId;
  final String content;

  const SendMessage({
    required this.conversationId,
    required this.content,
  });

  @override
  List<Object> get props => [conversationId, content];
}

class ReceiveMessage extends ConversationEvent {
  final Message message;

  const ReceiveMessage({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadMessages extends ConversationEvent {
  final String conversationId;

  const LoadMessages({required this.conversationId});

  @override
  List<Object> get props => [conversationId];
}