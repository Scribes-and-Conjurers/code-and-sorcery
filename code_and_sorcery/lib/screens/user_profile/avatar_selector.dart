import 'package:flutter/material.dart';
import './user_profile.dart';

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
                profileImage = 'assets/mushroom_purple.png';
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
                profileImage = 'assets/mushroom_yellow.png';
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
                profileImage = 'assets/mushroom_green.png';
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
                profileImage = 'assets/ghost_black.png';
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
                profileImage = 'assets/ghost_blue.png';
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
                profileImage = 'assets/ghost_white.png';
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
                profileImage = 'assets/tree_pink.png';
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
                profileImage = 'assets/zombie_green.png';
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
