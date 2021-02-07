import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class _userclass{
  String username,feedback;
  _userclass(this.username,this.feedback){}
}

List<_userclass> conformationList =List<_userclass>() ;
final database =FirebaseDatabase.instance.reference();

class Readfeedbacks extends StatefulWidget {

 static const routename ='/readfeedbacks';
  @override
  _ReadfeedbacksState createState() => _ReadfeedbacksState();
}

class _ReadfeedbacksState extends State<Readfeedbacks> {
 void work(){
  final dbreference = FirebaseDatabase.instance.reference();
  dbreference.child('feedbacks').once().then((DataSnapshot data ){
    if(data != null){
     // print(data.value.keys);
 conformationList.clear();
  var keys = data.value.keys;
  print(keys.runtimeType);
  print(keys);
    var values = data.value;
   for( var key in keys){

   //       print('name: '+values[key]['name'].toString() +" mob:"+values[key]['mobileno'].toString());
          // conformationList.add(values[key]['feedback']) ;
       conformationList.add(new _userclass(values[key],values[key]['feedback'] ));   
     }

    }
    else print('data is empty');
   
  });
}

 ListView generateItemsList() {
    return ListView.builder(
      itemCount: conformationList.length,
      itemBuilder: (context, index) {
        return Dismissible(
         key: Key(conformationList[index].username),
          child: InkWell(
              child: ListTile(title: Text('${conformationList[index].feedback}',
              style: TextStyle(fontWeight: FontWeight.bold),),
             leading: Text('mobile: ${conformationList[index].username}'),
              )
              ),
        );
      },
    );
  }
   @override
 void initState(){
   super.initState();
   work();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Feedbacks'),
        backgroundColor: Colors.black,
      ),
      body: generateItemsList(),
      
    );
  }
}