import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:code_and_sorcery/model/user.dart';
import 'package:code_and_sorcery/screens/login/firestore_service.dart';

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirestoreService _firestoreService = FirestoreService();

// final FirebaseRepository firebaseRepository = FirebaseRepository();

// define a user to become logged in user, then post in firestore
User _currentUser;
User get currentUser => _currentUser;

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

  // create a new user profile on firestore
  _currentUser = User(
    uID: user.uid,
    name: user.displayName
  );

  await _firestoreService.createUser(_currentUser);
  print(_currentUser);

  return firebaseUser;
}


