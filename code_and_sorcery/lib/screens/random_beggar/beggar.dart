import 'package:flutter/material.dart';
import 'dart:math';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Beggar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BeggarState();
}

class _BeggarState extends State<Beggar> {
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
            body: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "An old man approaches you...",
                      style: TextStyle(fontSize: 20),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "He asks for coins to get him through the night...",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(height: 50),
                Text((() {
                  if (finalScore < 2) {
                    return "You don't have enough points either!";
                  } else {
                    return '';
                  }
                })()),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    child: Text(
                      "Give 2 points",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (finalScore > 2) {
                        finalScore -= 2;
                        decreasePlayerPoints();
                        openChest();
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    child: Text(
                      "Leave the beggar alone",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        )));
  }

  void openChest() {
    debugPrint('$partyWisdom');
    if (isOpened) {
      Navigator.pop(context);
    }
    if (diceRoll <= partyWisdom) {
      finalScore += 4;
      increasePlayerPoints();
      Navigator.pushNamed(context, '/successBeggar');
    } else {
      Navigator.pushNamed(context, '/failureBeggar');
    }
  }

  void decreasePlayerPoints() async {
    await databaseReference.collection("games").doc(gameID).update({
      if (player1db == username)
        'player1Points': FieldValue.increment(-2)
      else if (player2db == username)
        'player2Points': FieldValue.increment(-2)
      else if (player3db == username)
        'player3Points': FieldValue.increment(-2)
      else if (player4db == username)
        'player4Points': FieldValue.increment(-2)
      else
        'player1Points': FieldValue.increment(-2)
    });
  }

  void increasePlayerPoints() async {
    await databaseReference.collection("games").doc(gameID).update({
      if (player1db == username)
        'player1Points': FieldValue.increment(4)
      else if (player2db == username)
        'player2Points': FieldValue.increment(4)
      else if (player3db == username)
        'player3Points': FieldValue.increment(4)
      else if (player4db == username)
        'player4Points': FieldValue.increment(4)
      else
        'player1Points': FieldValue.increment(4)
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
