import 'package:chatapp/screens/authentication/register.dart';
import 'package:chatapp/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Chatapp'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Login'),
            onPressed: () {},
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('Signup'),
          ),
        ],
      ),
    );
  }
}
