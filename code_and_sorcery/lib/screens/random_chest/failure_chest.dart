import 'package:flutter/material.dart';

class FailureChest extends StatelessWidget {
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
                      "The chest was filled with poison gas!",
                      style: TextStyle(fontSize: 20),
                    )),
                Text(
                  "You barely escaped...",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      child: Text(
                        "Continue Adventure",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )),
              ],
            ),
          ),
        )));
  }
}
