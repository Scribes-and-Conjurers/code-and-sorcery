import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import './game_summary.dart';
import './game_general_utils.dart';
import '../game_over/game_over.dart';
import '../random_beggar/beggar.dart';
import '../loadingscreen/loading_before_game.dart';
import '../homepage/colors.dart';

// Short adventure for SP
// game variables
var questionNumber = 0;
var buttonNumber = 0;

// Game widget class
class GameSessionSP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GameSessionSPState();
  }
}

// Game widget state
class GameSessionSPState extends State<GameSessionSP> {
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    setPartyWisdom();
  }

  Widget build(BuildContext context) {
    if (true) {
      // return QuestShort();
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            // body
            body: new Container(
                decoration: BoxDecoration(
                  color: color2,
                ),
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),
                      // top row that displays question number and current score
                      Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          alignment: Alignment.centerRight,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Question ${questionNumber + 1}",
                                  style: TextStyle(
                                      fontSize: 15.0, color: textBright),
                                ),
                                Text(
                                  "Your score: $finalScore",
                                  style: TextStyle(
                                      fontSize: 15.0, color: textBright),
                                ),
                                Text(
                                  "Party Health:",
                                  style: TextStyle(
                                      fontSize: 15.0, color: textBright),
                                ),
                                partyHealthModifier(context),
                              ])),
                      // gameOverStream(context),

                      Padding(padding: EdgeInsets.all(5.0)),

                      // image
                      Image.asset(
                          'assets/${gameShort.images[questionNumber]}.png',
                          height: 200),

                      Padding(padding: EdgeInsets.all(5.0)),

                      // question
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          gameShort.questions[questionNumber],
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

                      // answers
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // button 1
                            SizedBox(
                              width: 270,
                              child: MaterialButton(
                                padding: EdgeInsets.all(10),
                                color: color3,
                                onPressed: () {
                                  if (gameShort.choices[questionNumber][0] ==
                                      gameShort
                                          .correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    updateGamePlayer1();
                                    finalScore++;
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  gameShort.choices[questionNumber][0],
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
                                padding: EdgeInsets.all(10),
                                color: color3,
                                onPressed: () {
                                  if (gameShort.choices[questionNumber][1] ==
                                      gameShort
                                          .correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    updateGamePlayer1();
                                    finalScore++;
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  gameShort.choices[questionNumber][1],
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
                                padding: EdgeInsets.all(10),
                                color: color3,
                                onPressed: () {
                                  if (gameShort.choices[questionNumber][2] ==
                                      gameShort
                                          .correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    updateGamePlayer1();
                                    finalScore++;
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  gameShort.choices[questionNumber][2],
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
                                padding: EdgeInsets.all(10),
                                color: color3,
                                onPressed: () {
                                  if (gameShort.choices[questionNumber][3] ==
                                      gameShort
                                          .correctAnswers[questionNumber]) {
                                    debugPrint('correctamundo');
                                    updateGamePlayer1();
                                    finalScore++;
                                  } else {
                                    decreasePartyHealth();
                                    debugPrint('oh noes... that is incorrect');
                                  }
                                  updateQuestion();
                                },
                                child: Text(
                                  gameShort.choices[questionNumber][3],
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
                    ],
                  ),
                )),
          ));
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
    setState(() {
      if (questionNumber == gameShort.questions.length - 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new SummarySP(score: finalScore)));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Beggar()));
      } else {
        questionNumber++;
      }
    });
  }

  void updateGamePlayer1() async {
    await databaseReference.collection("games").doc(gameID).update({
      'player1Points': FieldValue.increment(1),
    });
  }

  // This stream checks party health and goes to game over screen
  // Widget gameOverStream(BuildContext context) {
  //   return StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection('games')
  //           .doc(gameID)
  //           .snapshots(),
  //       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return Text("Loading");
  //         }
  //         if (snapshot.data['partyHealth'] == 0) {
  //           Navigator.pushNamed(context, '/gameOver');
  //           return Text(
  //             "",
  //             style: TextStyle(fontSize: 1),
  //           );
  //         } else {
  //           return Text(
  //             '',
  //             style: TextStyle(fontSize: 1),
  //           );
  //         }
  //       });
  // }
}
