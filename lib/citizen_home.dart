import 'package:covac/challenges.dart';
import 'package:covac/cititzen_report.dart';
import 'package:covac/citizen.dart';
import 'package:covac/faq.dart';
import 'package:covac/feedbacks.dart';
import 'package:covac/slotbooking.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'viewcertificate.dart';
import 'badge.dart';

class CitizenHomePage extends StatefulWidget {
  var day, month, year;
  static const routename = '/citizenhome';
  Citizen citizen;
  var globaldata;
  CitizenHomePage(this.citizen) {}

  @override
  _CitizenHomePageState createState() => _CitizenHomePageState();
}

class _CitizenHomePageState extends State<CitizenHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getdata();
    });
  }

  Widget cardcreator(String name, BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (name == "FAQ") {
                  Navigator.pushNamed(context, Faq.routename);
                } else if (name == "Slot Booking") {
                  if (widget.citizen.isvaccinated == false)
                    Navigator.pushNamed(context, SlotBooking.routename,
                            arguments: widget.citizen)
                        .then((value) {
                      setState(() {
                        _updatecitizeninfo();
                        _getdata();
                      });
                    });
                  else {
                    // if (citizen.date == null)
                    // citizen.date =DateTime.now();

                    DateTime date = widget.citizen.date.add(Duration(days: 28));
                    widget.day = date.day.toString();
                    widget.month = date.month.toString();
                    widget.year = date.year.toString();
                    String dateinstring =
                        widget.day + "/" + widget.month + "/" + widget.year;
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg:
                          'You have Already taken your first shot,\n Next shot is scheduled to ' +
                              dateinstring,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 15,
                      backgroundColor: Colors.blueGrey[900],
                      textColor: Colors.white,
                    );
                  }
                } else if (name == "Challenges") {
                  Navigator.pushNamed(context, Challenges.routename,
                          arguments: widget.citizen)
                      .then((value) {
                    setState(() {
                      _updatecitizeninfo();
                      _getdata();
                    });
                  });
                } else if (name == "Report an illness") {
                  Navigator.pushNamed(context, Citizen_Report.routename,
                      arguments: widget.citizen);
                } else if (name == "Badges Earned") {
                  Navigator.pushNamed(context, Badges.routename,
                      arguments: widget.citizen);
                } else if (name == 'Contact Us') {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: 'Email us your quries to \n covacvaccine@gmail.com',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 18,
                    backgroundColor: Colors.blueGrey[900],
                    textColor: Colors.white,
                  );
                } else if (name == 'Feedback') {
                  Navigator.pushNamed(context, FeedBacksCitizen.routename,
                      arguments: widget.citizen);
                } else if (name == 'Vaccine Certificate') {
                  if (widget.citizen.isvaccinated)
                    Navigator.pushNamed(context, Viewcertificate.routename);
                  else {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg:
                          'You can avail Certificate after you have vaccinated',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 18,
                      backgroundColor: Colors.blueGrey[900],
                      textColor: Colors.white,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getdata() async {
    try {
      var response =
          await http.get(Uri.encodeFull("https://api.covid19api.com/summary"));
      // print(response.body);
      var data = json.decode(response.body);
      //List data = json.decode(response.body);
      print((data["Global"]));
      setState(() {
        widget.globaldata = data["Global"];
      });
    } catch (e) {}

    return null;
  }

  void _updatecitizeninfo() {
    final userdb = FirebaseDatabase.instance.reference();
    userdb
        .child('citizen/${widget.citizen.mobileno.toString()}')
        .once()
        .then((DataSnapshot data) {
      if (data != null) {
        print('data snapshot:' + data.value.toString());
        //  var keys= data.key;
        var value = data.value;
        widget.citizen = Citizen(
          aaharcardno: value['aadharcardno'],
          age: value['age'],
          date: DateTime.parse(value['date']),
          houseno: value['houseno'],
          isbooked: value['isbooked'],
          isrequestbooking: value['isrequestbooking'],
          isvaccinated: value['isvaccinated'],
          mobileno: value['mobileno'],
          name: value['name'],
          occupation: value['occupation'],
          pincode: value['pincode'],
          placebooked: value['placebooked'],
          state: value['state'],
          streetname: value['streetname'],
          isbadge1: value['isbadge1'],
          isbadge2: value['isbadge2'],
          isbadge3: value['isbadge3'],
          isbadge4: value['isbadge4'],
          isbadge5: value['isbadge5'],
          badgeno: value['badgeno'],
        );
      }

      print(" mob no: " + widget.citizen.mobileno.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[
            Text("CovaC - Citizen Home Page"),
            SizedBox(width: 10),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey[900],
      drawer: Drawer(
          child: Container(
        color: Colors.blueGrey[900],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                'MENU BAR',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  cardcreator('Slot Booking', context),
                  cardcreator('Challenges', context),
                  cardcreator('Badges Earned', context),
                  cardcreator('Report an illness', context),
                  cardcreator('Contact Us', context),
                  cardcreator('FAQ', context),
                  cardcreator('Feedback', context),
                  cardcreator('Vaccine Certificate', context)
                ],
              ),
            ],
          ),
        ),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          widget.citizen.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Age: " + widget.citizen.age.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        //         Stack(
                        //           alignment:Alignment.center,
                        //           children:<Widget>[ Image.asset('assets/images/trophy.png'),
                        // Positioned(
                        //   right: 6,
                        //   top: 2,
                        //   child: Container(
                        //     padding: EdgeInsets.all(2.0),
                        //     // color: Theme.of(context).accentColor,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //       color: Colors.red,
                        //     ),
                        //     constraints: BoxConstraints(
                        //       minWidth: 16,
                        //       minHeight: 16,
                        //     ),
                        //     child: Text(
                        //       widget.citizen.badgeno.toString(),
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         fontSize: 10,
                        //       ),
                        //     ),
                        //   ),
                        // )
                        //         ],)
                      ],
                    ),
                    Text(
                      '(${widget.citizen.occupation})',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            cardcreator('Earn  badges by completing challenges!', context),
            Container(
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/images/vaccine home.jpeg'),
            ),
            Container(
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      if (widget.globaldata != null)
                        Column(
                          children: [
                            Text('Corona Virus Cases:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              widget.globaldata['TotalConfirmed'].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text('Deaths:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(widget.globaldata['TotalDeaths'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 20),
                            Text('Recovered:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(widget.globaldata['TotalRecovered'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 20),
                          ],
                        ),
                      if (widget.globaldata == null)
                        Column(
                          children: [
                            SpinKitCircle(
                              color: Colors.black,
                              size: 100,
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
            if (widget.citizen.isrequestbooking == false)
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Slot bookings for vaccinations can be done in the Side Drawer',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

            if (widget.citizen.isrequestbooking == true &&
                widget.citizen.isbooked == false)
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Your booking is being processed!',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

            if (widget.citizen.isbooked == true &&
                widget.citizen.isvaccinated == false)
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Your booking is confirmed! \n Please check Slot booking for further details',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

            if (widget.citizen.isvaccinated == true)
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Yaay , you got Vaccinated!!\n You can now avait the certificate \n and show it off to your family and friends',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

            // Card(margin: EdgeInsets.all(10),
            //     elevation: 5,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: <Widget>[
            //         Text("'wear mask ,save your loved ones'",),
            //       ],
            //   ),
            //     ),
            // ),
          ],
        ),
      ),
    );
  }
}
