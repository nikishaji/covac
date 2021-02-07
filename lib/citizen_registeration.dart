import 'package:covac/otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'citizen.dart';
import 'package:firebase_auth/firebase_auth.dart';

User user;
Citizen citizen;
final namecontroller = TextEditingController();
final agecontroller = TextEditingController();
final housenocontroller = TextEditingController();
final pincodecontroller = TextEditingController();
final streetnamecontroller = TextEditingController();
final locationcontroller = TextEditingController();
final occupationcontroller = TextEditingController();
final aadharcardconrtroller = TextEditingController();
final mobilenocontroller = TextEditingController();
final statecontoller = TextEditingController();
final dbref = FirebaseDatabase.instance.reference();

void register(
    {String name,
    int age,
    int houseno,
    int pincode,
    String streetname,
    String location,
    String occupation,
    int aadharcardno,
    int mobileno,
    String state,
    BuildContext context}) {
  citizen = Citizen(
      name: name,
      age: age,
      aaharcardno: aadharcardno,
      houseno: houseno,
      location: location,
      mobileno: mobileno,
      pincode: pincode,
      state: state,
      streetname: streetname,
      occupation: occupation);

  //if(user == null){

  dbref.child("citizen/${citizen.mobileno}").set({
    'name': citizen.name,
    'age': citizen.age,
    'occupation': citizen.occupation,
    'mobileno': citizen.mobileno,
    'pincode': citizen.pincode,
    'houseno': citizen.houseno,
    'aadharcardno': citizen.aaharcardno,
    'state': state,
    'streetname': citizen.streetname,
    'date': DateTime.now().toString(),
    'isbooked': citizen.isbooked,
    'isvaccinated': citizen.isvaccinated,
    'isrequestbooking': citizen.isrequestbooking,
    'placebooked': "none",
    'isbadge1': citizen.isbadge1,
    'isbadge2': citizen.isbadge2,
    'isbadge3': citizen.isbadge3,
    'isbadge4': citizen.isbadge4,
    'isbadge5': citizen.isbadge5,
    'badgeno': citizen.badgeno,
  }).then((onValue) {
    print('in register()');

    // //  login(citizen.mobileno.toString(),context);
    // Navigator.pushReplacementNamed(
    //   context, CitizenHomePage.routename,arguments: citizen);
    Navigator.pushReplacementNamed(context, OTPScreen.routename,
        arguments: citizen);
  });
}

class CitizenRegisteration extends StatefulWidget {
  static const routeName = '/citizenregisteration';

  @override
  _CitizenRegisterationState createState() => _CitizenRegisterationState();
}

class _CitizenRegisterationState extends State<CitizenRegisteration> {
  bool notregistered = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Citizen Registeration"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //  if(citizen != null)
              //  Center(child:
              //  SpinKitDualRing(color: Colors.black,
              //  duration: Duration(seconds: 1),) ,),

              if (citizen == null)
                Column(
                  children: [
                    Container(
                        width: 150,
                        height: 150,
                        child: ClipOval(
                            child: Image.asset('assets/images/citizen.png'))),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      cursorColor: Colors.black,
                      controller: namecontroller,
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
                      controller: agecontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Age',
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
                      controller: occupationcontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Occupation',
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
                      controller: housenocontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'House number',
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
                      controller: streetnamecontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Street name',
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
                      controller: statecontoller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'State',
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
                      controller: pincodecontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Pincode',
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
                      controller: aadharcardconrtroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Aadhar Card number',
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
                      controller: mobilenocontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        print("register pressed");
                        register(
                            name: namecontroller.text.trim(),
                            location: locationcontroller.text.trim(),
                            occupation: occupationcontroller.text.trim(),
                            state: statecontoller.text.trim(),
                            streetname: streetnamecontroller.text.trim(),
                            aadharcardno: int.parse(aadharcardconrtroller.text),
                            age: int.parse(agecontroller.text),
                            houseno: int.parse(housenocontroller.text),
                            mobileno: int.parse(mobilenocontroller.text),
                            pincode: int.parse(pincodecontroller.text),
                            context: context);
                      },
                      child: Text("Register!",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      color: Colors.white,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
