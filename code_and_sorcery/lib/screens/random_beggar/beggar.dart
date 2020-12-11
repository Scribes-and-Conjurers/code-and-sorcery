import 'package:flutter/material.dart';
import 'dart:math';

class Beggar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BeggarState();
}

class _BeggarState extends State<Beggar> {
  bool isOpened = false;
  double diceRoll;

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    diceRoll = random.nextDouble();
    return Scaffold(
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                child: Text(
                  "Give 2 points",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  openChest();
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
    ));
  }

  void openChest() {
    if (isOpened) {
      Navigator.pop(context);
    }
    if (diceRoll <= 0.4) {
      Navigator.pushNamed(context, '/successBeggar');
    } else {
      Navigator.pushNamed(context, '/failureBeggar');
    }
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
