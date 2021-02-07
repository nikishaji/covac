import 'package:covac/challenges.dart';
import 'package:covac/covid_safety.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final Function resetC;

  Result(this.resultScore, this.resetHandler, this.resetC);

//Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 81) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 41) {
      resultText = 'Good work!';
      print(resultScore);
    } else {
      resultText = 'Lets give it an another shot!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          Text(
            'Score ' '$resultScore',
            style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          FlatButton(
            child: Text(
              'Restart Quiz!',
            ), //Text
            textColor: Colors.white,
            onPressed: resetHandler,
          ),

          FlatButton(
            child: Text(
              'Collect Your Badge and Go back to Covid Info!',
            ), //Text
            textColor: Colors.white,
            onPressed: resetC,
          ),
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
