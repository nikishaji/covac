import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'citizen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Citizen_Report extends StatelessWidget {
  Citizen _citizen;
  static const routename = '/report';
  Citizen_Report(this._citizen);
  final reportcontroller = TextEditingController();
  final dbreport = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report your illness"),
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
                maxLines: 50,
                cursorColor: Colors.black,
                controller: reportcontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Please Specify your illness',
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
                String data = reportcontroller.text.trim();
                if (data != null || data != "") {
                  dbreport
                      .child(
                          'reports/${_citizen.name + _citizen.mobileno.toString()}')
                      .set({
                    'report': data,
                    'date': DateTime.now().toString(),
                    'name': _citizen.name,
                    'mob': _citizen.mobileno,
                  }).then((value) {
                    Fluttertoast.showToast(
                        msg: 'Your illness was reported!',
                        backgroundColor: Colors.blueGrey[900],
                        textColor: Colors.white);
                  });
                  Navigator.pop(context);
                }
              },
              color: Colors.white,
              child: Text('Report illness',
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
