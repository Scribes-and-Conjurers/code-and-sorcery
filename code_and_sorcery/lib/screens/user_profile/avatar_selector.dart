import 'package:flutter/material.dart';
import './user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';

var avatars = [
  'assets/mushroom_purple.png',
  'assets/mushroom_yellow.png',
  'assets/mushroom_green.png',
  'assets/ghost_black.png',
  'assets/ghost_blue.png',
  'assets/ghost_white.png',
  'assets/tree_pink.png',
  'assets/zombie_green.png',
];

class AvatarPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final databaseReference = FirebaseFirestore.instance;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: color2,
          ),
          // padding: EdgeInsets.all(20.0),
          // margin: EdgeInsets.symmetric(vertical: 15.0),
          // width: 200.0,
          child: Center(
            child: Container(
              width: 200.0,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  // Padding(padding: EdgeInsets.all(5.0)),

                  GestureDetector(
                    onTap: () {
                      //do what you want here
                      // profileImage = avatars[0];
                      setNewAvatar('0');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 120,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'assets/mushroom_purple.png',
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      //do what you want here
                      // profileImage = avatars[1];
                      setNewAvatar('1');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/mushroom_yellow.png',
                      ),
                      radius: 120,
                      backgroundColor: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      //do what you want here
                      setNewAvatar('2');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/mushroom_green.png',
                      ),
                      radius: 120,
                      backgroundColor: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      //do what you want here
                      setNewAvatar('3');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/ghost_black.png',
                      ),
                      radius: 120,
                      backgroundColor: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      //do what you want here
                      setNewAvatar('4');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/ghost_blue.png',
                      ),
                      radius: 120,
                      backgroundColor: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      //do what you want here
                      setNewAvatar('5');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/ghost_white.png',
                      ),
                      radius: 120,
                      backgroundColor: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      // change user property 'profileImg'
                      setNewAvatar('6');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/tree_pink.png',
                      ),
                      radius: 120,
                      backgroundColor: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      //do what you want here
                      profileImage = avatars[7];
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/zombie_green.png',
                      ),
                      radius: 120,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

// FirebaseFirestore.instance.collection('users').doc(uID).snapshots()

void setNewAvatar(index) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uID)
      .update({'profileImg': index});
}
