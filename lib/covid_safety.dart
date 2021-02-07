import 'package:covac/quiz.dart';
import 'citizen.dart';
import 'package:flutter/material.dart';

Citizen _citizen1;
void run(BuildContext context) {
  Navigator.pushNamed(context, CovidQuiz.routename, arguments: _citizen1);
}

class Covid_Safety extends StatelessWidget {
  static const routename = '/covidsafety';
  Citizen _citizen;
  Covid_Safety(this._citizen) {
    _citizen1 = _citizen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Saftey Information'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Image(image: AssetImage('assets/images/3.png')),
      Image(image: AssetImage('assets/images/2.png')),
      Image(image: AssetImage('assets/images/4.png')),
      Image(image: AssetImage('assets/images/5.png')),
      SizedBox(
        height: 20.0,
      ),
      RaisedButton(
        onPressed: () {
          run(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(
          'Ready to take the quiz',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        color: Colors.white,
      ),
    ]);
  }
}
