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
              Container(
                height: 64,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.orange,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.transparent),
                  onPressed: () {
                    switch (difficulty) {
                      case 'Normal':
                        {
                          setState(() {
                            difficulty = 'Easy';
                            setDifficulty(difficulty);
                            print('easy');
                          });
                        }
                        break;
                      case 'Easy':
                        {
                          setState(() {
                            difficulty = 'Normal';
                            setDifficulty(difficulty);
                            print('normal');
                          });
                        }
                        break;
                    }
                  },
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
              Text(
                'Adventure Length',
                style: TextStyle(
                  fontSize: 24,
                  color: textBright,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 64,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.orange,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.transparent),
                  onPressed: () {
                    switch (adventureLength) {
                      case 'Short':
                        {
                          setState(() {
                            adventureLength = 'Long';
                            setGameLength(adventureLength);
                            print('Long');
                          });
                        }
                        break;
                      case 'Long':
                        {
                          setState(() {
                            adventureLength = 'Short';
                            setGameLength(adventureLength);
                            print('Short');
                          });
                        }
                        break;
                    }
                  },
                  child: Text(
                    adventureLength,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(40.0)),
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
}
