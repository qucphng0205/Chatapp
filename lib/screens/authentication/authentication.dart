import 'package:chatapp/screens/authentication/register.dart';
import 'package:chatapp/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  static const String id = 'AuthenticationID';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                onPressed: () {},
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
