import 'package:flutter/material.dart';

class Place extends StatefulWidget {
  static const routename = '/place';
  @override
  _PlaceState createState() => _PlaceState();
}

class PlaceList {
  String name;
  int index;
  String time;
  PlaceList({this.name, this.index, this.time});
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Nothing Selected"),
    content: Text("Please select a place to continue"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _PlaceState extends State<Place> {
  int id = 0;
  static var radioItem = "General Hospital, Ernakulam (Kerala)";
  static List<PlaceList> fList = [
    PlaceList(
      index: 1,
      name: "General Hospital, Ernakulam (Kerala)",
      time: "Opening Time:-7am-7pm (Appointment-FCFS)",
    ),
    PlaceList(
      index: 2,
      name: "Christian Medical College and Hospital, Vellore (Tamil Nadu)",
      time: "Opening Time:-7am-7pm (Appointment-FCFS)",
    ),
    PlaceList(
      index: 3,
      name: "All India Institute of Medical Sciences, New Delhi",
      time: "Opening Time:-7am-7pm (Appointment-FCFS)",
    ),
    PlaceList(
      index: 4,
      name:
          "Post Graduate Institute of Medical Education and Research, Chandigarh (Punjab)",
      time: "Opening Time:-7am-7pm (Appointment-FCFS)",
    ),
    PlaceList(
      index: 5,
      name: " TATA Memorial Hospital, Mumbai (Maharashtra)",
      time: "Opening Time:-7am-7pm (Appointment-FCFS)",
    ),
    PlaceList(
      index: 6,
      name: "Calcutta National Medical College (Kolkata)",
      time: "Opening Time:-7am-7pm (Appointment-FCFS)",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose place for vaccination'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.blueGrey[900],
        body: SafeArea(
            child: Center(
                child:

                    // Group Value for Radio Button.

                    Column(
          children: <Widget>[
            Expanded(
                child: Container(
              height: 800.0,
              child: Column(
                children: fList
                    .map((data) => RadioListTile(
                          activeColor: Colors.white,
                          title: Text(
                            "${data.name}",
                            style: TextStyle(color: Colors.white),
                          ),
                          groupValue: id,
                          value: data.index,
                          subtitle: Text(
                            "${data.time}",
                            style: TextStyle(color: Colors.white),
                          ),
                          onChanged: (val) {
                            setState(() {
                              radioItem = data.name;
                              id = data.index;
                            });
                          },
                        ))
                    .toList(),
              ),
            )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  if (id != 0) {
                    Navigator.pop(context, radioItem);
                  } else {
                    showAlertDialog(context);
                  }
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ))));
  }
}
