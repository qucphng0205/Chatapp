import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String content;

  final bool myMessage;

  Message(
      {@required this.from, @required this.content, @required this.myMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment:
          myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(from),
        Material(
          color: myMessage ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          elevation: 6.0,
          child: Container(
            child: Text(content),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
          ),
        ),
      ],
    ));
  }
}
