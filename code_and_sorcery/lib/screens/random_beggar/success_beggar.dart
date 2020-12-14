import 'package:flutter/material.dart';

class SuccessBeggar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  "Amazing! He returned and gifts you double what you donated!",
                  style: TextStyle(fontSize: 20),
                )),
            ElevatedButton(
              child: Text("Continue Adventure"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ))),
    );
  }
}
