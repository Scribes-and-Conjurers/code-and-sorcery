import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class Guild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Guild'),
      ),
      body: Column(
        children: [
          guildNameSection,
          totalPointsSection,
          userRanking,
          guildRanking,
          changeGuildButton,
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
        Text('[76,432]', style: TextStyle(fontSize: 20)),
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
          Text('12', style: TextStyle(fontSize: 20),),
        ],
      )
  );

  Widget guildRanking = Container(
      padding: EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Current Guild Global Rank:', style: TextStyle(fontSize: 20),),
          Text('1', style: TextStyle(fontSize: 20),),
        ],
      )
  );

  Widget changeGuildButton = Container(
    padding: EdgeInsets.all(30),
    child: Center(
      child: Column(
        children: [
          MaterialButton(
            onPressed: () {debugPrint('Changing Guild....');},
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
