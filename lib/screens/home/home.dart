import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/auth.dart';

class Home extends StatefulWidget {
  static const String id = 'HOMEID';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Chatapp'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
