import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../game_lobby/game_lobby.dart';
import '../../global_variables/global_variables.dart';
import 'package:provider/provider.dart';
import './game_image_utils.dart';
import './game_summary.dart';
import 'long_game_session.dart';
import './game_general_utils.dart';
import './game_content_short.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../game_over/game_over.dart';
import '../random_beggar/beggar.dart';
import '../loadingscreen/loading_before_gameMP.dart';

// SHORT ADVENTURE !!!!
// game variables
bool hasPlayed = false;
var questionNumber = 0;
var buttonNumber = 0;

// variable that holds game object:
// var game = new GameContent();

// Game widget class
class GameSession extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GameSessionState();
  }
}

// Game widget state
class GameSessionState extends State<GameSession> {
  int counter = 10;
  Timer readyTimer;
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    // update game content when Game is initiated!!
    startTimer();
    setPlayers();
    setPartyWisdom();
  }

  void startTimer() {
    // if (readyTimer != null) {
    //   readyTimer.cancel();
    //   readyTimer.cancel();
    // }
    readyTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        setState(() {
          if (counter > 0) {
            counter--;
          } else {
            // readyTimer.cancel();
            updateQuestion();
            setPlayerFalse();
            counter = 10;
          }
        });
      }
    });
  }

  Widget build(BuildContext context) {
    if (true) {
      // return QuestShort();
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            // body
            body: new Container(
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10.0)),
                    // top row that displays question number and current score
                    Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$counter',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text(
                                "Question ${questionNumber + 1}",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "Your score: $finalScore",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "Party Health:",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              partyHealthModifier(context),
                            ])),
                    gameOverStream(context),

                    Padding(padding: EdgeInsets.all(5.0)),

                    // image
                    Image.asset('assets/${gameShort.images[questionNumber]}.png',
                        height: 200),

                    Padding(padding: EdgeInsets.all(5.0)),

                    // question
                    Text(
                      gameShort.questions[questionNumber],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),

                    // answers
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // button 1
                          MaterialButton(
                            minWidth: 250.0,
                            padding: EdgeInsets.all(0),
                            color: Colors.blue,
                            onPressed: () {
                              if (hasPlayed == false) {
                                if (gameShort.choices[questionNumber][0] ==
                                    gameShort.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  incrementPlayerPoints();

                                  finalScore++;
                                  setPlayerTrue();
                                } else {
                                  decreasePartyHealth();
                                  debugPrint('oh noes... that is incorrect');
                                }
                                hasPlayed = true;
                              }
                              hasPlayed = true;
                              // updateQuestion();
                            },
                            child: Text(
                              gameShort.choices[questionNumber][0],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // button 2
                          MaterialButton(
                            minWidth: 250.0,
                            color: Colors.blue,
                            onPressed: () {
                              if (hasPlayed == false) {
                                if (gameShort.choices[questionNumber][1] ==
                                    gameShort.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  incrementPlayerPoints();

                                  finalScore++;
                                  setPlayerTrue();
                                } else {
                                  decreasePartyHealth();
                                  debugPrint('oh noes... that is incorrect');
                                }
                                hasPlayed = true;
                              }

                              // updateQuestion();
                            },
                            child: Text(
                              gameShort.choices[questionNumber][1],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // button 3
                          MaterialButton(
                            minWidth: 250.0,
                            color: Colors.blue,
                            onPressed: () {
                              if (hasPlayed == false) {
                                if (gameShort.choices[questionNumber][2] ==
                                    gameShort.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  incrementPlayerPoints();
                                  finalScore++;
                                  setPlayerTrue();
                                } else {
                                  decreasePartyHealth();
                                  debugPrint('oh noes... that is incorrect');
                                }
                                hasPlayed = true;
                              }

                              // updateQuestion();
                            },
                            child: Text(
                              gameShort.choices[questionNumber][2],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // button 4
                          MaterialButton(
                            minWidth: 250.0,
                            color: Colors.blue,
                            onPressed: () {
                              if (hasPlayed == false) {
                                if (gameShort.choices[questionNumber][3] ==
                                    gameShort.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  incrementPlayerPoints();
                                  finalScore++;
                                  setPlayerTrue();
                                } else {
                                  decreasePartyHealth();
                                  debugPrint('oh noes... that is incorrect');
                                }
                                hasPlayed = true;
                              }

                              // updateQuestion();
                            },
                            child: Text(
                              gameShort.choices[questionNumber][3],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),

                    Padding(
                      padding: EdgeInsets.all(5),
                    ),

                    // reset button
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          color: Colors.deepPurple,
                          minWidth: 240.0,
                          height: 30.0,
                          onPressed: () {
                            // removePlayer();
                            resetGame();
                            // Navigator.pushNamed(context, '/homepage');
                          },
                          child: Text(
                            "Quit",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                )),
          ));
    }
  }

  void setPlayers() async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc(gameID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        player1db = documentSnapshot.data()['player1'];
        player2db = documentSnapshot.data()['player2'];
        player3db = documentSnapshot.data()['player3'];
        player4db = documentSnapshot.data()['player4'];
      } else {
        print('document snapshot doesnt exist!');
      }
    });
  }

  void setPartyWisdom() async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc(gameID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        partyWisdom = documentSnapshot.data()['partyWisdom'];
        print('party wisdom is $partyWisdom');
      } else {
        print('document snapshot doesnt exist!');
      }
    });
  }

  void incrementPlayerPoints() async {
    await databaseReference.collection("games").doc(gameID).update({
      if (player1db == username)
        'player1Points': FieldValue.increment(1)
      else if (player2db == username)
        'player2Points': FieldValue.increment(1)
      else if (player3db == username)
        'player3Points': FieldValue.increment(1)
      else if (player4db == username)
        'player4Points': FieldValue.increment(1)
    });
  }

  void setPlayerTrue() async {
    await databaseReference.collection("games").doc(gameID).update({
      if (player1db == username)
        'player1isCorrect': true
      else if (player2db == username)
        'player2isCorrect': true
      else if (player3db == username)
        'player3isCorrect': true
      else if (player4db == username)
        'player4isCorrect': true
    });
  }

  void setPlayerFalse() async {
    await databaseReference.collection("games").doc(gameID).update({
      'player1isCorrect': false,
      'player2isCorrect': false,
      'player3isCorrect': false,
      'player4isCorrect': false,
    });
  }

  void decreasePartyHealth() async {
    await databaseReference.collection("games").doc(gameID).update({
      'partyHealth': FieldValue.increment(-1),
    });
  }

  void removePlayer() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference playerCheck =
          FirebaseFirestore.instance.collection('games').doc(gameID);
      DocumentSnapshot snapshot = await transaction.get(playerCheck);
      player1db = snapshot.data()['player1'];
      player2db = snapshot.data()['player2'];
      player3db = snapshot.data()['player3'];
      player4db = snapshot.data()['player4'];
      if (player1db == username) {
        await transaction.delete(playerCheck);
      } else if (player2db == username) {
        await transaction
            .update(playerCheck, {'player2': "", 'player2Class': ""});
      } else if (player3db == username) {
        await transaction
            .update(playerCheck, {'player3': "", 'player3Class': ""});
      } else if (player4db == username) {
        await transaction
            .update(playerCheck, {'player4': "", 'player4Class': ""});
      }
    });
  }

// resetting question/answer screen
  void resetGame() {
    setState(() {
      // close current screen:
      Navigator.pop(context);
      // reset variables:
      finalScore = 0;
      questionNumber = 0;
    });
  }

// changing to new question OR go to leaderboard if last question
  void updateQuestion() {
    setState(() {
      if (questionNumber == gameShort.questions.length - 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Summary(score: finalScore)));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Beggar()));
        hasPlayed = false;
        readyTimer.cancel();

      } else {
        questionNumber++;
        hasPlayed = false;
      }
    });
  }



  // This stream checks party health and goes to game over screen
  Widget gameOverStream(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('games')
            .doc(gameID)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          if (snapshot.data['partyHealth'] == 0) {
            readyTimer.cancel();
            Navigator.pushNamed(context, '/gameOver');
            return Text(
              "",
              style: TextStyle(fontSize: 1),
            );
          } else {
            return Text(
              '',
              style: TextStyle(fontSize: 1),
            );
          }
        });
  }
}
