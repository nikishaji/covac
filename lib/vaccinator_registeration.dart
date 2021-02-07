import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'vaccinator.dart';
import 'vaccinator_home.dart';

final fbreference = FirebaseDatabase.instance.reference();
final namecontroller = TextEditingController();
final agecontroller = TextEditingController();
final addresscontroller = TextEditingController();
final locationcontroller = TextEditingController();
final hospitalnamecontroller = TextEditingController();
final mobilenocontroller = TextEditingController();

class VaccinatorRegisteration extends StatefulWidget {
  static const routeName = '/vaccineregisteration';
  Vaccinator vaccinator;
  @override
  _VaccinatorRegisterationState createState() =>
      _VaccinatorRegisterationState();
}

class _VaccinatorRegisterationState extends State<VaccinatorRegisteration> {
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    if (widget.vaccinator != null) {
      fbreference
          .child('vaccinator/${widget.vaccinator.mobileno.toString()}')
          .once()
          .then((DataSnapshot data) {
        if (data != null) {
          print('data snapshot:' + data.value.toString());
          //  var keys= data.key;
          var value = data.value;
          widget.vaccinator = Vaccinator(
            age: value['age'],
            date: DateTime.parse(value['date']),
            mobileno: value['mobileno'],
            name: value['name'],
            placereserved: value['placereserved'],
            time: value['time'],
          );

          Navigator.pushReplacementNamed(context, VaccinatorHomepage.routename,
              arguments: widget.vaccinator);
        }
      });
    }
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Expanded(
              child: Text(
            company.name,
            style: TextStyle(fontSize: 10),
          )),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccinator Registeration"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                  width: 150,
                  height: 150,
                  child: ClipOval(
                      child: Image.asset('assets/images/vaccinator.jpg'))),
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
              Text(
                'Enter your reserved place',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                width: 400,
                margin: EdgeInsets.all(8),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  value: _selectedCompany,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  widget.vaccinator = Vaccinator(
                      name: namecontroller.text.trim(),
                      age: int.parse(agecontroller.text.trim()),
                      date: DateTime.now(),
                      placereserved: _selectedCompany.name,
                      time: _selectedCompany.time,
                      mobileno: int.parse(mobilenocontroller.text.trim()));

                  var vac = widget.vaccinator;

                  fbreference
                      .child(
                          'vaccinator/${widget.vaccinator.mobileno.toString()}')
                      .set({
                    'name': vac.name,
                    'age': vac.age,
                    'date': vac.date.toString(),
                    'placereserved': vac.placereserved,
                    'time': vac.time,
                    'mobileno': vac.mobileno,
                    'numberofpplvaccinated': vac.numberofpplvaccinated,
                  }).then((value) {
                    Navigator.pushReplacementNamed(
                        context, VaccinatorHomepage.routename,
                        arguments: widget.vaccinator);
                  });
                },
                child: Text(
                  "Register!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Colors.white,
                textColor: Colors.black,
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

class Company {
  int index;
  String name, time;

  Company({this.index, this.name, this.time});

  static List<Company> getCompanies() {
    return <Company>[
      Company(
        index: 1,
        name: "General Hospital, Ernakulam (Kerala)",
        time: "Opening Time:-7am-7pm (Appointment-FCFS)",
      ),
      Company(
        index: 2,
        name: "Christian Medical College and Hospital, Vellore (Tamil Nadu)",
        time: "Opening Time:-7am-7pm (Appointment-FCFS)",
      ),
      Company(
        index: 3,
        name: "All India Institute of Medical Sciences, New Delhi",
        time: "Opening Time:-7am-7pm (Appointment-FCFS)",
      ),
      Company(
          index: 3,
          name: "All India Institute of Medical Sciences, New Delhi",
          time: "Opening Time:-7am-7pm (Appointment-FCFS)"),
      Company(
        index: 5,
        name: " TATA Memorial Hospital, Mumbai (Maharashtra)",
        time: "Opening Time:-7am-7pm (Appointment-FCFS)",
      ),
      Company(
        index: 6,
        name: "Calcutta National Medical College (Kolkata)",
        time: "Opening Time:-7am-7pm (Appointment-FCFS)",
      ),
    ];
  }
}
