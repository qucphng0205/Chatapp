import 'package:chatapp/screens/authentication/register.dart';
import 'package:chatapp/screens/authentication/sign_in.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String id = 'HomeID';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'uitLogo',
                child: Container(
                  width: 100.0,
                  child: Image.asset('assets/images/uit.png'),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'UIT Chatapp',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          ButtonTheme(
            minWidth: 200.0,
            height: 55.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                FirebaseUser user = Provider.of<FirebaseUser>(context);
                if (user != null) {
                  AuthService _auth = AuthService();
                  _auth.setupUser(user);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        authService: _auth,
                      ),
                    ),
                  );
                } else 
                Navigator.of(context).pushNamed(SignIn.id);
              },
            ),
          ),
          SizedBox(height: 20),
          ButtonTheme(
            minWidth: 200.0,
            height: 55.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                'Signup',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Register.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
