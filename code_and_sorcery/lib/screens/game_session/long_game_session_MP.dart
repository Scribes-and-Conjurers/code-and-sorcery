import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import './game_content_long.dart';
import './game_summary.dart';
import './game_general_utils.dart';
import '../random_chest/chest.dart';
import '../loadingscreen/loading_before_gameMP.dart';
import '../homepage/colors.dart';

// game variables
bool hasPlayed = false;
var questionNumber = 0;
var buttonNumber = 0;
var longQuestion = true;

class QuestLongMP extends StatefulWidget {
  @override
  QuestLongMPState createState() => QuestLongMPState();
}

class QuestLongMPState extends State<QuestLongMP> {
  int counter = 10;
  Timer readyTimer;
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    hasPlayed = false;
    questionNumber = 0;
    buttonNumber = 0;
    startTimer();
    setPlayers();
    setPartyWisdom();
  }

  void startTimer() {
    // if (readyTimer != null) {
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
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(15.0)),

                          // top row that displays question number and current score
                          Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              alignment: Alignment.centerRight,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('$counter',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: textBright)),
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

                          Image.asset(
                              'assets/${game.images[questionNumber]}.png',
                              height: 200),

                          Padding(padding: EdgeInsets.all(5.0)),

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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                // button 1
                                SizedBox(
                                  width: 270,
                                  child: MaterialButton(
                                    // minWidth: 250.0,
                                    padding: EdgeInsets.all(10),
                                    color: color3,
                                    onPressed: () {
                                      if (hasPlayed == false) {
                                        if (game.choices[questionNumber][0] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          incrementPlayerPoints();
                                          finalScore++;
                                          setPlayerTrue();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
                                        }
                                        hasPlayed = true;
                                      }
                                      hasPlayed = true;
                                      // updateQuestion();
                                    },
                                    child: Text(
                                      game.choices[questionNumber][0],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: textDark,
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
                                    // minWidth: 250.0,
                                    color: color3,
                                    onPressed: () {
                                      if (hasPlayed == false) {
                                        if (game.choices[questionNumber][1] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          incrementPlayerPoints();
                                          finalScore++;
                                          setPlayerTrue();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
                                        }
                                        hasPlayed = true;
                                      }
                                      // updateQuestion();
                                    },
                                    child: Text(
                                      game.choices[questionNumber][1],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: textDark,
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
                                    // minWidth: 250.0,
                                    color: color3,
                                    onPressed: () {
                                      if (hasPlayed == false) {
                                        if (game.choices[questionNumber][2] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          incrementPlayerPoints();
                                          finalScore++;
                                          setPlayerTrue();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
                                        }
                                        hasPlayed = true;
                                      }
                                      // updateQuestion();
                                    },
                                    child: Text(
                                      game.choices[questionNumber][2],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: textDark,
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
                                    // minWidth: 250.0,
                                    color: color3,
                                    onPressed: () {
                                      if (hasPlayed == false) {
                                        if (game.choices[questionNumber][3] ==
                                            game.correctAnswers[
                                                questionNumber]) {
                                          debugPrint('correctamundo');
                                          incrementPlayerPoints();
                                          finalScore++;
                                          setPlayerTrue();
                                        } else {
                                          decreasePartyHealth();
                                          debugPrint(
                                              'oh noes... that is incorrect');
                                        }
                                        hasPlayed = true;
                                      }
                                      // updateQuestion();
                                    },
                                    child: Text(
                                      game.choices[questionNumber][3],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: textDark,
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

                        Image.asset('assets/${game.images[questionNumber]}.png',
                            height: 200),

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
                                  if (hasPlayed == false) {
                                    if (game.choices[questionNumber][0] ==
                                        game.correctAnswers[questionNumber]) {
                                      debugPrint('correctamundo');
                                      incrementPlayerPoints();
                                      finalScore++;
                                      setPlayerTrue();
                                    } else {
                                      decreasePartyHealth();
                                      debugPrint(
                                          'oh noes... that is incorrect');
                                    }
                                    hasPlayed = true;
                                  }
                                  // updateQuestion();
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
                                  if (hasPlayed == false) {
                                    if (game.choices[questionNumber][1] ==
                                        game.correctAnswers[questionNumber]) {
                                      debugPrint('correctamundo');
                                      incrementPlayerPoints();
                                      finalScore++;
                                      setPlayerTrue();
                                    } else {
                                      decreasePartyHealth();
                                      debugPrint(
                                          'oh noes... that is incorrect');
                                    }
                                    hasPlayed = true;
                                  }
                                  // updateQuestion();
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
      if (questionNumber == game.questions.length - 1) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Summary(score: finalScore)));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Chest()));
        hasPlayed = false;
        readyTimer.cancel();
      } else {
        questionNumber++;
        hasPlayed = false;
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
