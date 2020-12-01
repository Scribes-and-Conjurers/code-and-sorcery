import 'package:code_and_sorcery/screens/guild_view/guild_rankings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import 'change_guild.dart';

class Guild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Guild'),
      ),
      body: Column(
        children: [
          // guildNameSection,
          guildNameGetter(context),
          totalPointsSection,
          guildPointsGetter(context),
          // userRanking,
          // guildRanking,
          // guildRankGetter(context),
          ElevatedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeGuild()));
            },
            child: Text('Change Guild'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GuildRankings()));
            },
            child: Text('Guild Rankings'),
          ),
        ],
      ),
    );
  }

  Widget totalPointsSection = Container(
    padding: EdgeInsets.all(40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Current Guild Points:', style: TextStyle(fontSize: 20)),
        // Text('[76,432]', style: TextStyle(fontSize: 20)),
      ],
    ),
  );

  Widget guildNameSection = Container(
    padding: EdgeInsets.all(40),
    child: Center(
      child: Column(
        children: [
          Text('The Microtask Ascendancy', style: TextStyle(fontSize: 20),),
          Divider(thickness: 5,),
        ],
      ),
    ),
  );

  Widget userRanking = Container(
      padding: EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Your Current Rank:', style: TextStyle(fontSize: 20),),
          Text('1', style: TextStyle(fontSize: 20),),
        ],
      )
  );

  Widget guildRanking = Container(
      padding: EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Current Guild Global Rank:', style: TextStyle(fontSize: 20),),
          // Text('1', style: TextStyle(fontSize: 20),),
        ],
      )
  );

  Widget changeGuildButton = Container(
    padding: EdgeInsets.all(30),
    child: Center(
      child: Column(
        children: [
          MaterialButton(
            onPressed: () {
              // promptChangeGuild();
            },
            color: Colors.blueGrey,
            textColor: Colors.white,
            child: Text('Change Guild', style: TextStyle(fontSize: 20),),),
          Text(
              'Warning: changing your guild will reset your personal score',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
        ],
      ),
    ),
  );
}

// this function fetches guild points live
Widget guildPointsGetter(BuildContext context) {
  return StreamBuilder(
      stream:
      FirebaseFirestore.instance.collection('guilds').doc(guild).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var guildDocument = snapshot.data;
        return Text(
          guildDocument['totalPoints'].toString(),
          style: TextStyle(fontSize: 20),
        );
      });
}

// this function fetches guild name live
Widget guildNameGetter(BuildContext context) {
  return StreamBuilder(
      stream:
      FirebaseFirestore.instance.collection('guilds').doc(guild).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var guildDocument = snapshot.data;
        return Text(
          guildDocument['name'].toString(),
          style: TextStyle(fontSize: 20),
        );
      });
}

// this function fetches guild ranking live
Widget guildRankGetter(BuildContext context) {
  return StreamBuilder(
      stream:
      FirebaseFirestore.instance.collection('guilds').doc(guild).snapshots(),
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

