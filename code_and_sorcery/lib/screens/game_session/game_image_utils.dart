import 'dart:async';
import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import 'package:provider/provider.dart';
import 'question_list.dart';
import '../game_lobby/game_lobby.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import './game_session.dart';

// utility method for fetching images from Firebase storage
class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

// method returning image with a certain name from storage; uses firestorageservice util method
Future<Widget> getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}
