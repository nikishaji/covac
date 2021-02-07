import 'package:covac/citizen_registeration.dart';
import 'package:covac/vaccinator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

List<person> conformationList = List<person>();

class BookingConformationChecker extends StatefulWidget {
  static const routename = '/bookingconfirm';
  Vaccinator _vaccinator;
  BookingConformationChecker(this._vaccinator);
  @override
  _BookingConformationCheckerState createState() =>
      _BookingConformationCheckerState();
}

class _BookingConformationCheckerState
    extends State<BookingConformationChecker> {
  bool isloading;

  void work() async {
    final dbreference = FirebaseDatabase.instance.reference();
    await dbreference.child('citizen').once().then((DataSnapshot data) {
      if (data != null) {
        // print(data.value.keys);
        conformationList.clear();
        var keys = data.value.keys;
        print(keys.runtimeType);
        print(keys);
        var values = data.value;
        for (var key in keys) {
          if (values[key]['isrequestbooking'] == true &&
              values[key]['isbooked'] == false &&
              widget._vaccinator.placereserved == values[key]['placebooked']) {
            person p = person(values[key]['name'].toString(),
                values[key]['mobileno'].toString());
            print('name: ' +
                values[key]['name'].toString() +
                " mob:" +
                values[key]['mobileno'].toString());
            conformationList.add(p);
          }
        }
      } else
        print('data is empty');
    });
    setState(() {
      isloading = false;
    });
  }

  ListView generateItemsList() {
    return ListView.builder(
      itemCount: conformationList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(conformationList[index].name),
          child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          "Swipe right to confirm whether to confirm booking otherwise swipe left to reject"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 5),
                elevation: 1,
                child: ListTile(
                  title: Text(
                    '${conformationList[index].name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading:
                      Text('mobile no: ${conformationList[index].mobileno}'),
                ),
              )),
          background: slideRightBackground(),
          secondaryBackground: slideLeftBackground(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          "Are you sure you want to reject ${conformationList[index].name}?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Reject",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            dbref
                                .child(
                                    'citizen/${conformationList[index].mobileno}')
                                .update({
                              'isrequestboooking': false,
                              'isbooked': false,
                            });
                            setState(() {
                              conformationList.removeAt(index);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
              return res;
            } else {
              // TO DO THINGS WHEN YOU WANT TO CONFIRM THE PATIENT
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          "Are you sure you want to confirm ${conformationList[index].name}?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            // TODO: Delete the item from DB etc..
                            dbref
                                .child(
                                    'citizen/${conformationList[index].mobileno}')
                                .update({
                              'isbooked': true,
                            });
                            setState(() {
                              conformationList.removeAt(index);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
              return res;
            }
          },
        );
      },
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.check,
              color: Colors.white,
            ),
            Text(
              " Confirm",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Reject",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isloading = true;
    work();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Confirm Booking'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.blueGrey[900],
        body: Center(
            child: Stack(children: <Widget>[
          isloading
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  semanticsLabel: "Loading..",
                  semanticsValue: "Loading..",
                )
              : conformationList.length == 0
                  ? Text("No bookings to be confirmed!",
                      style: TextStyle(fontSize: 20, color: Colors.white))
                  : generateItemsList(),
        ])));
  }
}

class person {
  String name, mobileno;
  person(this.name, this.mobileno);
}
