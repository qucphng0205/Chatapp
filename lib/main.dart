import 'package:chatapp/screens/authentication/register.dart';
import 'package:chatapp/screens/authentication/sign_in.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/home/home.dart';
import 'package:chatapp/screens/wrapper.dart';
import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        initialRoute: Home.id,
        routes: {
          Home.id: (context) => Home(),
          Register.id: (context) => Register(),
          SignIn.id: (context) => SignIn(),
          ChatScreen.id: (context) => ChatScreen(),
        },
      ),
    );
  }
}
