import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'citizen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedBacksCitizen extends StatelessWidget {
  final _feedbackcontroller = TextEditingController();
  static const routename = '/feedback';
  Citizen _citizen;
  FeedBacksCitizen(this._citizen);
  final _dbreport = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Give your Feedbacks"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              margin: EdgeInsets.all(10),
              child: TextField(
                minLines: 1,
                maxLines: 100,
                cursorColor: Colors.black,
                controller: _feedbackcontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Please enter your feedbacks',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                String data = _feedbackcontroller.text.trim();
                if (data != null || data != "") {
                  _dbreport.child('feedbacks/${_citizen.name}').set({
                    'feedback': data,
                    'date': DateTime.now().toString(),
                  }).then((value) {
                    Fluttertoast.showToast(
                        msg: 'Thankyou for your feedbacks !',
                        backgroundColor: Colors.blueGrey[900],
                        textColor: Colors.white);
                  });
                  Navigator.pop(context);
                }
              },
              color: Colors.white,
              child: Text(
                'Submit Feedback!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }
}
