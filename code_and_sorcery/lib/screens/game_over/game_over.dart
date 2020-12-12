import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import 'package:provider/provider.dart';
import '../game_session/game_general_utils.dart';
import '../game_session/game_session.dart';
import '../homepage/homepage.dart';

class GameOver extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  final int score;

  GameOver({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: game.questionSnapshot,
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Container(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Game Over!',
                              style: TextStyle(
                                fontSize: 36,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Your party ran out of health!',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            Builder(builder: (context) {
                              return player1PointsStream(context);
                            }),
                            Builder(builder: (context) {
                              return player2PointsStream(context);
                            }),
                            Builder(builder: (context) {
                              return player3PointsStream(context);
                            }),
                            Builder(builder: (context) {
                              return player4PointsStream(context);
                            }),
                            Padding(padding: EdgeInsets.all(10.0)),
                            MaterialButton(
                                color: Colors.deepPurple,
                                onPressed: () {
                                  updateGame();
                                  questionNumber = 0;
                                  finalScore = 0;
                                  // Navigator.pushNamed(context, '/homepage');
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //     context, MaterialPageRoute(builder: (context) => Homepage()));
                                },
                                child: Text("Leave the game",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    )))
                          ]),
                    )))));
  }

  void updateGame() async {
    await databaseReference.collection("games").doc(gameID).update({
      'finished': true,
    });
  }
}
