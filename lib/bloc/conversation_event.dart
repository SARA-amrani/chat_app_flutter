import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object?> get props => [];
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
  List<Object?> get props => [conversationId, content];
}

class ReceiveMessage extends ConversationEvent {
  final String conversationId;
  final String content;

  const ReceiveMessage({
    required this.conversationId,
    required this.content,
  });

  @override
  List<Object?> get props => [conversationId, content];
}

class LoadMessages extends ConversationEvent {
  final String conversationId;

  const LoadMessages({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class CreateConversation extends ConversationEvent {
  final String contactName;

  const CreateConversation({required this.contactName});

  @override
  List<Object?> get props => [contactName];
}
