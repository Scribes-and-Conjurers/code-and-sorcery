// import 'package:firebase_core/firebase_core.dart';
import 'package:code_and_sorcery/screens/homepage/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import './avatar_selector.dart';

var profileImage = 'assets/logo.png';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // fetch image avatar no. from database

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Your Profile"),
      // ),
      body: Container(
          decoration: BoxDecoration(color: color1),
          child: Center(
              child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    avatarGetter(context),
                    Padding(padding: EdgeInsets.all(10)),
                    FloatingActionButton.extended(
                      heroTag: "avatarbtn",
                      onPressed: () {
                        // Add your onPressed code here!
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvatarPicker()),
                        );
                      },
                      label: Text('CHANGE AVATAR',
                          style: TextStyle(color: textDark)),
                      // icon: Icon(Icons.add),
                      backgroundColor: color3,
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Text(
                      username + '  -  ' + playerClass,
                      style: TextStyle(fontSize: 25, color: textBright),
                    ),
                    Padding(padding: EdgeInsets.all(2)),
                    Divider(thickness: 3, color: color3),
                    Text(
                      "Guild:",
                      style: TextStyle(fontSize: 20, color: textBright),
                    ),
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('$guild',
                            style: TextStyle(fontSize: 20, color: textBright))),
                    Padding(padding: EdgeInsets.all(6.00)),
                    SizedBox(
                      width: 200,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/guild');
                        },
                        color: color3,
                        child: Text(
                          'GUILD VIEW',
                          style: TextStyle(color: textDark),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.00)),
                    Text('Your Current Points:',
                        style: TextStyle(fontSize: 20, color: textBright)),
                    // Text(points.toString(), style: TextStyle(fontSize: 25))
                    Padding(padding: EdgeInsets.all(8.00)),
                    pointGetter(context),
                    Padding(padding: EdgeInsets.all(20.00)),
                  ],
                )),
          ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color2,
        foregroundColor: color3,
        child: Text('Back'),
        onPressed: () {
          Navigator.pushNamed(context, '/homepage');
        },
      ),
    );
  }
}

// this function fetches points live
Widget pointGetter(BuildContext context) {
  // String userId = "skdjfkasjdkfja";
  return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uID).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          userDocument['points'].toString(),
          style: TextStyle(fontSize: 30, color: textBright),
        );
      });
}

// this function fetches the current avatar index
Widget avatarGetter(BuildContext context) {
  return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uID).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var imageIndexString = snapshot.data['profileImg'];
        var imageIndex = int.parse(imageIndexString);
        return CircleAvatar(
            radius: 63,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                avatars[imageIndex],
              ),
              radius: 60,
              backgroundColor: Colors.white,
            ));
      });
}
