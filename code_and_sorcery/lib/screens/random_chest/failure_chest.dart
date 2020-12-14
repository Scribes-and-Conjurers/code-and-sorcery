import 'package:flutter/material.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

class FailureChest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "The chest was filled with poison gas!",
                  style: TextStyle(fontSize: 20, color: textBright),
                )),
            Text(
              "You barely escaped...",
              style: TextStyle(fontSize: 20, color: textBright),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
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
                )),
          ],
        ),
      ),
    ));
  }
}
