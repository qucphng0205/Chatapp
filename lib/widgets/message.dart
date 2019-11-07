import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String content;
  final int type;

  final bool myMessage;

  Message(
      {@required this.from,
      @required this.content,
      @required this.myMessage,
      this.type = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment:
          myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(from),
        type == 0
            ? Material(
                color: myMessage ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
                elevation: 6.0,
                child: Container(
                  child: Text(content),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                ),
              )
            : Material(
                child: CachedNetworkImage(
                  imageUrl: content,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(10),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Image.asset(
                      'assets/images/uit.png',
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                  ),
                ),
              ),
      ],
    ));
  }
}
