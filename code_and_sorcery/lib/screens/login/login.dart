import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:code_and_sorcery/screens/homepage/homepage.dart';
import 'authenticator.dart';
import 'account_setup.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'CODE&SORCERY',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(height: 10),
              Text(
                '<🧙‍♀️🧙‍♂️>',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(height: 50),
              googleLoginButton(),
            ],
          ),
        ),
      ),
    );
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
                // Image(image: AssetImage('../../assets/google_logo.png'), height: 35),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Sign in with Google',
                        style: TextStyle(color: Colors.grey, fontSize: 25)))
              ],
            )));
  }

  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          if (username != '')
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Homepage()))
            }
          else
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountSetup()))
            }
        });
  }
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
