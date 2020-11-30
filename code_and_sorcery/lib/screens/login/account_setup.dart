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

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp
      (
      home: new Scaffold
        (
        appBar: new AppBar (title: widget.title,),
        body: new Column
          (
          children: <Widget>[
            new TextField
              (
              controller: usernameController,
              decoration: new InputDecoration.collapsed(
                  hintText: "ADD USERNAME"),
              onChanged: (String text) {
                setState(() {
                  usernameValue = usernameController.text;
                  print('usernameValue $usernameValue');
                  print('test');
                  username = usernameValue;
                });
              },
            ),
            new TextField
              (
              controller: guildController,
              decoration: new InputDecoration.collapsed(
                  hintText: "ADD GUILD"),
              onChanged: (String text) {
                setState(() {
                  guildValue = guildController.text;
                  guild = guildValue;
                });
                // TextEditingController().clear();
              },
            ),
            ElevatedButton(
              onPressed: () {
                setUsernameAndGuild();
                Navigator.pushNamed(context, '/');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // update username and guild for user in database
  void setUsernameAndGuild() async {
    await databaseReference.collection("users")
        .doc(uID)
        .update({
      'guild': guild,
      'username': username,
    });
  }
}