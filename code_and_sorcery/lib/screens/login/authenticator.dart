import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:code_and_sorcery/model/user.dart';
import 'package:code_and_sorcery/screens/login/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirestoreService _firestoreService = FirestoreService();
final databaseReference = FirebaseFirestore.instance;

// for our logged in user
String uID;
String username;
String email;
String guild;
String playerClass;
String profileImg;
int points;

// define a user to become logged in user, then post in firestore
dbUser _loggedInUser;
// User get currentUser => _currentUser;

// Future<auth.User> getUser() async {
//   try {
//     final user = _auth.currentUser;
//     if (user != null) {
//       print('User signed in: ${user.email}');
//     } else {
//       print('No user signed in');
//     }
//     return user;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

// User checkUserLoggedIn() {
//   if (_auth.currentUser != null) {
//     return _auth.currentUser;
//   } else {
//     return null;
//   }
// }

Future<auth.User> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final auth.GoogleAuthCredential credential =
      auth.GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final auth.User user = (await _auth.signInWithCredential(credential)).user;
  print('Successfully signed in user with Google Provider');
  print('Name: ${user.email} | uID: ${user.uid}');

  // Return the current user, which should now be signed in with Google
  auth.User firebaseUser = auth.FirebaseAuth.instance.currentUser;
  uID = user.uid;
  guild = '';
  email = user.email;
  points = 0;
  username = '';

  _loggedInUser = dbUser(uID: uID, email: email);

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uID)
      .get()
      .then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      print('Document data: ${documentSnapshot.data()}');
      username = documentSnapshot.data()['username'];
      guild = documentSnapshot.data()['guild'];
      points = documentSnapshot.data()['points'];
      profileImg = documentSnapshot.data()['profileImg'];
      playerClass = documentSnapshot.data()['playerClass'];
      print(username);
      print(guild);
      print(points);
    } else {
      await _firestoreService.createUser(_loggedInUser);
    }
  });

  return firebaseUser;
}

// class GetUserName extends StatelessWidget {
//   GetUserName(uID);
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(uID).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           return Text("Full Name: ${data['username']} ${data['last_name']}");
//         }
//         return Text("loading");
//       },
//     );
//   }
// }
