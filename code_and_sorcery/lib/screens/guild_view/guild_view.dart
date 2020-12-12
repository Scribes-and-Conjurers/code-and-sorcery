import 'package:code_and_sorcery/screens/guild_view/guild_rankings.dart';
import 'package:code_and_sorcery/screens/guild_view/user_rankings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import 'change_guild.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

class Guild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Your Guild'),
      // ),
      body: Container(
        decoration: BoxDecoration(
          color: color2,
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [Colors.blue[100], Colors.blue[400]],
          // ),
        ),
        child: Center(
          child: Column(
            children: [
              // guildNameSection,
              Padding(padding: EdgeInsets.all(40.0)),
              guildNameGetter(context),
              Padding(padding: EdgeInsets.all(30.0)),
              totalPointsSection,
              Padding(padding: EdgeInsets.all(16.0)),
              guildPointsGetter(context),
              // userRanking,
              // guildRanking,
              // guildRankGetter(context),
              SizedBox(height: 60),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor4),
                  ),
                  onPressed: () {
                    // Navigate back to the first screen by popping the current route
                    // off the stack.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRankings()));
                  },
                  child: Text(' User Rankings'),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor2),
                  ),
                  onPressed: () {
                    // Navigate back to the first screen by popping the current route
                    // off the stack.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuildRankings()));
                  },
                  child: Text('Guild Rankings'),
                ),
              ),

              SizedBox(height: 70),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(getColor1),
                ),
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChangeGuild()));
                },
                child: Text(
                  'Change Guild',
                  style: TextStyle(color: color3),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color1,
        foregroundColor: color3,
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
      child: Column(
        children: [
          Text('Current Guild Points:',
              style: TextStyle(fontSize: 20, color: color1)),
          // Text('[76,432]', style: TextStyle(fontSize: 20)),
        ],
      ),
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ),
  );

  Widget guildNameSection = Container(
    padding: EdgeInsets.all(40),
    child: Center(
      child: Column(
        children: [
          Text(
            'The Microtask Ascendancy',
            style: TextStyle(fontSize: 20, color: color1),
          ),
          Divider(
            thickness: 5,
          ),
        ],
      ),
    ),
  );

  Widget userRanking = Container(
      padding: EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your Current Rank:',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '1',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ));

  Widget guildRanking = Container(
      padding: EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Current Guild Global Rank:',
            style: TextStyle(fontSize: 20, color: color1),
          ),
          // Text('1', style: TextStyle(fontSize: 20),),
        ],
      ));

  Widget changeGuildButton = Container(
    padding: EdgeInsets.all(30),
    child: Center(
      child: Column(
        children: [
          MaterialButton(
            onPressed: () {
              // changeGuildPopUp(context);
            },
            color: Colors.blueGrey,
            textColor: Colors.white,
            child: Text(
              'Change Guild',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text('Warning: changing your guild will reset your personal score',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
        ],
      ),
    ),
  );

  void changeGuild() async {
    await FirebaseFirestore.instance.collection("users").doc(uID).update({
      'guild': dropdownValue,
    });
  }

  Future<String> changeGuildPopUp(BuildContext context) {
    TextEditingController gameLinkController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select your new guild"),
            content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
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
                  // setState(() {
                  dropdownValue = newValue;
                  guild = dropdownValue;
                  // }
                  // );
                },
                items: <String>['Backenders', 'Frontenders', 'Fullstackers']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ])),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Send', style: TextStyle(fontSize: 23)),
                  onPressed: () {
                    changeGuild();
                    Navigator.of(context)
                        .pop(gameLinkController.text.toString());
                  })
            ],
          );
        });
  }
}

Future<String> changeGuildPopUp(BuildContext context) {
  TextEditingController gameLinkController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select your new guild"),
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
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
                // setState(() {
                dropdownValue = newValue;
                guild = dropdownValue;
                // });
              },
              items: <String>['Backenders', 'Frontenders', 'Fullstackers']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ])),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: Text('Send', style: TextStyle(fontSize: 23)),
                onPressed: () {
                  // changeGuild();
                  Navigator.of(context).pop(gameLinkController.text.toString());
                })
          ],
        );
      });
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
        return Text(
          guildDocument['totalPoints'].toString(),
          style: TextStyle(fontSize: 20, color: color1),
        );
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
          style: TextStyle(fontSize: 20, color: color1),
        );
      });
}

// this function fetches guild ranking live
Widget guildRankGetter(BuildContext context) {
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
          guildDocument['guildRanking'].toString(),
          style: TextStyle(fontSize: 20),
        );
      });
}
