import 'package:chatapp/models/user.dart';
import 'package:chatapp/screens/authentication/authentication.dart';
import 'package:chatapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print("THIS");
    print(user);
    print("THIS");
    if (user == null)
      return Authentication();
    else
      return Home();
  }
}