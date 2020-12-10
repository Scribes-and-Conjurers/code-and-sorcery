import 'package:flutter/material.dart';

class SuccessBeggar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text(
              "Amazing! He returns an hour later and gifts you three times what you donated!"),
          ElevatedButton(
            child: Text("Continue Adventure"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    ));
  }
}
