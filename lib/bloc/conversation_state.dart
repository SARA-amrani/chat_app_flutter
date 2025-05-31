import 'package:equatable/equatable.dart';
import '../models/conversation.dart';
import '../models/message.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Conversation> conversations;
  final List<Message> messages;

  const ConversationLoaded({
    required this.conversations,
    this.messages = const [],
  });

  ConversationLoaded copyWith({
    List<Conversation>? conversations,
    List<Message>? messages,
  }) {
    return ConversationLoaded(
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object> get props => [conversations, messages];
}

class ConversationError extends ConversationState {
  final String message;

  const ConversationError({required this.message});

  @override
  List<Object> get props => [message];
}