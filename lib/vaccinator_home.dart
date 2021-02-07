import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'booking_confirm.dart';
import 'vaccinator.dart';
import 'confirmvaccination.dart';
import 'manual.dart';
//import 'readfeedbacks.dart';
import 'readreports.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VaccinatorHomepage extends StatefulWidget {
  static const routename = '/vaccinatorhome';
  Vaccinator vaccinator;
  VaccinatorHomepage(this.vaccinator);

  @override
  _VaccinatorHomepageState createState() => _VaccinatorHomepageState();
}

class _VaccinatorHomepageState extends State<VaccinatorHomepage> {
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
                if (name == 'Confirm slot bookings') {
                  Navigator.pushNamed(
                      context, BookingConformationChecker.routename,
                      arguments: widget.vaccinator);
                } else if (name == 'Confirm Vaccinations') {
                  Navigator.pushNamed(context, ConfirmVaccination.routename,
                          arguments: widget.vaccinator)
                      .then((value) {
                    setState(() {
                      _updatevaccinatorinfo();
                    });
                  });
                } else if (name == 'Illness reports') {
                  Navigator.pushNamed(context, Readreports.routename);
                } else if (name == 'Vaccine Manual') {
                  Navigator.pushNamed(context, Manuals.routename);
                }
                //  else if(name == 'Feedbacks received'){
                //    Navigator.push(context,"/readfeedbacks");
                //   }
                else if (name == 'Contact Us') {
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updatevaccinatorinfo() {
    print('update running');
    final usrdb = FirebaseDatabase.instance.reference();
    usrdb
        .child('vaccinator/${widget.vaccinator.mobileno}')
        .once()
        .then((DataSnapshot data) {
      if (data != null) {
        var value = data.value;
        setState(() {
          widget.vaccinator = Vaccinator(
            age: value['age'],
            date: DateTime.parse(value['date']),
            mobileno: value['mobileno'],
            name: value['name'],
            numberofpplvaccinated: value['numberofpplvaccinated'],
            placereserved: value['placereserved'],
            time: value['time'],
          );
          print('num vacc: ${widget.vaccinator.numberofpplvaccinated}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Covac- Vaccinator Home Page')),
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    cardcreator('Confirm slot bookings', context),
                    cardcreator('Confirm Vaccinations', context),
                    cardcreator('Illness reports', context),
                    cardcreator('Vaccine Manual', context),
                    cardcreator('Contact Us', context),
                    //  widget.cardcreator('Feedbacks received',context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
                          widget.vaccinator.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("Age: " + widget.vaccinator.age.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))
                        //               Stack(
                        //                 alignment:Alignment.center,
                        //                 children:<Widget>[ Image.asset('assets/images/trophy.png'),
                        // Positioned(
                        //     right: 6,
                        //     top: 2,
                        //     child: Container(
                        //       padding: EdgeInsets.all(2.0),
                        //       // color: Theme.of(context).accentColor,
                        //       decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(10.0),
                        //             color: Colors.red,
                        //       ),
                        //       constraints: BoxConstraints(
                        //             minWidth: 16,
                        //             minHeight: 16,
                        //       ),
                        //       child: Text(
                        //             '1',
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle(
                        //               fontSize: 10,
                        //             ),
                        //       ),
                        //     ),
                        // )
                        //               ],)
                      ],
                    ),
                    Text("(vaccinator)")
                  ],
                ),
              ),
            ),
            cardcreator(
                "Working at :\n" +
                    widget.vaccinator.placereserved +
                    "\n" +
                    widget.vaccinator.time,
                context),
            cardcreator(
                'Number of people you vaccinated: ${widget.vaccinator.numberofpplvaccinated.toString()}',
                context),
            Container(
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/images/vaccine home.jpeg'),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/images/vaccinehome2.jpeg'),
            ),
          ],
        ),
      ),
    );
  }
}
