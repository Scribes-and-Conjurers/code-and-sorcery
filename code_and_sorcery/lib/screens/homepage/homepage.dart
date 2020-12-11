import 'package:code_and_sorcery/screens/game_lobby/game_lobby_SP.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/user.dart';
import '../../global_variables/global_variables.dart';
import '../login/login.dart';
import 'package:random_string/random_string.dart';

String gameJoinLink = "";
bool gameFull = false;
bool gameNull = false;
bool gameStarted = false;
int nbOfPlayers;
int startCountdown;

class Homepage extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;

  dbUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Homepage"),
      // ),
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
              CircleAvatar(
                backgroundImage: NetworkImage(
                  profileImg,
                ),
                radius: 60,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 40),
              Text(
                'WELCOME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                username,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  updateUserProfile();
                  Navigator.pushNamed(context, '/profile');
                },
                child: Text('Profile page'),
              ),
              ElevatedButton(
                onPressed: () {
                  chooseGameTypePopUp(context);

                  // Navigator.pushNamed(context, '/lobby');
                  // createRecord();
                },
                child: Text('Create a game'),
              ),
              ElevatedButton(
                onPressed: () {
                  createJoinGamePopUp(context);
                  //     .then((value) => gameLinkValue = value);
                  // // if (!gameFull) {
                  // //   Navigator.pushNamed(context, '/lobby');
                  // // }
                  // Navigator.pushNamed(context, '/join');
                },
                child: Text('Join a game'),
              ),
              RaisedButton(
                onPressed: () {
                  // signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> createJoinGamePopUp(BuildContext context) {
    TextEditingController gameLinkController = TextEditingController();
    String gameState = '';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ENTER YOUR ROOM CODE"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(gameState),
                  TextField(
                    controller: gameLinkController,
                    onChanged: (text) {
                      gameJoinLink = text;
                      checkGameState();
                    },
                    decoration: new InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: "Type here"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Send', style: TextStyle(fontSize: 23)),
                onPressed: () {
                  gameJoinLink = gameLinkController.text.toString();
                  checkGameState();

                  if (gameJoinLink == '') {
                    alertGameNoCode(context);
                  } else if (gameNull == true) {
                    alertGameNull(context);
                    gameNull = false;
                  } else if (gameFull == true) {
                    alertGameFull(context);
                    gameFull = false;
                  } else if (gameStarted == true) {
                    alertGameStarted(context);
                    gameStarted = false;
                  } else {
                    // setPlayer();
                    // Navigator.pushNamed(context, '/lobby');
                    // Navigator.of(context)
                    //     .pop(gameLinkController.text.toString());
                  }
                },
              )
            ],
          );
        });
  }

  Future<String> alertGameFull(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("The game you tried to join is already full"),
          );
        });
  }

  Future<String> alertGameNull(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("The game you tried to join doesn't exist"),
          );
        });
  }

  Future<String> alertGameStarted(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("The game you tried to join already started"),
          );
        });
  }

  Future<String> alertGameNoCode(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("You didn't enter a room code"),
          );
        });
  }

  Future<void> chooseGameTypePopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Choose your game mode'),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                color: Colors.blue,
                child: Text('SINGLEPLAYER'),
                onPressed: () {
                  gameID = randomNumeric(2);
                  createSPGame();
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/lobbySP');
                },
              ),
              MaterialButton(
                elevation: 5.0,
                color: Colors.blue,
                child: Text('MULTIPLAYER'),
                onPressed: () {
                  gameID = randomAlpha(2);
                  if (playerClass == 'Warrior')
                    createMPGameWarrior();
                  else {
                    createMPGameWizard();
                  }
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/lobby');
                },
              )
            ],
          );
        });
  }

  void updateUserProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        username = documentSnapshot.data()['username'];
        guild = documentSnapshot.data()['guild'];
        points = documentSnapshot.data()['points'];
      }
    });
  }

  void checkGameState() async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc(gameJoinLink)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        nbOfPlayers = documentSnapshot.data()['nbOfPlayers'];
        startCountdown = documentSnapshot.data()['startCountdown'];
        if (nbOfPlayers == 4) {
          gameFull = true;
        } else if (startCountdown != 5) {
          gameStarted = true;
        }
      } else {
        gameNull = true;
      }
    });
  }

  // Create a multiplayer game
  void createMPGameWizard() async {
    await FirebaseFirestore.instance.collection("games").doc(gameID).set({
      'createdAt': FieldValue.serverTimestamp(),
      'startedAt': null,
      'finished': false,
      'partyHealth': 3,
      'partyWisdom': 0.6,
      'player1': username,
      'player1Points': 0,
      'player1Class': playerClass,
      'player1isCorrect': false,
      'player2': '',
      'player2Class': '',
      'player2Points': 0,
      'player2isCorrect': false,
      'player3': '',
      'player3Class': '',
      'player3Points': 0,
      'player3isCorrect': false,
      'player4': '',
      'player4Class': '',
      'player4Points': 0,
      'player4isCorrect': false,
      'nbOfPlayers': 1,
      'pushedGo': false,
      'startCountdown': 5,
      'selectAnswer': 0,
    });
  }

  void createMPGameWarrior() async {
    await FirebaseFirestore.instance.collection("games").doc(gameID).set({
      'createdAt': FieldValue.serverTimestamp(),
      'startedAt': null,
      'finished': false,
      'partyHealth': 4,
      'partyWisdom': 0.5,
      'player1': username,
      'player1Points': 0,
      'player1Class': playerClass,
      'player1isCorrect': false,
      'player2': '',
      'player2Class': '',
      'player2Points': 0,
      'player2isCorrect': false,
      'player3': '',
      'player3Class': '',
      'player3Points': 0,
      'player3isCorrect': false,
      'player4': '',
      'player4Class': '',
      'player4Points': 0,
      'player4isCorrect': false,
      'nbOfPlayers': 1,
      'pushedGo': false,
      'startCountdown': 5,
      'selectAnswer': 0,
    });
  }

  void createSPGame() async {
    await FirebaseFirestore.instance.collection("games").doc(gameID).set({
      'created': FieldValue.serverTimestamp(),
      'finished': false,
      'partyHealth': 3,
      'player1': username,
      'player1Points': 0,
      'player1Class': playerClass,
    });
  }

  // void getQuestID() async {
  //   await FirebaseFirestore.instance
  //       .collection('games')
  //       .doc(gameID)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       // define questions
  //       questID = documentSnapshot.data()['questID'];
  //       print(questID);
  //     }
  //   });
  // }

  void setPlayer() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference playerCheck =
          FirebaseFirestore.instance.collection('games').doc(gameJoinLink);
      DocumentSnapshot snapshot = await transaction.get(playerCheck);
      player2db = snapshot.data()['player2'];
      player3db = snapshot.data()['player3'];
      player4db = snapshot.data()['player4'];
      gameFull = snapshot.data()['gameFull'];
      if (playerClass == "Warrior") {
        await transaction
            .update(playerCheck, {'partyHealth': FieldValue.increment(1)});
      }
      if (player2db == "") {
        await transaction.update(playerCheck, {
          'player2': username,
          'player2Class': playerClass,
          'nbOfPlayers': FieldValue.increment(1)
        });
      } else if (player2db != "") {
        if (player3db == "") {
          await transaction.update(playerCheck, {
            'player3': username,
            'player3Class': playerClass,
            'nbOfPlayers': FieldValue.increment(1)
          });
        } else if (player3db != "") {
          if (player4db == "") {
            await transaction.update(playerCheck, {
              'player4': username,
              'player4Class': playerClass,
              'nbOfPlayers': FieldValue.increment(1)
            });
            // } else {
            //   await transaction.update(playerCheck, {'gameFull': true});
          }
        }
      }
    });
  }

