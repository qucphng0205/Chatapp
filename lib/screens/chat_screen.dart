import 'package:chatapp/services/auth.dart';
import 'package:chatapp/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatID';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthService _auth = AuthService();
  final Firestore _fireStore = Firestore.instance;

  Future<void> sendMessage() async {
    print(messageController.text.length);
    if (messageController.text.length > 0) {
      await _fireStore.collection('message').add({
        'content': messageController.text,
        'from': _auth.getEmail(),
        'date': DateTime.now().toIso8601String().toString(),
      });
    }
    messageController.clear();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
    );
    setState(() {});
  }

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'uitLogo',
          child: Container(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/uit.png",
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
        title: Text('Public Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('publicMessages')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  List<Widget> messages = docs.map((doc) {
                    return Message(
                        from: doc.data['from'],
                        content: doc.data['content'],
                        myMessage: _auth.getEmail() == doc.data['from']);
                  }).toList();
                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: 'Text your words'),
                  ),
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () => sendMessage(),
                  child: Text('Send'),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
