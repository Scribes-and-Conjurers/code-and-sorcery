import 'package:flutter/material.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

class SuccessChest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: color1,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Text(
                      "Amazing! The chest was filled with treasure!",
                      style: TextStyle(fontSize: 30, color: color3),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      "You stuff your pockets.",
                      style: TextStyle(fontSize: 20, color: textBright),
                    ),
                    Padding(padding: EdgeInsets.all(30)),
                    SizedBox(
                      height: 40,
                      width: 300,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith(getColor3),
                        ),
                        child: Text(
                          "CONTINUE ADVENTURE",
                          style: TextStyle(fontSize: 20, color: textDark),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
