import 'package:AYT_Attendence/Screens/chat2/Login.dart';
import 'package:AYT_Attendence/Screens/chat2/Registration.dart';
import 'package:flutter/material.dart';

class Authenticate2 extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate2> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView);
    } else {
      return Registration(toggleView);
    }
  }
}
