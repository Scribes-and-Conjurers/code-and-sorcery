// import 'dart:async';
// import 'dart:collection';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../login/authenticator.dart';
// import '../game_lobby/game_lobby.dart';
// import 'package:provider/provider.dart';
// import 'assembling_codebits.dart';
// import '../game_lobby/game_lobby.dart';
// import './game_image_utils.dart';
// import './game_summary.dart';
// import './game_session.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class QuestShort extends StatefulWidget {
//   @override
//   _QuestShortState createState() => _QuestShortState();
// }

// class _QuestShortState extends State<QuestShort> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: WillPopScope(
//             onWillPop: () async => false,
//             child: Scaffold(

//                 // body
//                 body: new Container(
//                     margin: const EdgeInsets.all(10.0),
//                     alignment: Alignment.topCenter,
//                     child: new Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(padding: EdgeInsets.all(10.0)),
//                           // top row that displays question number and current score
//                           Container(
//                               alignment: Alignment.centerRight,
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     // (counter > 0)
//                                     //     ? Text("")
//                                     //     : Text("OVER",
//                                     //         style: TextStyle(color: Colors.red)),
//                                     // Text('$counter',
//                                     //     style: TextStyle(
//                                     //         fontWeight: FontWeight.bold,
//                                     //         fontSize: 48)),
//                                     Text(
//                                       "Question ${questionNumber + 1}",
//                                       style: TextStyle(fontSize: 15.0),
//                                     ),
//                                     Text(
//                                       "Score: $finalScore",
//                                       style: TextStyle(fontSize: 15.0),
//                                     ),
//                                     Text(
//                                       "Party Health:",
//                                       style: TextStyle(fontSize: 15.0),
//                                     ),
//                                     partyHealthModifier(context),
//                                   ])),

//                           Padding(padding: EdgeInsets.all(5.0)),

//                           // image
//                           FutureBuilder(
//                               future: getImage(context,
//                                   "${game.images[questionNumber]}.png"),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.done) {
//                                   return Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 1,
//                                     height:
//                                         MediaQuery.of(context).size.width / 1.7,
//                                     child: snapshot.data,
//                                   );
//                                 }
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return Container(
//                                       width:
//                                           MediaQuery.of(context).size.width / 1,
//                                       height:
//                                           MediaQuery.of(context).size.width /
//                                               1.7,
//                                       child: SizedBox(
//                                         height: 10,
//                                         width: 10,
//                                         child: CircularProgressIndicator(),
//                                       ));
//                                 }
//                                 return SizedBox(
//                                   height: 10,
//                                   width: 10,
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }),

//                           Padding(padding: EdgeInsets.all(5.0)),

//                           // question
//                           Text(
//                             game.questions[questionNumber],
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 15.0,
//                             ),
//                           ),

//                           Padding(
//                             padding: EdgeInsets.all(5.0),
//                           ),

//                           // answers
//                           Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 // button 1
//                                 MaterialButton(
//                                   minWidth: 250.0,
//                                   padding: EdgeInsets.all(0),
//                                   color: Colors.blue,
//                                   onPressed: () {
//                                     if (game.choices[questionNumber][0] ==
//                                         game.correctAnswers[questionNumber]) {
//                                       debugPrint('correctamundo');
//                                       finalScore++;
//                                       if (player1 == username) {
//                                         player1Score++;
//                                         updateGamePlayer1();
//                                       } else {
//                                         player2Score++;
//                                         updateGamePlayer2();
//                                       }
//                                     } else {
//                                       decreasePartyHealth();
//                                       debugPrint(
//                                           'oh noes... that is incorrect');
//                                     }
//                                     updateQuestion();
//                                   },
//                                   child: Text(
//                                     game.choices[questionNumber][0],
//                                     style: TextStyle(
//                                       fontSize: 15.0,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),

//                                 // button 2
//                                 MaterialButton(
//                                   minWidth: 250.0,
//                                   color: Colors.blue,
//                                   onPressed: () {
//                                     if (game.choices[questionNumber][1] ==
//                                         game.correctAnswers[questionNumber]) {
//                                       debugPrint('correctamundo');
//                                       // startTimer();
//                                       finalScore++;
//                                       if (player1 == username) {
//                                         player1Score++;
//                                         updateGamePlayer1();
//                                       } else {
//                                         player2Score++;
//                                         updateGamePlayer2();
//                                       }
//                                     } else {
//                                       decreasePartyHealth();
//                                       debugPrint(
//                                           'oh noes... that is incorrect');
//                                     }
//                                     updateQuestion();
//                                   },
//                                   child: Text(
//                                     game.choices[questionNumber][1],
//                                     style: TextStyle(
//                                       fontSize: 15.0,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),

//                                 // button 3
//                                 MaterialButton(
//                                   minWidth: 250.0,
//                                   color: Colors.blue,
//                                   onPressed: () {
//                                     if (game.choices[questionNumber][2] ==
//                                         game.correctAnswers[questionNumber]) {
//                                       debugPrint('correctamundo');
//                                       finalScore++;
//                                       if (player1 == username) {
//                                         player1Score++;
//                                         updateGamePlayer1();
//                                       } else {
//                                         player2Score++;
//                                         updateGamePlayer2();
//                                       }
//                                     } else {
//                                       decreasePartyHealth();
//                                       debugPrint(
//                                           'oh noes... that is incorrect');
//                                     }
//                                     updateQuestion();
//                                   },
//                                   child: Text(
//                                     game.choices[questionNumber][2],
//                                     style: TextStyle(
//                                       fontSize: 15.0,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),

//                                 // button 4
//                                 MaterialButton(
//                                   minWidth: 250.0,
//                                   color: Colors.blue,
//                                   onPressed: () {
//                                     if (game.choices[questionNumber][3] ==
//                                         game.correctAnswers[questionNumber]) {
//                                       debugPrint('correctamundo');
//                                       finalScore++;
//                                       if (player1 == username) {
//                                         player1Score++;
//                                         updateGamePlayer1();
//                                       } else {
//                                         player2Score++;
//                                         updateGamePlayer2();
//                                       }
//                                     } else {
//                                       decreasePartyHealth();
//                                       debugPrint(
//                                           'oh noes... that is incorrect');
//                                     }
//                                     updateQuestion();
//                                   },
//                                   child: Text(
//                                     game.choices[questionNumber][3],
//                                     style: TextStyle(
//                                       fontSize: 15.0,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ]),

//                           Padding(
//                             padding: EdgeInsets.all(5),
//                           ),

//                           // reset button
//                           Container(
//                               alignment: Alignment.bottomCenter,
//                               child: MaterialButton(
//                                 color: Colors.deepPurple,
//                                 minWidth: 240.0,
//                                 height: 30.0,
//                                 onPressed: resetterGame(context),
//                                 child: Text(
//                                   "Quit",
//                                   style: TextStyle(
//                                     fontSize: 18.0,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               )),
//                         ])))));
//   }
// }
