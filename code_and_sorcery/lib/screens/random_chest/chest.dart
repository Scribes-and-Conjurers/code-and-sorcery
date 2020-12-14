import 'package:flutter/material.dart';
import 'dart:math';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChestState();
}

class _ChestState extends State<Chest> {
  final databaseReference = FirebaseFirestore.instance;
  bool isOpened = false;
  double diceRoll;

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    diceRoll = random.nextDouble();
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                "A mysterious chest...",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "It whispers to you, promising riches...",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  child: Text(
                    "Open the chest",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    openChest();
                  },
                ),
              ),
              ElevatedButton(
                  child: Text(
                    "Leave the chest alone",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  void openChest() {
    if (isOpened) {
      Navigator.pop(context);
    }
    if (diceRoll <= partyWisdom) {
      setState(() {
        finalScore += 2;
      });
      increasePlayerPoints();
      Navigator.pushNamed(context, '/successChest');
    } else {
      Navigator.pushNamed(context, '/failureChest');
    }
  }

  void increasePlayerPoints() async {
    await databaseReference.collection("games").doc(gameID).update({
      if (player1db == username)
        'player1Points': FieldValue.increment(2)
      else if (player2db == username)
        'player2Points': FieldValue.increment(2)
      else if (player3db == username)
        'player3Points': FieldValue.increment(2)
      else if (player4db == username)
        'player4Points': FieldValue.increment(2)
      else
        'player1Points': FieldValue.increment(2)
    });
  }
}

/*

How to do probability checks:

rand = randDouble(); // returns double between 0.0 -> 1.0
if(rand <= 0.3) {
  //success
  Text("You got points!")
} else {
  //failure
  Text("The chest had spoiled bacon")
}
*/
