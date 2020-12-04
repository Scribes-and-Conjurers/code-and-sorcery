import 'dart:async';
import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import '../game_lobby/game_lobby.dart';
import '../../global_variables/global_variables.dart';
import 'package:provider/provider.dart';
import '../game_lobby/game_lobby.dart';
import './game_image_utils.dart';
import './game_summary.dart';
import 'long_game_session.dart';
import './game_general_utils.dart';
import './game_content_short.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// SHORT ADVENTURE !!!!

var player1Score = 0;
var player2Score = 0;
// int counter = 10;
// Timer questionTimer;

// game variables
var finalScore = 0;
var questionNumber = 0;
var buttonNumber = 0;

// variable that holds game object:
var game = new GameContent();

// Game widget class
class Game1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Game1State();
  }
}

// Game widget state
class Game1State extends State<Game1> {
  final databaseReference = FirebaseFirestore.instance;
  // void startTimer() {
  //   counter = 10;
  //   if (questionTimer != null) {
  //     questionTimer.cancel();
  //   }
  //   questionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (counter > 0) {
  //         counter--;
  //       } else {
  //         questionTimer.cancel();
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    // update game content when Game is initiated!!
    updateGameContent('JIfrv2SOOdlxkv5RJP3i');
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // (counter > 0)
                                  //     ? Text("")
                                  //     : Text("OVER",
                                  //         style: TextStyle(color: Colors.red)),
                                  // Text('$counter',
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 48)),
                                  Text(
                                    "Question ${questionNumber + 1}",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  Text(
                                    "Score: $finalScore",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  Text(
                                    "Party Health:",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  partyHealthModifier(context),
                                ])),

                        Padding(padding: EdgeInsets.all(5.0)),

                        // image
                        FutureBuilder(
                            future: getImage(
                                context, "${game.images[questionNumber]}.png"),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  width: MediaQuery.of(context).size.width / 1,
                                  height:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: snapshot.data,
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    height:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator(),
                                    ));
                              }
                              return SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(),
                              );
                            }),

                        Padding(padding: EdgeInsets.all(5.0)),

                        // question
                        Text(
                          game.questions[questionNumber],
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
                                  if (game.choices[questionNumber][0] ==
                                      game.correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    finalScore++;
                                    if (player1 == username) {
                                      player1Score++;
                                      updateGamePlayer1();
                                    } else {
                                      player2Score++;
                                      updateGamePlayer2();
                                    }
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  game.choices[questionNumber][0],
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
                                  if (game.choices[questionNumber][1] ==
                                      game.correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    // startTimer();
                                    finalScore++;
                                    if (player1 == username) {
                                      player1Score++;
                                      updateGamePlayer1();
                                    } else {
                                      player2Score++;
                                      updateGamePlayer2();
                                    }
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  game.choices[questionNumber][1],
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
                                  if (game.choices[questionNumber][2] ==
                                      game.correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    finalScore++;
                                    if (player1 == username) {
                                      player1Score++;
                                      updateGamePlayer1();
                                    } else {
                                      player2Score++;
                                      updateGamePlayer2();
                                    }
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  game.choices[questionNumber][2],
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
                                  if (game.choices[questionNumber][3] ==
                                      game.correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    finalScore++;
                                    if (player1 == username) {
                                      player1Score++;
                                      updateGamePlayer1();
                                    } else {
                                      player2Score++;
                                      updateGamePlayer2();
                                    }
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  game.choices[questionNumber][3],
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
                                resetGame();
                              },
                              child: Text(
                                "Quit",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ]))));
    }
  }

  void decreasePartyHealth() async {
    await databaseReference.collection("games").doc(gameLinkValue).update({
      'partyHealth': FieldValue.increment(-1),
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
      player1Score = 0;
      player2Score = 0;
      isMultiplayer = true;
    });
  }

// changing to new question OR go to leaderboard if last question
  void updateQuestion() {
    setState(() {
      if (questionNumber == game.questions.length - 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Summary(score: finalScore)));
      } else {
        questionNumber++;
      }
    });
  }

  void updateGameContent(String questName) async {
    await FirebaseFirestore.instance
        .collection('ready-quests')
        .doc(questName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // define questions
        game.questions = documentSnapshot.data()['questions'];

        // define choices for each question
        game.choices0 = documentSnapshot.data()['choices1'];
        game.choices1 = documentSnapshot.data()['choices2'];
        game.choices2 = documentSnapshot.data()['choices3'];
        game.choices3 = documentSnapshot.data()['choices4'];

        // put all four choices arrays in one main array
        game.choices = [
          game.choices0,
          game.choices1,
          game.choices2,
          game.choices3
        ];

        // define answers
        game.correctAnswers = documentSnapshot.data()['answers'];
        print('answers: ${game.correctAnswers}');
      }
    });
  }

  void updateGamePlayer1() async {
    await databaseReference.collection("games").doc(gameLinkValue).update({
      'player1Points': FieldValue.increment(1),
    });
  }

  void updateGamePlayer2() async {
    await databaseReference.collection("games").doc(gameLinkValue).update({
      'player2Points': FieldValue.increment(1),
    });
  }

  void updateGamePlayer3() async {
    await databaseReference.collection("games").doc(gameLinkValue).update({
      'player3Points': FieldValue.increment(1),
    });
  }

  void updateGamePlayer4() async {
    await databaseReference.collection("games").doc(gameLinkValue).update({
      'player4Points': FieldValue.increment(1),
    });
  }
}
