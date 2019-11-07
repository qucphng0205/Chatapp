import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static const String id = 'RegisterID';

  // final Function toggleView;

  Register();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String error = '';

  var _formKey = GlobalKey<FormState>();

  Future<void> signupUser() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.registerWithEmail(email, password);
      if (result == null)
        setState(() => error = 'Email is invalid or already used');
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
        title: Text("Register to Chatapp"),
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
              SizedBox(height: 10),
              TextFormField(
                // validator: (val) => val.isEmpty ? 'Enter your email' : null,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (val) => val.length < 6
                    ? 'Enter a password more than 5 characters'
                    : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
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
                    'Signup',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: signupUser,
                ),
              ),
              SizedBox(height: 13),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
