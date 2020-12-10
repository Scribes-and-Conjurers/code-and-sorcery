import 'package:flutter/material.dart';
import './user_profile.dart';

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
    return Scaffold(
      body: Center(
          // padding: EdgeInsets.all(20.0),
          // margin: EdgeInsets.symmetric(vertical: 15.0),
          // width: 200.0,
          child: Container(
        width: 200.0,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // Padding(padding: EdgeInsets.all(5.0)),
            GestureDetector(
              onTap: () {
                //do what you want here
                profileImage = avatars[0];
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/mushroom_purple.png',
                ),
                radius: 120,
                backgroundColor: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                //do what you want here
                profileImage = avatars[1];
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
                profileImage = avatars[2];
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
                profileImage = avatars[3];
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
                profileImage = avatars[4];
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
                profileImage = avatars[5];
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
                //do what you want here
                profileImage = avatars[6];
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
      )),
    );
  }
}
