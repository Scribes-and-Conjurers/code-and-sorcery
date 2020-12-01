import 'package:flutter/material.dart';
import '../login/authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class JoinGame extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Join a game"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate back to the first screen by popping the current route
//             // off the stack.
//             Navigator.pushNamed(context, '/lobby');
//           },
//           child: Text('Join a game'),
//         ),
//       ),
//     );
//   }
// }

class JoinGame extends StatefulWidget {
  JoinGame({this.title, this.someText});
  final Widget title, someText;
  @override
  JoinGameState createState() => new JoinGameState();
}
class JoinGameState extends State<JoinGame> {
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
                  hintText: "ADD LINK"),
              onChanged: (String text) {
                setState(() {
                  usernameValue = usernameController.text;
                  print('usernameValue $usernameValue');
                  print('test');
                });
              },
            ),
            new Text("\n\n"),
            ElevatedButton(
              onPressed: () {
                setPlayer2();
                Navigator.pushNamed(context, '/lobby');
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }

  // update username and guild for user in database
  void setPlayer2() async {
    await databaseReference.collection("games")
        .doc('testGameSession')
        .update({
      'player2': username,
    });
  }
}