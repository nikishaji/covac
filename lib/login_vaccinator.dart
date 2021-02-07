import 'package:covac/vaccinator_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'vaccinator.dart';

final _namecontroller = TextEditingController();
final _mobilenocontroller = TextEditingController();

class VaccinatorLogin extends StatefulWidget {
  Vaccinator _vaccinator;
  static const routename = '/vaccinatorlogin';
  @override
  _VaccinatorLoginState createState() => _VaccinatorLoginState();
}

class _VaccinatorLoginState extends State<VaccinatorLogin> {
  void _confirmuserifexits(int mobileno, String name) {
    bool found = false;
    final userref = FirebaseDatabase.instance.reference();
    userref.child('vaccinator/').once().then((data) {
      if (data != null) {
        print(data.value);
        var keys = data.value.keys;
        var values = data.value;
        for (var key in keys) {
          if (values[key]['name'] == name &&
              values[key]['mobileno'] == mobileno) {
            widget._vaccinator = Vaccinator(
              age: values[key]['age'],
              date: DateTime.parse(values[key]['date']),
              mobileno: values[key]['mobileno'],
              name: values[key]['name'],
              numberofpplvaccinated: values[key]['numberofpplvaccinated'],
              placereserved: values[key]['placereserved'],
              time: values[key]['time'],
            );
            found = true;
            break;
          }
        }

        print('over here');
        if (found) {
          Navigator.pushReplacementNamed(context, VaccinatorHomepage.routename,
              arguments: widget._vaccinator);
        } else {
          print('login failed!');
          Fluttertoast.showToast(
            msg: ' Name or MobileNumber entered is incorrect',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Vaccinator'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Please enter your Registered Name and Mobile Number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: _namecontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: _mobilenocontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _confirmuserifexits(
                      int.parse(_mobilenocontroller.text.trim()),
                      _namecontroller.text.trim());
                  _mobilenocontroller.clear();
                  _namecontroller.clear();
                },
                child: Text(
                  'Login!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
