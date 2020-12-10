import 'package:flutter/material.dart';

class FailureBeggar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
                "The beggar never came back...you lost your hard-earned point"),
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
    );
  }
}
