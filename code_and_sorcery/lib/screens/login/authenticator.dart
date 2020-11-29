import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

// final FirebaseRepository firebaseRepository = FirebaseRepository();

Future<auth.User> getUser() async {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      print('User signed in: ${user.email}');
    } else {
      print('No user signed in');
    }
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}

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
  print('Name: ${user.displayName} | uID: ${user.uid}');

  // Return the current user, which should now be signed in with Google
  auth.User firebaseUser = auth.FirebaseAuth.instance.currentUser;

  return firebaseUser;
}
