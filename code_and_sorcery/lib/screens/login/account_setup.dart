import 'package:flutter/material.dart';
import 'package:code_and_sorcery/screens/login/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authenticator.dart';
import '../homepage/homepage.dart';

// if username != null && guild != null then go to homepage

// void main() {
//   runApp(new AccountSetup (
//     title: new Text("My App"), someText: new Text("Some Text>>>"),));
// }
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
  String guildValue = "";
  // String dropdownValue = "The";

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: widget.title,
        ),
        body: new Column(
          children: <Widget>[
            new TextField(
              controller: usernameController,
              decoration:
                  new InputDecoration.collapsed(hintText: "ADD USERNAME"),
              onChanged: (String text) {
                setState(() {
                  usernameValue = usernameController.text;
                  print('usernameValue $usernameValue');
                  print('test');
                  username = usernameValue;
                });
              },
            ),
            new Text("\n\n"),
            new TextField(
              controller: guildController,
              decoration: new InputDecoration.collapsed(hintText: "ADD GUILD"),
              onChanged: (String text) {
                setState(() {
                  guildValue = guildController.text;
                  guild = guildValue;
                });
                // TextEditingController().clear();
              },
            ),
            new Text("\n\n"),
            new Text("Choose your class"),
            new Text("\n\n"),
            ElevatedButton(
              onPressed: () {
                playerClass = 'Warrior';
              },
              child: Text('Warrior'),
            ),
            new Text("\n\n"),
            ElevatedButton(
              onPressed: () {
                playerClass = 'Wizard';
              },
              child: Text('Wizard'),
            ),
            new Text("\n\n"),
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
      'points': 0,
      'playerClass': playerClass
    });
  }
}

// Widget guildMenu(BuildContext context) {
//   return DropdownButton<String>(
//     value: dropdownValue,
//     icon: Icon(Icons.arrow_downward),
//     iconSize: 24,
//     elevation: 16,
//     style: TextStyle(color: Colors.deepPurple),
//     underline: Container(
//       height: 2,
//       color: Colors.deepPurpleAccent,
//     ),
//     onChanged: (String newValue) {
//       setState(() {
//         dropdownValue = newValue;
//       });
//     },
//     items: <String>['One', 'Two', 'Free', 'Four']
//         .map<DropdownMenuItem<String>>((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     }).toList(),
//   );
