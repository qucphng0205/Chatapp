import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print("THIS");
    print(user);
    print("THIS");
    if (user == null)
      return Home();
    else
      return ChatScreen();
  }
}