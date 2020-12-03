import 'dart:async';
import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../game_lobby/game_lobby.dart';
import 'package:provider/provider.dart';
import './question_list.dart';
import '../game_lobby/game_lobby.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

var player1Score = 0;
var player2Score = 0;
// int counter = 10;
// Timer questionTimer;

class GameContent {
  var images = ["slimegreen1", "slimered1", "bossmonster", "bossmonster"];

  final CollectionReference questionCollection =
      FirebaseFirestore.instance.collection('mc_question');

  Stream<QuerySnapshot> get questionSnapshot {
    return questionCollection.snapshots();
  }

  List<dynamic> questions = [
    "What does JS stand for?",
    "What is Vue.js?",
    "Best JavaScript library ever?",
    "How do you print to the console in JS?"
  ];

  List<dynamic> choices0 = [
    "JesusSighs",
    "Justice served",
    "JavaScript",
    "Just subtleties"
  ];
  List<dynamic> choices1 = ["Encoder", "Framework", "Language", "Library"];
  List<dynamic> choices2 = ["React", "Vue", "Angular", "Underscore"];
  List<dynamic> choices3 = [
    "console.log()",
    "print()",
    "log.Debug();",
    "WriteLine();"
  ];

  List<List<dynamic>> choices = [
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
  ];

  List<dynamic> correctAnswers = [
    "JavaScript",
    "Library",
    "Vue",
    "console.log()"
  ];
}

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
                          future: _getImage(
                              context, "${game.images[questionNumber]}.png"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                width: MediaQuery.of(context).size.width / 1,
                                height: MediaQuery.of(context).size.width / 1.7,
                                child: snapshot.data,
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                  width: MediaQuery.of(context).size.width / 1,
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
                            onPressed: resetGame,
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

class Summary extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: game.questionSnapshot,
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Builder(builder: (context) {
                            if (!isMultiplayer) {
                              return singlePlayerPointsStream(context);
                            } else {
                              return multiplayerPointsStream(context);
                            }
                          }),
                          Padding(padding: EdgeInsets.all(10.0)),
                          MaterialButton(
                              color: Colors.deepPurple,
                              onPressed: () {
                                if (!isMultiplayer) {
                                  updateSinglePlayerPoints();
                                  updateSPGuildPoints();
                                } else {
                                  updateMultiplayerPoints();
                                  updateMPGuildPoints();
                                }
                                updateGame();
                                questionNumber = 0;
                                finalScore = 0;
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("Leave the game",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  )))
                        ])))));
  }

  // for single player game
  void updateSinglePlayerPoints() async {
    await databaseReference.collection("users").doc(uID).update({
      'points': FieldValue.increment(score),
    });
  }

  // for multplayer game, add 2 bonus points
  void updateMultiplayerPoints() async {
    await databaseReference.collection("users").doc(uID).update({
      'points': FieldValue.increment(score + 2),
    });
  }

  void updateGame() async {
    await databaseReference.collection("games").doc('testGameSession').update({
      'finished': true,
    });
  }

  // for single player
  void updateSPGuildPoints() async {
    await databaseReference.collection("guilds").doc(guild).update({
      'totalPoints': FieldValue.increment(score),
    });
  }

  // for multiplayer
  void updateMPGuildPoints() async {
    await databaseReference.collection("guilds").doc(guild).update({
      'totalPoints': FieldValue.increment(score + 2),
    });
  }
}

// live updating of player1 points
Widget singlePlayerPointsStream(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameLinkValue)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          player1 +
              "'s score: " +
              userDocument['player1Points'].toString() +
              '\n\n',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        );
      });
}

Widget partyHealthModifier(BuildContext context) {
  // String userId = "skdjfkasjdkfja";
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameLinkValue)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          userDocument['partyHealth'].toString(),
          style: TextStyle(fontSize: 25, color: Colors.black),
        );
      });
}

// live updating of player2 points
Widget multiplayerPointsStream(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameLinkValue)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          player1 +
              "'s score: " +
              userDocument['player1Points'].toString() +
              '\n\n' +
              player2 +
              "'s score: " +
              userDocument['player2Points'].toString() +
              '\n\n' +
              'Multiplayer Bonus! +2',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        );
      });
}

// utility method for fetching images from Firebase storage
class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

// method returning image with a certain name from storage; uses firestorageservice util method
Future<Widget> _getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}

// PLEASE DON'T DELETE THE BELOW COMMENTS YET

// class BuildQuestData extends StatelessWidget {
//   final String quest;
//   final String dataName;
//
//
//   BuildQuestData(this.quest, this.dataName);
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference questCollection = FirebaseFirestore.instance.collection('ready-quests');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: questCollection.doc(quest).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         var testArray = [];
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           // storing all data of that quest in 'data' map object
//           Map<String, dynamic> data = snapshot.data.data();
//
//
//           // in case it's a question:
//           if(this.dataName == 'questions') {
//             for (var question in data[dataName]) {
//               testArray.add(question);
//             };
//             return Text("Question:  ${testArray}");
//
//           }
//
//
//           }
//         return Text("loading");
//       },
//     );
//   }
// }

// class InsertQuestData extends StatelessWidget {
//   final String quest;
//   final String dataName;
//
//   InsertQuestData(this.quest, this.dataName);
//
//   fetchData() async{
//     CollectionReference questCollection = FirebaseFirestore.instance.collection('ready-quests');
//     var snapshot;
//     snapshot = await questCollection.doc(quest).get();
//
//     if (snapshot.hasError) {
//       return Text("Something went wrong");
//     }
//
//     if (snapshot.connectionState == ConnectionState.done) {
//       // storing all data of that quest in 'data' map object
//       Map<String, dynamic> data = snapshot.data.data();
//
//
//       // in case it's a question:
//       if (this.dataName == 'questions') {
//         for(var question in data[dataName]) {
//
//         }
//
//         // game.questions.add();
//         return Text("Question:  ${data[dataName]}");
//       }
//     }
//     return Text("loading");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // game.questions.add
//     return Container();
//   }
// }
//
// this was in a children widget for displaying a pic at results screen
//
// InsertQuestData("JIfrv2SOOdlxkv5RJP3i", "questions"),
// FutureBuilder(
//   future: _getImage(context, "bossmonster.png"),
//   builder: (context, snapshot) {
//     if(snapshot.connectionState == ConnectionState.done){
//       return Container(
//           width: MediaQuery.of(context).size.width / 1.2,
//           height: MediaQuery.of(context).size.width / 1.2,
//           child: snapshot.data,
//       );
//     }
//
//     if(snapshot.connectionState == ConnectionState.waiting) {
//       return Container(
//         width: MediaQuery.of(context).size.width / 1.2,
//         height: MediaQuery.of(context).size.width / 1.2,
//         child: CircularProgressIndicator(),
//       );
//     }
//
//     return Container();
//   }),
