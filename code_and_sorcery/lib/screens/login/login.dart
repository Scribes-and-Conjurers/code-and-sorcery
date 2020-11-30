import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_and_sorcery/screens/homepage/homepage.dart';
import 'authenticator.dart';

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
  FirebaseUser user;

  // @override
  // void initState() {
  //   super.initState();
  //   signOutGoogle();
  // }

  void click() {
    signInWithGoogle().then((user) => {
      this.user = user,
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Homepage(user)))
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

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }
}




// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   User user;
//   bool isUserSignedIn = false;
//
//   @override
//   void click() {
//     signInWithGoogle().then((user) => {
//       this.user = user,
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => Homepage(user)))
//     });
//   }
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             padding: EdgeInsets.all(50),
//             child: Align(
//                 alignment: Alignment.center,
//                 child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     onPressed: () {
//                       this.click();
//                     },
//                     color: isUserSignedIn ? Colors.green : Colors.blueAccent,
//                     child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Icon(Icons.account_circle, color: Colors.white),
//                             SizedBox(width: 10),
//                             Text('Login with Google',
//                                 style: TextStyle(color: Colors.white))
//                           ],
//                         ))))));
//   }
// }
