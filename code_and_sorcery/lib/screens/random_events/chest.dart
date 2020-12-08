import 'package:flutter/material.dart';
import 'dart:math';

class Chest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChestState();
}

class _ChestState extends State<Chest> {
  bool isOpened = false;
  double diceRoll;

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    diceRoll = random.nextDouble();
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 200),
      child: Center(
        child: Column(
          children: [
            Text("A mysterious chest..."),
            Text("It whispers to you, promising riches..."),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                child: Text("Open the chest"),
                onPressed: () {
                  openChest();
                  Navigator.pop(context);
                },
              ),
            ),
            ElevatedButton(
                child: Text("Leave the chest alone"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    ));
  }
} //end of class

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
