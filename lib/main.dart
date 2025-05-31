import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_flutter/bloc/conversation_bloc.dart';
import 'package:chat_app_flutter/bloc/conversation_event.dart';
import 'package:chat_app_flutter/screens/conversations_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationBloc()..add(LoadConversations()),
      child: MaterialApp(
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ConversationsScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
