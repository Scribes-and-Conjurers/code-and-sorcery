import 'package:flutter/material.dart';

class SuccessChest extends StatelessWidget {
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
                    Text(
                      "Amazing! The chest was filled with treasure! You stuff your pockets.",
                      style: TextStyle(fontSize: 30),
                    ),
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