// void gameFullCheck() async {
//   await FirebaseFirestore.instance.runTransaction((transaction) async {
//     DocumentReference playerCheck =
//         FirebaseFirestore.instance.collection('games').doc(gameJoinLink);
//     DocumentSnapshot snapshot = await transaction.get(playerCheck);
//     nbOfPlayers = snapshot.data()['nbOfPlayers'];
//     if (nbOfPlayers >= 1 && nbOfPlayers > 4) {
//       gameFull = false;
//       print(nbOfPlayers);
//       print(nbOfPlayers);
//     } else if (nbOfPlayers == 4) {
//       gameFull = true;
//       print(nbOfPlayers);
//       print(nbOfPlayers);
//     }
//   });

// void gameNullCheck() async {
//   await FirebaseFirestore.instance.runTransaction((transaction) async {
//     DocumentReference gameCheck =
//         FirebaseFirestore.instance.collection('games').doc(gameJoinLink);
//     DocumentSnapshot snapshot = await transaction.get(gameCheck);
//     if (gameCheck) {
//       gameNull = true;
//     }
//     if (!gameCheck.exists) {
//       gameNull = false;
//     }
//   });
// }
//   }
// }

// void checkGameFull() async {
//   await FirebaseFirestore.instance.runTransaction((transaction) async {
//     DocumentReference playerCheck =
//         FirebaseFirestore.instance.collection('games').doc(gameJoinLink);
//     DocumentSnapshot snapshot = await transaction.get(playerCheck);
//     player2db = snapshot.data()['player2'];
//     player3db = snapshot.data()['player3'];
//     player4db = snapshot.data()['player4'];
//     if (player2db != "" && player3db != "" && player4db != "") {
//       gameFull = true;
//     } else {
//       gameFull = false;
//     }
//   });
// }
}
