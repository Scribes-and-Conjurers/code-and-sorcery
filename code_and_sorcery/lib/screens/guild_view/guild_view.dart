// import 'package:code_and_sorcery/screens/guild_view/change_guild.dart';
import 'package:code_and_sorcery/screens/guild_view/guild_rankings.dart';
import 'package:code_and_sorcery/screens/guild_view/user_rankings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

String dropdownValue = guild;

class Guild extends StatefulWidget {
  Guild({this.title, this.someText});
  final Widget title, someText;
  @override
  GuildView createState() => new GuildView();
}

class GuildView extends State<Guild> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: color1,
        ),
        child: Center(
          child: Column(
            children: [
              // guildNameSection,
              Padding(padding: EdgeInsets.all(40.0)),
              guildNameGetter(context),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(
                    thickness: 5,
                    color: color3,
                  )),
              Padding(padding: EdgeInsets.all(30.0)),
              totalPointsSection,
              Padding(padding: EdgeInsets.all(10.0)),
              guildPointsGetter(context),
              // userRanking,
              // guildRanking,
              // guildRankGetter(context),
              SizedBox(height: 35),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor3),
                  ),
                  onPressed: () {
                    // Navigate back to the first screen by popping the current route
                    // off the stack.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRankings()));
                  },
                  child: Text('USER RANKINGS',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor3),
                  ),
                  onPressed: () {
                    // Navigate back to the first screen by popping the current route
                    // off the stack.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuildRankings()));
                  },
                  child: Text('GUILD RANKINGS',
                      style: TextStyle(color: Colors.black)),
                ),
              ),

              SizedBox(height: 50),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor2),
                  ),
                  onPressed: () {
                    changeGuildPopUp(context);
                  },
                  child: Text(
                    'CHANGE GUILD',
                    style: TextStyle(color: color3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color3,
        foregroundColor: color1,
        child: Text('Back'),
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }

  Widget totalPointsSection = Container(
    // padding: EdgeInsets.all(10),
    child: Center(
      child: Text('Current Guild Points:',
          style: TextStyle(fontSize: 20, color: Colors.white)),
    ),
    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
  );

  void changeGuild() async {
    await FirebaseFirestore.instance.collection("users").doc(uID).update({
      'guild': guild,
    });
  }

  Future<String> changeGuildPopUp(BuildContext context) {
    TextEditingController gameLinkController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select your new guild"),
            content: Center(
                child: Column(children: <Widget>[
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
                  });
                },
                items: <String>[
                  'The Scarlet Authenticators',
                  'The Callback Crusade',
                  'The Microtask Ascendancy'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ])),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Send', style: TextStyle(fontSize: 23)),
                  onPressed: () {
                    setState(() {
                      guild = dropdownValue;
                    });
                    changeGuild();
                    Navigator.of(context)
                        .pop(gameLinkController.text.toString());
                  }),
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Cancel', style: TextStyle(fontSize: 23)),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(gameLinkController.text.toString());
                  })
            ],
          );
        });
  }
}

// this function fetches guild points live
Widget guildPointsGetter(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('guilds')
          .doc(guild)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var guildDocument = snapshot.data;
        return Text(guildDocument['totalPoints'].toString(),
            style: TextStyle(fontSize: 50, color: Colors.white));
      });
}

// this function fetches guild name live
Widget guildNameGetter(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('guilds')
          .doc(guild)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var guildDocument = snapshot.data;
        return Text(
          guildDocument['name'].toString(),
          style: TextStyle(fontSize: 30, color: Colors.white),
        );
      });
}
