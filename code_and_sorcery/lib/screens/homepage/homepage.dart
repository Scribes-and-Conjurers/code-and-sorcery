import 'package:code_and_sorcery/screens/game_lobby/game_lobby_SP.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/user.dart';
import '../../global_variables/global_variables.dart';
import '../login/login.dart';
import 'package:random_string/random_string.dart';
import '../user_profile/user_profile.dart';
import './colors.dart';
import '../game_lobby/game_lobby.dart';

String gameJoinLink = "";
bool gameFull = false;
bool gameNull = false;
bool gameStarted = false;

Color getColor1(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return color1;
}

Color getColor2(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return color2;
}

Color getColor3(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return color3;
}

Color getColor4(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return color4;
}

class Homepage extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;

  dbUser user;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: color1,
          ),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  avatarGetter(context),
                  SizedBox(height: 40),
                  Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textBright),
                  ),
                  SizedBox(height: 10),
                  Text(
                    username,
                    style: TextStyle(
                        fontSize: 25,
                        color: textBright,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor3),
                      ),
                      onPressed: () {
                        // Navigate back to the first screen by popping the current route
                        // off the stack.
                        updateUserProfile();
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Text(
                        'PROFILE PAGE',
                        style: TextStyle(color: textDark),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith(getColor3),
                        ),
                        onPressed: () {
                          chooseGameTypePopUp(context);
                        },
                        child: Text('CREATE GAME',
                            style: TextStyle(color: textDark))),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor3),
                      ),
                      onPressed: () {
                        createJoinGamePopUp(context);
                      },
                      child:
                          Text('JOIN GAME', style: TextStyle(color: textDark)),
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }), ModalRoute.withName('/'));
                    },
                    color: color2,
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
        ),
      ),
    );
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

  // Elements related to creating a game [AlertDialog to choose the kind of game / Functions to creates game in the DB]

  Future<void> chooseGameTypePopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Choose your game mode'),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                color: color4,
                child: Text('SINGLEPLAYER'),
                onPressed: () {
                  gameID = randomNumeric(2);
                  switch (playerClass) {
                    case 'Warrior':
                      {
                        createSPGameWarrior();
                      }
                      break;
                    case 'Wizard':
                      {
                        createSPGameWizard();
                      }
                      break;
                  }
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/lobbySP');
                },
              ),
              MaterialButton(
                elevation: 5.0,
                color: color4,
                child: Text('MULTIPLAYER'),
                onPressed: () {
                  amPlayer1 = true;
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
      'gameDifficulty': difficulty,
      'gameLength': adventureLength,
      'pushedLeave': false
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
      'gameDifficulty': difficulty,
      'gameLength': adventureLength,
      'pushedLeave': false
    });
  }

  void createSPGameWarrior() async {
    await FirebaseFirestore.instance.collection("games").doc(gameID).set({
      'created': FieldValue.serverTimestamp(),
      'finished': false,
      'partyHealth': 4,
      'partyWisdom': 0.5,
      'player1': username,
      'player1Points': 0,
      'player1Class': playerClass,
      'gameDifficulty': difficulty,
      'gameLength': adventureLength
    });
  }

  void createSPGameWizard() async {
    await FirebaseFirestore.instance.collection("games").doc(gameID).set({
      'created': FieldValue.serverTimestamp(),
      'finished': false,
      'partyHealth': 3,
      'partyWisdom': 0.6,
      'player1': username,
      'player1Points': 0,
      'player1Class': playerClass,
      'gameDifficulty': difficulty,
      'gameLength': adventureLength
    });
  }

  // Elements related to the join game popup [AlertDialogs / Function to check the DB / Function to put new players in the game]

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
                onPressed: () async {
                  gameJoinLink = gameLinkController.text.toString();
                  gameID = gameJoinLink;
                  print(gameJoinLink);
                  print(gameNull);
                  print(gameFull);
                  print(gameStarted);
                  if (gameJoinLink == '') {
                    alertGameNoCode(context);
                  } else {
                    await checkGameState();
                    if (gameNull == true) {
                      alertGameNull(context);
                      gameNull = false;
                    } else if (gameStarted == true) {
                      alertGameStarted(context);
                      gameStarted = false;
                    } else if (gameFull == true) {
                      alertGameFull(context);
                      gameFull = false;
                    } else {
                      setPlayer();
                      Navigator.of(context)
                          .pop(gameLinkController.text.toString());
                      Navigator.pushNamed(context, '/lobby');
                    }
                  }
                },
              ),
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Cancel', style: TextStyle(fontSize: 23)),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(gameLinkController.text.toString());
                  })
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
            title: Text("Please enter a valid room code"),
          );
        });
  }

  Future checkGameState() async {
    int nbOfPlayers;
    int startCountdown;
    await FirebaseFirestore.instance
        .collection('games')
        .doc(gameJoinLink)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        nbOfPlayers = documentSnapshot.data()['nbOfPlayers'];
        startCountdown = documentSnapshot.data()['startCountdown'];
        if (nbOfPlayers == 4 && startCountdown == 5) {
          gameFull = true;
        } else if (startCountdown != 5) {
          gameStarted = true;
        }
      } else {
        gameNull = true;
      }
    });
  }

  void setPlayer() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference playerCheck =
          FirebaseFirestore.instance.collection('games').doc(gameJoinLink);
      DocumentSnapshot snapshot = await transaction.get(playerCheck);
      player2db = snapshot.data()['player2'];
      player3db = snapshot.data()['player3'];
      player4db = snapshot.data()['player4'];
      if (playerClass == "Warrior") {
        await transaction
            .update(playerCheck, {'partyHealth': FieldValue.increment(1)});
      } else if (playerClass == "Wizard") {
        await transaction
            .update(playerCheck, {'partyWisdom': FieldValue.increment(0.1)});
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
          }
        }
      }
    });
  }
}
