import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  static const String id = 'SignInID';
  // final Function toggleView;

  // SignIn({@required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String error = '';

  var _formKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.signInWithEmail(email, password);
      if (result == null)
        setState(() {
          error = 'Email or password is incorrect';
        });
      else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              authService: _auth,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign in to Chatapp"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: 'uitLogo',
                  child: Container(
                    child: Image.asset(
                      "assets/images/uit.png",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter your email', labelText: 'Email'),
                // validator: (val) => val.isEmpty ? 'Enter your email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter your password', labelText: 'Password'),
                validator: (val) => val.length < 6
                    ? 'Enter a password more than 5 characters'
                    : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20),
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
                  onPressed: loginUser,
                ),
              ),
              SizedBox(height: 10),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
