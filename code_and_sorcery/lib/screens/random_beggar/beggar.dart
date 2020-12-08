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
      padding: EdgeInsets.symmetric(vertical: 200),
      child: Center(
        child: Column(
          children: [
            Text("An old man approaches you..."),
            Text("He asks for coins to get him through the night..."),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                child: Text("Give 2 points"),
                onPressed: () {
                  openChest();
                },
              ),
            ),
            ElevatedButton(
                child: Text("Leave the beggar alone"),
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
      Navigator.pushNamed(context, '/failureBeggar');
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
