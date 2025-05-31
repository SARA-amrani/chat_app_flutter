import '../models/conversation.dart';
import '../models/message.dart';

class MockData {
  static List<Conversation> mockConversations = [
    Conversation(
      id: '1',
      contactName: 'Alice Martin',
      lastMessage: 'Salut ! Comment ça va ?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      unreadCount: 2,
    ),
    Conversation(
      id: '2',
      contactName: 'Bob Dupont',
      lastMessage: 'On se voit demain ?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 0,
    ),
    Conversation(
      id: '3',
      contactName: 'Claire Rousseau',
      lastMessage: 'Merci pour ton aide !',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      unreadCount: 1,
    ),
  ];

  static List<Message> mockMessages = [
    // Messages pour conversation 1 (Alice)
    Message(
      id: '1',
      conversationId: '1',
      content: 'Salut Alice !',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Message(
      id: '2',
      conversationId: '1',
      content: 'Salut ! Comment ça va ?',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    
    // Messages pour conversation 2 (Bob)
    Message(
      id: '3',
      conversationId: '2',
      content: 'On se voit demain ?',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Message(
      id: '4',
      conversationId: '2',
      content: 'Oui, à quelle heure ?',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
    ),
  ];
}