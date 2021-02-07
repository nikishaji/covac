import 'package:covac/citizen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'place.dart';

class SlotBooking extends StatefulWidget {
  static const routename = '/slotbooking';
  final _userref = FirebaseDatabase.instance.reference();
  Citizen _citizen;
  SlotBooking(this._citizen);

  @override
  _SlotBookingState createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> {
  @override
  void initState() {
    super.initState();
  }

  DateTime selectedDate = DateTime.now().add(new Duration(days: 1));
  String selectedPlace = "General Hospital, Ernakulam (Kerala)";

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  _requestbooking() {
    setState(() {
      widget._citizen.isrequestbooking = true;
    });
    widget._userref.child('citizen/${widget._citizen.mobileno}').update({
      'isrequestbooking': widget._citizen.isrequestbooking,
      'placebooked': selectedPlace,
      'date': DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
          .toString(),
      'isbadge2': true,
      'badgeno': widget._citizen.badgeno + 1
    }).then((value) {});
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2023),
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select booking date', // Can be used as title
      cancelText: 'Not now',
      confirmText: 'Book',
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  _place() async {
    final _selectedPlace = await Navigator.pushNamed(context, Place.routename);
    setState(() {
      selectedPlace = _selectedPlace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slot booking "),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selected Place: $selectedPlace",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            if (widget._citizen.isrequestbooking == false &&
                widget._citizen.isbooked == false)
              Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _requestbooking(),
                    child: Text(
                      'Request Booking',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      'Select another booking date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _place();
                    },
                    child: Text(
                      'Select another place for vaccination',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            if (widget._citizen.isrequestbooking == true &&
                widget._citizen.isbooked == false)
              Text(
                'Your booking is being processed!\nBadge Received on completion of this challenge!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            if (widget._citizen.isbooked == true)
              Text(
                'Yaay your booking is confirmed!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
