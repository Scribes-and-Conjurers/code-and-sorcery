import 'dart:async';
import 'dart:collection';
import 'package:code_and_sorcery/screens/homepage/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../login/authenticator.dart';
import '../game_lobby/game_lobby.dart';
import 'package:provider/provider.dart';
import '../game_lobby/game_lobby.dart';
import './game_image_utils.dart';
import './game_summary.dart';
import './long_game_session_MP.dart';
import './game_session.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../homepage/colors.dart';

// live updating of player1 points
Widget player1PointsStream(BuildContext context) {
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
          userDocument['player1'] +
              "'s score: " +
              userDocument['player1Points'].toString() +
              '\n\n',
          style: TextStyle(
              fontSize: 25, color: textBright, fontWeight: FontWeight.bold),
        );
      });
}

Widget player2PointsStream(BuildContext context) {
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
        if (userDocument['player2'] == '') {
          return Padding(padding: EdgeInsets.all(0.0));
        } else {
          return Text(
            userDocument['player2'] +
                "'s score: " +
                userDocument['player2Points'].toString() +
                '\n\n',
            style: TextStyle(
                fontSize: 25, color: textBright, fontWeight: FontWeight.bold),
          );
        }
      });
}

Widget player3PointsStream(BuildContext context) {
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
        if (userDocument['player3'] == '') {
          return Padding(padding: EdgeInsets.all(0.0));
        } else {
          return Text(
            userDocument['player3'] +
                "'s score: " +
                userDocument['player3Points'].toString() +
                '\n\n',
            style: TextStyle(
                fontSize: 25, color: textBright, fontWeight: FontWeight.bold),
          );
        }
      });
}

Widget player4PointsStream(BuildContext context) {
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
        if (userDocument['player4'] == '') {
          return Padding(padding: EdgeInsets.all(0.0));
        } else {
          return Text(
            userDocument['player4'] +
                "'s score: " +
                userDocument['player4Points'].toString() +
                '\n\n',
            style: TextStyle(
                fontSize: 25, color: textBright, fontWeight: FontWeight.bold),
          );
        }
      });
}

// for SHORT MP sessions
Widget partyHealthModifierShort(BuildContext context) {
  Future<String> gameOverPopUp(BuildContext context) {
    readyTimer.cancel();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("GAME OVER"),
              content: Text("Your party health reached 0. Try again!"),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5.0,
                    child: Text('QUIT', style: TextStyle(fontSize: 23)),
                    onPressed: () async {
                      await databaseReference
                          .collection("games")
                          .doc(gameID)
                          .update({
                        'finished': true,
                      });
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/homepage');
                    })
              ],
            ),
          );
        });
  }

  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameID)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        var userDocument = snapshot.data;
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        if (userDocument['partyHealth'] == 0) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => gameOverPopUp(context));
          return Text("");
        } else {
          return Text(
            userDocument['partyHealth'].toString(),
            style: TextStyle(fontSize: 25, color: textBright),
          );
        }
      });
}

// for LONG MP sessions
Widget partyHealthModifierLong(BuildContext context) {
  Future<String> gameOverPopUp(BuildContext context) {
    readyTimerLong.cancel();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("GAME OVER"),
              content: Text("Your party health reached 0. Try again!"),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5.0,
                    child: Text('QUIT', style: TextStyle(fontSize: 23)),
                    onPressed: () async {
                      await databaseReference
                          .collection("games")
                          .doc(gameID)
                          .update({
                        'finished': true,
                      });
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/homepage');
                    })
              ],
            ),
          );
        });
  }

  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameID)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        var userDocument = snapshot.data;
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        if (userDocument['partyHealth'] == 0) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => gameOverPopUp(context));
          return Text("");
        } else {
          return Text(
            userDocument['partyHealth'].toString(),
            style: TextStyle(fontSize: 25, color: textBright),
          );
        }
      });
}

// this is for SP and has no readyTimer.cancel();
Widget partyHealthModifierSolo(BuildContext context) {
  Future<String> gameOverPopUp(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("GAME OVER"),
              content: Text("Your party health reached 0. Try again!"),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5.0,
                    child: Text('QUIT', style: TextStyle(fontSize: 23)),
                    onPressed: () async {
                      await databaseReference
                          .collection("games")
                          .doc(gameID)
                          .update({
                        'finished': true,
                      });
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/homepage');
                    })
              ],
            ),
          );
        });
  }

  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameID)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        var userDocument = snapshot.data;
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        if (userDocument['partyHealth'] == 0) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => gameOverPopUp(context));
          return Text("");
        } else {
          return Text(
            userDocument['partyHealth'].toString(),
            style: TextStyle(fontSize: 25, color: textBright),
          );
        }
      });
}

// live updating of 2 players' points
// Widget twoPlayersPointsStream(BuildContext context) {
//   return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('games')
//           .doc(gameID)
//           .snapshots(),
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Text("Loading");
//         }
//         var userDocument = snapshot.data;
//         return Text(
//           userDocument['player1'] +
//               "'s score: " +
//               userDocument['player1Points'].toString() +
//               '\n\n' +
//               userDocument['player2'] +
//               "'s score: " +
//               userDocument['player2Points'].toString() +
//               '\n\n' +
//               'Multiplayer Bonus! +2',
//           style: TextStyle(
//               fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
//         );
//       });
// }

// // live updating of player2 points
// Widget multiplayerPointsStream(BuildContext context) {
//   return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('games')
//           .doc(gameLinkValue)
//           .snapshots(),
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Text("Loading");
//         }
//         var userDocument = snapshot.data;
//         return Text(
//           userDocument['player1'] +
//               "'s score: " +
//               userDocument['player1Points'].toString() +
//               '\n\n' +
//               userDocument['player2'] +
//               "'s score: " +
//               userDocument['player2Points'].toString() +
//               '\n\n' +
//               'Multiplayer Bonus! +2',
//           style: TextStyle(
//               fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
//         );
//       });
// }
