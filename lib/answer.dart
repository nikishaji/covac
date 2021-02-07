import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      child: RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Text(answerText),
        onPressed: selectHandler,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ), //RaisedButton
    ); //Container
  }
}
