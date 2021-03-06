import 'dart:async';
import 'dart:collection';
import 'package:code_and_sorcery/screens/random_beggar/beggar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
// import '../game_lobby/game_lobby.dart';
import 'package:provider/provider.dart';
//
import './game_image_utils.dart';
import './game_content_long.dart';
import './game_summary.dart';
import './game_general_utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../random_chest/chest.dart';
import '../random_beggar/beggar.dart';
import '../loadingscreen/loading_before_game.dart';
import '../homepage/colors.dart';

// LONG ADVENTURE !!! built for singleplayer

var player1Score = 0;
var player2Score = 0;

// game variables
var questionNumber = 0;
var buttonNumber = 0;
var longQuestion = true;

class QuestLong extends StatefulWidget {
  @override
  _QuestLongState createState() => _QuestLongState();
}

class _QuestLongState extends State<QuestLong> {
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    questionNumber = 0;
    buttonNumber = 0;
    setPartyWisdom();
  }

  Widget build(BuildContext context) {
    if (longQuestion) {
      // return long version (4 buttons)
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(

              // body
              body: new Container(
                  decoration: BoxDecoration(
                    color: color2,
                  ),
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: ListView(shrinkWrap: true,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(10.0)),

                            // top row that displays question number and current score
                            Container(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                alignment: Alignment.centerRight,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Question ${questionNumber + 1}",
                                        style: TextStyle(
                                            fontSize: 15.0, color: textBright),
                                      ),
                                      soloPointsStream(context),
                                      Text(
                                        "Party Health:",
                                        style: TextStyle(
                                            fontSize: 15.0, color: textBright),
                                      ),
                                      partyHealthModifierSolo(context),
                                    ])),

                            Padding(padding: EdgeInsets.all(5.0)),

                            // image
                            Image.asset(
                                'assets/${game.images[questionNumber]}.png',
                                height: 200),

                            Padding(padding: EdgeInsets.all(15.0)),

                            // question
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                game.questions[questionNumber],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: textBright,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(15.0),
                            ),

                            // answers: conditional depending on question
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  // button 1
                                  SizedBox(
                                    width: 270,
                                    child: MaterialButton(
                                      // minWidth: 250.0,
                                      padding: EdgeInsets.all(10.0),
                                      color: color3,
                                      onPressed: () {
                                        if (game.choices[questionNumber][0] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          finalScore++;
                                          updateGamePlayer1();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
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
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(7.0),
                                  ),

                                  // button 2
                                  SizedBox(
                                    width: 270,
                                    child: MaterialButton(
                                      // minWidth: 250.0,
                                      padding: EdgeInsets.all(10.0),
                                      color: color3,
                                      onPressed: () {
                                        if (game.choices[questionNumber][1] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          finalScore++;
                                          updateGamePlayer1();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
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
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(7.0),
                                  ),

                                  // button 3
                                  SizedBox(
                                    width: 270,
                                    child: MaterialButton(
                                      padding: EdgeInsets.all(10.0),
                                      // minWidth: 250.0,
                                      color: color3,
                                      onPressed: () {
                                        if (game.choices[questionNumber][2] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          finalScore++;
                                          updateGamePlayer1();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
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
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(7.0),
                                  ),

                                  // button 4
                                  SizedBox(
                                    width: 270,
                                    child: MaterialButton(
                                      padding: EdgeInsets.all(10.0),
                                      // minWidth: 250.0,
                                      color: color3,
                                      onPressed: () {
                                        if (game.choices[questionNumber][3] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          finalScore++;
                                          updateGamePlayer1();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
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
                                  ),
                                ]),

                            Padding(
                              padding: EdgeInsets.all(10),
                            ),

                            // reset button
                            Container(
                                alignment: Alignment.bottomCenter,
                                child: MaterialButton(
                                  color: color4,
                                  minWidth: 240.0,
                                  height: 30.0,
                                  onPressed: () {
                                    resetGame();
                                  },
                                  child: Text(
                                    "Quit",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: textBright,
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                          ]),
                    ),
                  ))));
    } else {
      //SHORT question format
      // return true or false question
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
                                  partyHealthModifierSolo(context),
                                ])),

                        Padding(padding: EdgeInsets.all(5.0)),

                        // image
                        Image.asset('assets/${game.images[questionNumber]}.png',
                            height: 200),

                        Padding(padding: EdgeInsets.all(15.0)),

                        // question
                        Text(
                          game.questions[questionNumber],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0, color: textBright),
                        ),

                        Padding(
                          padding: EdgeInsets.all(15.0),
                        ),

                        // answers: conditional depending on question
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
                                    updateGamePlayer1();
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
                                    finalScore++;
                                    updateGamePlayer1();
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

  void decreasePartyHealth() async {
    await databaseReference.collection("games").doc(gameID).update({
      'partyHealth': FieldValue.increment(-1),
    });
  }

// resetting question/answer screen
  void resetGame() {
    setState(() {
      // close current screen:
      // Navigator.pop(context);
      // reset variables:
      finalScore = 0;
      questionNumber = 0;
      Navigator.pushNamed(context, '/homepage');
    });
  }

// changing to new question OR go to leaderboard if last question
  void updateQuestion() {
    if (game is GameContentLongTF) {
      if ((questionNumber) == 1 ||
          (questionNumber) == 3 ||
          (questionNumber) == 7) {
        longQuestion = false;
      } else {
        longQuestion = true;
      }
    }
    setState(() {
      if (questionNumber == 2) {
        questionNumber++;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Chest()));
      } else if (questionNumber == 6) {
        questionNumber++;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Beggar()));
      } else if (questionNumber == game.questions.length - 1) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new SummarySP(score: finalScore)));
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
        game.choices0 = documentSnapshot.data()['choices0'];
        game.choices1 = documentSnapshot.data()['choices1'];
        game.choices2 = documentSnapshot.data()['choices2'];
        game.choices3 = documentSnapshot.data()['choices3'];
        game.choices4 = documentSnapshot.data()['choices4'];
        game.choices5 = documentSnapshot.data()['choices5'];
        game.choices6 = documentSnapshot.data()['choices6'];
        game.choices7 = documentSnapshot.data()['choices7'];
        game.choices8 = documentSnapshot.data()['choices8'];
        game.choices9 = documentSnapshot.data()['choices9'];

        // put all four choices arrays in one main array
        game.choices = [
          game.choices0,
          game.choices1,
          game.choices2,
          game.choices3,
          game.choices4,
          game.choices5,
          game.choices6,
          game.choices7,
          game.choices8,
          game.choices9
        ];

        // define answers
        game.correctAnswers = documentSnapshot.data()['answers'];
        print('answers: ${game.correctAnswers}');
      }
    });
  }

  void updateGamePlayer1() async {
    await databaseReference.collection("games").doc(gameID).update({
      'player1Points': FieldValue.increment(1),
    });
  }

  Widget soloPointsStream(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('games')
            .doc(gameID)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          var userDocument = snapshot.data;
          return Text(
            'Your score: ' + userDocument['player1Points'].toString(),
            style: TextStyle(fontSize: 15.0, color: textBright),
          );
        });
  }
}
