import 'package:code_and_sorcery/screens/homepage/colors.dart';
import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

class GameSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GameSettingState();
  }
}

class GameSettingState extends State<GameSettings> {
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: color1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 0),
              Text(
                'Difficulty',
                style: TextStyle(
                  fontSize: 24,
                  color: textBright,
                ),
              ),
              SizedBox(height: 12),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    easyButton(),
                    normalButton(),
                  ]),
              SizedBox(height: 64),
              Text(
                'Adventure Length',
                style: TextStyle(
                  fontSize: 24,
                  color: textBright,
                ),
              ),
              SizedBox(height: 12),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    shortButton(),
                    longButton(),
                  ]),
              Padding(padding: EdgeInsets.all(40.0)),
              SizedBox(height: 60),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor3),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: textDark,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setDifficulty(String difficulty) async {
    await databaseReference
        .collection("games")
        .doc(gameID)
        .update({'gameDifficulty': difficulty});
  }

  void setGameLength(String difficulty) async {
    await databaseReference
        .collection("games")
        .doc(gameID)
        .update({'gameLength': adventureLength});
  }

  Widget easyButton() {
    return difficulty == 'Easy'
        ? Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              color: Colors.orange[600],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  difficulty = 'Easy';
                });
              },
              child: Text(
                'Easy',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.orange[200],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  difficulty = 'Easy';
                });
              },
              child: Text(
                'Easy',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
  }

  Widget normalButton() {
    return difficulty == 'Normal'
        ? Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              color: Colors.orange[600],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  difficulty = 'Normal';
                });
              },
              child: Text(
                'Normal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.orange[200],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  difficulty = 'Normal';
                });
              },
              child: Text(
                'Normal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
  }

  Widget shortButton() {
    return adventureLength == 'Short'
        ? Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              color: Colors.orange[600],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  adventureLength = 'Short';
                });
              },
              child: Text(
                'Short',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.orange[200],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  adventureLength = 'Short';
                });
              },
              child: Text(
                'Short',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
  }

  Widget longButton() {
    return adventureLength == 'Long'
        ? Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              color: Colors.orange[600],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  adventureLength = 'Long';
                });
              },
              child: Text(
                'Long',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.orange[200],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  adventureLength = 'Long';
                });
              },
              child: Text(
                'Long',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
  }
}
