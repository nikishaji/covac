import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class _userclass {
  String username, report;
  int mobileno;
  _userclass(this.username, this.report, this.mobileno) {}
}

List<_userclass> conformationList = List<_userclass>();

class Readreports extends StatefulWidget {
  static const routename = '/readreports';
  @override
  _ReadreportsState createState() => _ReadreportsState();
}

class _ReadreportsState extends State<Readreports> {
  bool isloading;
  void work() async {
    final dbreference = FirebaseDatabase.instance.reference();
    await dbreference.child('reports').once().then((DataSnapshot data) {
      if (data != null) {
        // print(data.value.keys);
        conformationList.clear();
        var keys = data.value.keys;
        var values = data.value;
        print(values.keys);
        for (var key in keys) {
          var _data = _userclass(values[key]['name'].toString(),
              values[key]['report'].toString(), values[key]['mob']);
          conformationList.add(_data);
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
          key: Key(conformationList[index].username),
          child: InkWell(
              child: Card(
            color: Colors.white,
            elevation: 1,
            margin: EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
            child: ListTile(
              title: Text(
                '${conformationList[index].report}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Text('name : ${conformationList[index].username}'),
              trailing: Text('mob: ${conformationList[index].mobileno}'),
            ),
          )),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      work();
      isloading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Read Illness Report'),
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
                  : generateItemsList()
        ])));
  }
}
