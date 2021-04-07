import 'dart:ui';
import 'package:AYT_Attendence/Screens/chat2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;
  final String img;

  const CustomDialogBox({Key key, this.title, this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 300,
            child: Image.network(
              widget.img,
              height: 150.0,
              width: 150.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 50,
            width: 300,
            color: Colors.blue[1000],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title, textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.orange),),
            ),
          ),
        ],
      ),
    );
  }
}