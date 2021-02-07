import 'package:flutter/material.dart';
import 'package:covac/citizen.dart';

class Badges extends StatefulWidget {
  static const routename = '/badges';
  Citizen citizen;
  Badges(this.citizen);

  @override
  _BadgesState createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Badges Earned"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.blueGrey[900],
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: <Widget>[
            // Card(
            //   margin: EdgeInsets.all(10),
            //   elevation: 5,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: <Widget>[
            //         Text(
            //           "Total no of badges earned: " +
            //               widget.citizen.badgeno.toString(),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (widget.citizen.isbadge1 == true)
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
                        'Badge Recieved for Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/login.jpg',
                          height: 110, width: 110),
                    ],
                  ),
                ),
              ),
            if (widget.citizen.isbadge2 == true)
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
                        'Badge Recieved for Slot Booking',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/booking.jpg',
                          height: 110, width: 110),
                    ],
                  ),
                ),
              ),
            if (widget.citizen.isbadge3 == true)
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
                        'Badge Recieved for Covid Quiz',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/quiz.jpg',
                          height: 110, width: 110),
                    ],
                  ),
                ),
              ),
            if (widget.citizen.isbadge4 == true)
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
                        'Badge Recieved for taking vaccine',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/vaccinehero.jpg',
                          height: 110, width: 110),
                    ],
                  ),
                ),
              ),
            if (widget.citizen.isbadge5 == true)
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
                        'Badge Recieved for Uploading Selfie',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/selfie.jpg',
                          height: 110, width: 110),
                    ],
                  ),
                ),
              ),
          ]),
        )));
  }
}
