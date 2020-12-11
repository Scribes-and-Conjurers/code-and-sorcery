import 'package:flutter/material.dart';

class FailureBeggar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  "The beggar never came back...",
                  style: TextStyle(fontSize: 25),
                )),
            Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  "You lost your hard-earned coins",
                  style: TextStyle(fontSize: 25),
                )),
            ElevatedButton(
              child: Text(
                "Continue Adventure",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ));
  }
}
