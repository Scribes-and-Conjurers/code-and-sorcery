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
      body: Center(
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
    );
  }

  void openChest() {
    if (isOpened) {
      Navigator.pop(context);
    }
    if (diceRoll <= 0.4) {
      Navigator.pushNamed(context, '/successChest');
      // Scaffold(
      //   body: Center(
      //     child: Column(
      //       children: [
      //         Text("Amazing! The chest was filled with treasure!"),
      //         ElevatedButton(
      //           child: Text("Continue Adventure"),
      //           onPressed: () {
      //             Navigator.pop(context);
      //             Navigator.pop(context);
      //           },
      //         )
      //       ],
      //     ),
      //   ),
      // );
    } else {
      Navigator.pushNamed(context, '/failureChest');
      // return Scaffold(
      //   body: Center(
      //     child: Column(
      //       children: [
      //         Text("The chest is filled with poison gas! You barely escape."),
      //         ElevatedButton(
      //           child: Text("Continue Adventure"),
      //           onPressed: () {
      //             Navigator.pop(context);
      //             Navigator.pop(context);
      //           },
      //         )
      //       ],
      //     ),
      //   ),
      // );
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
