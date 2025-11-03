import 'package:flutter/material.dart';


class MyText extends StatefulWidget {
  MyText({super.key, required text});

  @override
  State<MyText> createState() => _MyTextState(text: text);

  String text = "";

  void setText(String newText) {

    text = newText;
  }
}


class _MyTextState extends State<MyText> {

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }

  String text = "";
  _MyTextState({required text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
