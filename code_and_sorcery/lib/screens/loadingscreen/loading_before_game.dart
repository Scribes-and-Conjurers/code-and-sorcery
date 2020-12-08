import 'package:code_and_sorcery/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../game_session/game_content_long.dart';

// create game object
var game = new GameContentLong();

class LoadingBeforeGame extends StatefulWidget {
  @override
  _LoadingBeforeGameState createState() => _LoadingBeforeGameState();
}

class _LoadingBeforeGameState extends State<LoadingBeforeGame> {
  @override
  void initState() {
    super.initState();
    updateGameContent('long-adv0');
    Timer(Duration(seconds: 5),
        () => Navigator.pushNamed(context, '/ingameLong'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(children: [
          Image.asset('assets/logo.png'),
          Text(
            "Game loading...",
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.6),
          )
        ]));
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
}
