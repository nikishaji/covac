import 'package:covac/login_vaccinator.dart';
import 'package:covac/vaccinator_registeration.dart';
import 'package:flutter/material.dart';

class Vaccinator_login_or_signup extends StatelessWidget {
  static const routename = '/vaccinatorloginorsignup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: 150,
                  height: 150,
                  child: ClipOval(
                      child: Image.asset('assets/images/vaccine.jpg'))),
              Text(
                "CovaC",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                ),
              ),
              Text(
                "'A little Pain for a lot of Gain'",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Vaccinator",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
              SizedBox(height: 10)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, VaccinatorLogin.routename)},
                child: Text("Log In!",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(width: 20),
              RaisedButton(
                onPressed: () => {
                  Navigator.pushNamed(
                      context, VaccinatorRegisteration.routeName)
                },
                child: Text("Sign Up!",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
