// import 'package:firebase_core/firebase_core.dart';
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue[400]],
            ),
          ),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: [
                      avatarGetter(context),
                      Padding(padding: EdgeInsets.all(5)),
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
                        label: Text('Avatars'),
                        icon: Icon(Icons.add),
                        backgroundColor: Colors.pink,
                      ),
                      Padding(padding: EdgeInsets.all(15)),
                      Text(
                        username + '  -  ' + playerClass,
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      Divider(
                        thickness: 5,
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(guild,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black))),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/guild');
                        },
                        color: Colors.blueGrey,
                        child: Text(
                          'Guild View',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text('Your Current Points:',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      // Text(points.toString(), style: TextStyle(fontSize: 25))
                      pointGetter(context),
                    ],
                  )))),
      floatingActionButton: FloatingActionButton(
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
          style: TextStyle(fontSize: 25),
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
