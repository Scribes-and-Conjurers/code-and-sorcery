// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();
// String name;
// String email;
// String imageUrl;
// String uid;
// Future<String> signInWithGoogle() async {
//   await Firebase.initializeApp();
//   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );
//   final UserCredential authResult =
//       await _auth.signInWithCredential(credential);
//   final User user = authResult.user;
//   if (user != null) {
//     // Add the following lines after getting the user
//     // Checking if email and name is null
//     assert(user.email != null);
//     assert(user.displayName != null);
//     assert(user.photoURL != null);
//     assert(user.uid != null);
//     // Store the retrieved data
//     name = user.displayName;
//     email = user.email;
//     imageUrl = user.photoURL;
//     uid = user.uid;
//     if (name.contains(" ")) {
//       name = name.substring(0, name.indexOf(" "));
//     }
//     print('signInWithGoogle succeeded: $user');
//     return '$user';
//   }
//   return null;
// }
//
// Future<void> signOutGoogle() async {
//   await googleSignIn.signOut();
//   print("User Signed Out");
// }
