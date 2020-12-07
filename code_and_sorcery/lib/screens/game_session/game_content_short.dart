import 'dart:async';
import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import '../game_lobby/game_lobby.dart';
import 'package:provider/provider.dart';
import '../game_lobby/game_lobby.dart';
import './game_image_utils.dart';
import './game_summary.dart';
import './long_game_session.dart';
import './game_general_utils.dart';
import './game_session.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GameContent {
  var images = ["ghost_white", "ghost_blue", "ghost_black", "boss001"];

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
