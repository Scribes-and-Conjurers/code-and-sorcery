import 'package:flutter/material.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

class SuccessBeggar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      height: 200,
                    ),
                    Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "Amazing! He returned and gifts you double what you donated!",
                          style: TextStyle(fontSize: 20, color: textBright),
                        )),
                    Padding(padding: EdgeInsets.all(20.0)),
                    SizedBox(
                      height: 40,
                      width: 300,
                      child: SizedBox(
                        height: 40,
                        width: 300,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith(getColor3),
                          ),
                          child: Text("CONTINUE ADVENTURE",
                              style: TextStyle(fontSize: 18, color: textDark)),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
