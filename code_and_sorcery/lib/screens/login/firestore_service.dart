import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_and_sorcery/model/user.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
  FirebaseFirestore.instance.collection("users");

  Future createUser(dbUser user) async {
    try {
      await _usersCollectionReference.doc(user.uID).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }



  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      print('userData: $userData');
      // return User.fromJson(userData.data);
    } catch (e) {
      return e.toString();
    }
  }

}