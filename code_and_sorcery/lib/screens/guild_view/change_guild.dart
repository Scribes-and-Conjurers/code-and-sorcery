import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'guild_view.dart';
import '../../global_variables/global_variables.dart';

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
  // String guildValue = "";

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        // appBar: new AppBar (title: widget.title,),
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
                // new TextField(
                //   controller: guildController,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(), hintText: "Change Guild"),
                //   onChanged: (String text) {
                //     setState(() {
                //       guildValue = guildController.text;
                //     });
                //   },
                // ),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    changeGuild();
                    // guild = guildValue;
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
