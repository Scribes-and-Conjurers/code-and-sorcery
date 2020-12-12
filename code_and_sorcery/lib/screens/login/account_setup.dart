import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';

class AccountSetup extends StatefulWidget {
  AccountSetup({this.title, this.someText});
  final Widget title, someText;
  @override
  AccountSetupState createState() => new AccountSetupState();
}

class AccountSetupState extends State<AccountSetup> {
  final databaseReference = FirebaseFirestore.instance;
  final usernameController = TextEditingController();
  final guildController = TextEditingController();
  String usernameValue = "";
  String dropdownGuildValue = "";

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: widget.title,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Text("Choose your username"),
            SizedBox(height: 30),
            TextField(
              controller: usernameController,
              decoration: new InputDecoration(
                  border: OutlineInputBorder(), hintText: "Type your username"),
              onChanged: (String text) {
                setState(() {
                  usernameValue = usernameController.text;
                  print('usernameValue $usernameValue');
                  print('test');
                  username = usernameValue;
                });
              },
            ),
            SizedBox(height: 50),
            Text("Choose your guild"),
            SizedBox(height: 30),
            DropdownButton<String>(
              value: "Backenders",
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
                  dropdownGuildValue = newValue;
                  guild = dropdownGuildValue;
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
            SizedBox(height: 50),
            Text("Choose your class"),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                playerClass = 'Warrior';
              },
              child: Text('Warrior'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                playerClass = 'Wizard';
              },
              child: Text('Wizard'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                setUsernameGuildClass();
                Navigator.pushNamed(context, '/homepage');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // update username and guild for user in database
  void setUsernameGuildClass() async {
    await databaseReference.collection("users").doc(uID).update({
      'guild': guild,
      'username': username,
      'profileImg': '1',
      'points': 0,
      'playerClass': playerClass
    });
  }
}
