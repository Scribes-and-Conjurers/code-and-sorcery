import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
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
                  color: Colors.black,
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
                    }
                  },
                  child: Text(difficulty,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),),
                ),
              ),
              SizedBox(height: 48),
              Text(
                'Adventure Length',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
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
                    }
                  },
                  child: Text(adventureLength,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setDifficulty(String difficulty) async {
    await databaseReference.collection("games").doc(gameID).update({
        'gameDifficulty': difficulty
    });
  }

  void setGameLength(String difficulty) async {
    await databaseReference.collection("games").doc(gameID).update({
      'gameLength': adventureLength
    });
  }
}
