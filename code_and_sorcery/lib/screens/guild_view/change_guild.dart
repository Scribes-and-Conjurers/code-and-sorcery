import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'guild_view.dart';

class ChangeGuild extends StatefulWidget {
  ChangeGuild({this.title, this.someText});
  final Widget title, someText;
  @override
  ChangeGuildState createState() => new ChangeGuildState();
}
class ChangeGuildState extends State<ChangeGuild> {
  final databaseReference = FirebaseFirestore.instance;
  final guildController = TextEditingController();
  String guildValue = "";

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp
      (
      home: new Scaffold
        (
        appBar: new AppBar (title: widget.title,),
        body:  Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue[400]],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column
              (
              children: <Widget>[
                new TextField
                  (
                  controller: guildController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Change Guild"),
                  onChanged: (String text) {
                    setState(() {
                      guildValue = guildController.text;
                    });
                  },
                ),
                new Text("\n\n"),
                ElevatedButton(
                  onPressed: () {
                    changeGuild();
                    guild = guildValue;
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
          child:Text('Back'),
          onPressed: () {
            Navigator.pushNamed(context, '/guild');
          },
        ),
      ),
    );
  }

  // updates user's guild

  void changeGuild() async {
    await databaseReference.collection("users")
        .doc(uID)
        .update({
      'guild': guildValue,
    });
  }
}