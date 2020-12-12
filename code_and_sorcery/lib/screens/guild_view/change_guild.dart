import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'guild_view.dart';

String dropdownValue = guild;

class ChangeGuild extends StatefulWidget {
  ChangeGuild({this.title, this.someText});
  final Widget title, someText;

  @override
  ChangeGuildState createState() => new ChangeGuildState();
}

class ChangeGuildState extends State<ChangeGuild> {
  final databaseReference = FirebaseFirestore.instance;
  final guildController = TextEditingController();

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue[400]],
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      guild = dropdownValue;
                    });
                  },
                  items: <String>['Backenders', 'Frontenders', 'Fullstackers']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    changeGuild();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Guild()));
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Back'),
          onPressed: () {
            Navigator.pushNamed(context, '/guild');
          },
        ),
      ),
    );
  }

  // updates user's guild

  void changeGuild() async {
    await databaseReference.collection("users").doc(uID).update({
      'guild': dropdownValue,
    });
  }
}

// Future<String> changeGuildPopUp(BuildContext context) {
//   TextEditingController gameLinkController = TextEditingController();
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Select your new guild"),
//           content: SingleChildScrollView(
//               child: ListBody(children: <Widget>[
//             DropdownButton<String>(
//               value: dropdownValue,
//               icon: Icon(Icons.arrow_downward),
//               iconSize: 24,
//               elevation: 16,
//               style: TextStyle(color: Colors.deepPurple),
//               underline: Container(
//                 height: 2,
//                 color: Colors.deepPurpleAccent,
//               ),
//               onChanged: (String newValue) {
//                 setState(() {
//                   dropdownValue = newValue;
//                   guild = dropdownValue;
//                 });
//               },
//               items: <String>['Backenders', 'Frontenders', 'Fullstackers']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             )
//           ])),
//           actions: <Widget>[
//             MaterialButton(
//                 elevation: 5.0,
//                 child: Text('Send', style: TextStyle(fontSize: 23)),
//                 onPressed: () {
//                   changeGuild();
//                   Navigator.of(context).pop(gameLinkController.text.toString());
//                 })
//           ],
//         );
//       });
// }
