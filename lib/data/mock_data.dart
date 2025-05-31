import 'package:chat_app_flutter/models/conversation.dart';
import 'package:chat_app_flutter/models/message.dart';

class MockData {
  static final List<Conversation> mockConversations = [
    Conversation(
      id: '1',
    contactName: 'SARA EL AMRANI',
      lastMessage: 'Salut ! Comment ça va ?',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      unreadCount: 0,
      isOnline: true,
    ),
    Conversation(
      id: '2',
      contactName: 'AYA EL AMRANI',
      lastMessage: 'On se voit demain ?',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      unreadCount: 0,
      isOnline: false,
    ),
    Conversation(
      id: '3',
      contactName: 'MOM',
      lastMessage: 'J\'ai terminé le projet !',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      unreadCount: 1,
      isOnline: false,
    ),
    Conversation(
      id: '4',
      contactName: 'HOUDA EL AMRANI',
      lastMessage: 'Merci pour ton aide',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
    ),
    Conversation(
      id: '5',
      contactName: 'DAD',
      lastMessage: 'À bientôt !',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      unreadCount: 3,
      isOnline: false,
    ),
  ];

  static final List<Message> mockMessages = [
    Message(
      id: '1',
      conversationId: '1',
      content: 'Salut ! Comment ça va ?',
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 10)),
    ),
    Message(
      id: '2',
      conversationId: '1',
      content: 'Tu es libre ce weekend ?',
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 8)),
    ),
    Message(
      id: '3',
      conversationId: '1',
      content: 'Salut ! Ça va très bien, merci.',
      isMe: true,
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    Message(
      id: '4',
      conversationId: '2',
      content: 'On se voit demain ?',
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
    ),
    Message(
      id: '5',
      conversationId: '3',
      content: 'J\'ai terminé le projet !',
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
    ),
    Message(
      id: '6',
      conversationId: '4',
      content: 'Merci pour ton aide',
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
    Message(
      id: '7',
      conversationId: '5',
      content: 'À bientôt !',
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
}