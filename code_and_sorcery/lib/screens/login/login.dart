import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:code_and_sorcery/screens/homepage/homepage.dart';
import 'authenticator.dart';
import 'package:code_and_sorcery/screens/login/firestore_service.dart';
import 'account_setup.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirestoreService _firestoreService = FirestoreService();

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Hello World!')), body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user;


  void click() {
    signInWithGoogle().then((user) => {
      // getUser(uID),
      this.user = user,
      if (username != '') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Homepage()))
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccountSetup()))
      }
    });
  }

  Widget googleLoginButton() {
    return OutlineButton(
        onPressed: this.click,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        splashColor: Colors.grey,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Sign in with Google',
                        style: TextStyle(color: Colors.grey, fontSize: 25)))
              ],
            )));
  }

  Widget testButton() {
    return OutlineButton(
        onPressed: () {
          print(username);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        splashColor: Colors.grey,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Test',
                        style: TextStyle(color: Colors.grey, fontSize: 25)))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue[400]],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                testButton(),
                googleLoginButton()
              ],
            ),
          ),
        ),
      );
    }
    // return Align(alignment: Alignment.center, child: googleLoginButton())
}

Future<void> signOutGoogle() async {
  uID = '';
  username = '';
  email = '';
  guild = '';
  points = 0;
  await _googleSignIn.signOut();
  print("User Signed Out");
}
