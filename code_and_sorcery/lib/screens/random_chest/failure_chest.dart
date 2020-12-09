import 'package:flutter/material.dart';

class FailureChest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Center(
        child: Column(
          children: [
            Text("The chest was filled with poison gas! You barely escaped."),
            ElevatedButton(
              child: Text("Continue Adventure"),
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
