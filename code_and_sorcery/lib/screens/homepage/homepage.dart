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

String gameJoinLink = "";
bool gameFull = false;
bool gameNull = false;
int nbOfPlayers;

const mainColor = Color(0xffb74093);

// color test stuff:
// turning normal color into material color
// Map<int, Color> colorBase1 = {
//   50: Color.fromRGBO(255, 67, 1, .1),
//   100: Color.fromRGBO(255, 67, 1, .2),
//   200: Color.fromRGBO(255, 67, 1, .3),
//   300: Color.fromRGBO(255, 67, 1, .4),
//   400: Color.fromRGBO(255, 67, 1, .5),
//   500: Color.fromRGBO(255, 67, 1, .6),
//   600: Color.fromRGBO(255, 67, 1, .7),
//   700: Color.fromRGBO(255, 67, 1, .8),
//   800: Color.fromRGBO(255, 67, 1, .9),
//   900: Color.fromRGBO(255, 67, 1, 1),
// };

// MaterialColor colorMain1 = MaterialColor(0xFFff4301, colorBase1);

Color getColorButton1(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return colorMain2;
}

Color getColorButton2(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return colorSide1;
}

Color getColorButton3(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return colorSide2;
}

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
          color: colorMain1,
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [Colors.blue[100], Colors.blue[400]],
          // ),
        ),
        child: Center(
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
              ButtonTheme(
                minWidth: 200,
                height: 20,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColorButton1),
                  ),
                  onPressed: () {
                    // Navigate back to the first screen by popping the current route
                    // off the stack.
                    updateUserProfile();
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Text('Profile page'),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith(getColorButton2),
                ),
                onPressed: () {
                  chooseGameTypePopUp(context);

                  // Navigator.pushNamed(context, '/lobby');
                  // createRecord();
                },
                child: Text('Create a game'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith(getColorButton3),
                ),
                onPressed: () {
                  // createJoinGamePopUp(context)
                  //     .then((value) => gameLinkValue = value);
                  // // if (!gameFull) {
                  // //   Navigator.pushNamed(context, '/lobby');
                  // // }
                  Navigator.pushNamed(context, '/join');
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
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter the game link"),
            content: TextField(controller: gameLinkController),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  gameJoinLink = gameLinkController.text.toString();

                  // final snapShot = FirebaseFirestore.instance
                  //     .collection('games')
                  //     .doc(gameJoinLink)
                  //     .get();

                  // if (snapShot.exists) {
                  //   //it exists
                  // } else {
                  //   //not exists
                  // }

                  // if (gameNull == true) {
                  //   print('null');
                  //   alertGameNull(context);
                  // }
                  // // gameFullCheck();
                  // if (gameFull == false) {
                  //   print('can set');
                  //   // setPlayer();
                  //   Navigator.pushNamed(context, '/lobby');
                  //   Navigator.of(context)
                  //       .pop(gameLinkController.text.toString());
                  // } else if (gameFull == true) {
                  //   print('game');
                  //   alertGameFull(context);
                  // }
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
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<String> alertGameNull(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("The game you tried to join doesn't exist"),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
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

  // void setPlayer() async {
  //   await FirebaseFirestore.instance.runTransaction((transaction) async {
  //     DocumentReference playerCheck =
  //         FirebaseFirestore.instance.collection('games').doc(gameJoinLink);
  //     DocumentSnapshot snapshot = await transaction.get(playerCheck);
  //     player2db = snapshot.data()['player2'];
  //     player3db = snapshot.data()['player3'];
  //     player4db = snapshot.data()['player4'];
  // gameFull = snapshot.data()['gameFull'];
  // if (playerClass == "Warrior") {
  //   await transaction
  //       .update(playerCheck, {'partyHealth': FieldValue.increment(1)});
  // }
  // if (player2db == "") {
  //   await transaction.update(playerCheck, {
  //     'player2': username,
  //     'player2Class': playerClass,
  //     'nbOfPlayers': FieldValue.increment(1)
  //   });
  // } else if (player2db != "") {
  //   if (player3db == "") {
  //     await transaction.update(playerCheck, {
  //         'player3': username,
  //         'player3Class': playerClass,
  //         'nbOfPlayers': FieldValue.increment(1)
  //       });
  //     } else if (player3db != "") {
  //       if (player4db == "") {
  //         await transaction.update(playerCheck, {
  //           'player4': username,
  //           'player4Class': playerClass,
  //           'nbOfPlayers': FieldValue.increment(1)
  //         });
  //         // } else {
  //         //   await transaction.update(playerCheck, {'gameFull': true});
  //       }
  //     }
  //   }
  // });
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
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
