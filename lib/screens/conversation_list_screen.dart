import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/conversation_bloc.dart';
import '../bloc/conversation_event.dart';
import '../bloc/conversation_state.dart';
import '../widgets/conversation_tile.dart';
import 'chat_detail_screen.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          if (state is ConversationInitial) {
            context.read<ConversationBloc>().add(LoadConversations());
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is ConversationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is ConversationError) {
            return Center(
              child: Text(
                'Erreur: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          
          if (state is ConversationLoaded) {
            return ListView.builder(
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                final conversation = state.conversations[index];
                return ConversationTile(
                  conversation: conversation,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailScreen(
                          conversation: conversation,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          
          return const Center(child: Text('État inconnu'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fonctionnalité pour créer une nouvelle conversation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nouvelle conversation à implémenter')),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}