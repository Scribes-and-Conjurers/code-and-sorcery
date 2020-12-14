import 'package:flutter/material.dart';
import 'dart:math';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

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
        decoration: BoxDecoration(
          color: color1,
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                "A mysterious chest...",
                style: TextStyle(fontSize: 30, color: color3),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "It whispers to you, promising riches...",
                style: TextStyle(fontSize: 20, color: textBright),
              ),
              Padding(padding: EdgeInsets.all(20)),
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
                      "OPEN THE CHEST",
                      style: TextStyle(fontSize: 20, color: textDark),
                    ),
                    onPressed: () {
                      openChest();
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
                      "LEAVE THE CHEST ALONE",
                      style: TextStyle(fontSize: 20, color: textDark),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
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
      finalScore += 2;
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
