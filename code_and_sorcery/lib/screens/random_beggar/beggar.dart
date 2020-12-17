import 'package:flutter/material.dart';
import 'dart:math';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

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
          decoration: BoxDecoration(
            color: color1,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      "An old man approaches you...",
                      style: TextStyle(fontSize: 30, color: color3),
                    )),
                Padding(padding: EdgeInsets.all(10)),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "He asks for some points to get him through the night...",
                      style: TextStyle(fontSize: 20, color: textBright),
                    )),
                SizedBox(height: 50),
                notEnoughText(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor3),
                      ),
                      child: Text(
                        "GIVE 2 POINTS",
                        style: TextStyle(fontSize: 20, color: textDark),
                      ),
                      onPressed: () {
                        if (finalScore >= 2) {
                          decreasePlayerPoints();
                          openChest();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor3),
                      ),
                      child: Text(
                        "LEAVE THE MAN ALONE",
                        style: TextStyle(fontSize: 20, color: textDark),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        )));
  }

  Widget notEnoughText() {
    return finalScore < 2
        ? Text(
            "You don't have enough points either!",
            style: TextStyle(
              fontSize: 16,
              color: textBright,
            ),
          )
        : Text(
            '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          );
  }

  void openChest() {
    if (isOpened) {
      Navigator.pop(context);
    }
    if (diceRoll <= partyWisdom) {
      setState(() {
        finalScore += 4;
      });
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
    setState(() {
      finalScore -= 2;
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
