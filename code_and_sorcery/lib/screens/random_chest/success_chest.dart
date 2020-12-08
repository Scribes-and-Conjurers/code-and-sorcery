import 'package:flutter/material.dart';

class SuccessChest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: [
          Text(
              "Amazing! The chest was filled with treasure! You stuff your pockets."),
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
