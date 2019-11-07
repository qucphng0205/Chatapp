import 'dart:io';

import 'package:chatapp/services/auth.dart';
import 'package:chatapp/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final AuthService authService;

  ChatScreen({this.authService});

  static const String id = 'ChatID';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Firestore _fireStore = Firestore.instance;

  Future<void> sendMessage() async {
    print(messageController.text.length);
    if (messageController.text.length > 0) {
      String sendText = messageController.text;
      messageController.clear();
      await _fireStore.collection('publicMessages').add({
        'content': sendText,
        'from': widget.authService.getEmail(),
        'date': DateTime.now().toIso8601String().toString(),
        'type': 0,
      });
    }

    setState(() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 400),
      );
    });
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  // @override
  // void didUpdateWidget(ChatScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   scrollController.animateTo(
  //     scrollController.position.maxScrollExtent,
  //     curve: Curves.easeOut,
  //     duration: const Duration(milliseconds: 400),
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    print("???");
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
              widget.authService.signOut();
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
                        myMessage:
                            widget.authService.getEmail() == doc.data['from']);
                  }).toList();
                  return ListView(
                      controller: scrollController,
                      children: <Widget>[
                        ...messages,
                      ]);
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    getImage();
                  },
                ),
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
