import 'dart:async';
import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import '../game_lobby/game_lobby.dart';
import 'package:provider/provider.dart';
import '../game_lobby/game_lobby.dart';
import 'game_image_utils.dart';
import 'game_summary.dart';
import 'long_game_session.dart';
import 'game_general_utils.dart';
import 'game_session.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class used for easy, long adventures. HAS TRUE/FALSE!
class GameContentLongTF {
  var images = [
    "ghost_white",
    "ghost_blue",
    "ghost_black",
    "mushroom_green",
    "mushroom_purple",
    "mushroom_yellow",
    "skeleton_white",
    "tree_pink",
    "tree_pink",
    "tree_pink",
  ];

  List<dynamic> questions = [
    "What does JS stand for?",
    "What is Vue.js?",
    "Best JavaScript library ever?",
    "How do you print to the console in JS?",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question"
  ];

  List<dynamic> choices0 = [
    "JesusSighs",
    "Justice served",
    "JavaScript",
    "Just subtleties"
  ];
  List<dynamic> choices1 = ["Encoder", "Framework", "Language", "Library"];
  List<dynamic> choices2 = ["React", "Vue"];
  List<dynamic> choices3 = [
    "console.log()",
    "print()",
    "log.Debug();",
    "WriteLine();"
  ];
  List<dynamic> choices4 = ["Loading", "Loading"];
  List<dynamic> choices5 = ["Loading", "Loading", "Loading", "Loading"];
  List<dynamic> choices6 = ["Loading", "Loading", "Loading", "Loading"];
  List<dynamic> choices7 = ["Loading", "Loading", "Loading", "Loading"];
  List<dynamic> choices8 = ["Loading", "Loading"];
  List<dynamic> choices9 = ["Loading", "Loading", "Loading", "Loading"];

  List<List<dynamic>> choices = [
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading"],
    ["loading", "loading", "loading", "loading"],
  ];

  List<dynamic> correctAnswers = [
    "JavaScript",
    "Library",
    "Vue",
    "console.log()",
    "Loading",
    "Loading",
    "Loading",
    "Loading",
    "Loading",
    "Loading",
  ];
}

// class used for normal, long adventures. NO TRUE/FALSE!
class GameContentLongNOTF {
  var images = [
    "ghost_white",
    "ghost_blue",
    "ghost_black",
    "mushroom_green",
    "mushroom_purple",
    "mushroom_yellow",
    "skeleton_white",
    "tree_pink",
    "tree_pink",
    "tree_pink",
  ];

  List<dynamic> questions = [
    "What does JS stand for?",
    "What is Vue.js?",
    "Best JavaScript library ever?",
    "How do you print to the console in JS?",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question",
    "Error: couldn't load question"
  ];

  List<dynamic> choices0 = ["Loading", "Loading", "error", "error"];
  List<dynamic> choices1 = ["Encoder", "Framework", "Language", "Library"];
  List<dynamic> choices2 = ["React", "Vue", "error", "error"];
  List<dynamic> choices3 = ["Loading", "Loading", "error", "error"];
  List<dynamic> choices4 = ["Loading", "Loading", "error", "error"];
  List<dynamic> choices5 = ["Loading", "Loading", "Loading", "Loading"];
  List<dynamic> choices6 = ["Loading", "Loading", "Loading", "Loading"];
  List<dynamic> choices7 = ["Loading", "Loading", "Loading", "Loading"];
  List<dynamic> choices8 = ["Loading", "Loading", "error", "error"];
  List<dynamic> choices9 = ["Loading", "Loading", "Loading", "Loading"];

  List<List<dynamic>> choices = [
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
  ];

  List<dynamic> correctAnswers = [
    "JavaScript",
    "Library",
    "Vue",
    "console.log()",
    "Loading",
    "Loading",
    "Loading",
    "Loading",
    "Loading",
    "Loading",
  ];
}
