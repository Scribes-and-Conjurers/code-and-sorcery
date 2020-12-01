import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';



class UserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Container(
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(70),
                  child: Column(
                    children: [
                      Text(
                        username,
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      Divider(thickness: 5,),
                      Padding(padding: EdgeInsets.all(10),child: Text(
                          guild, style: TextStyle(fontSize: 20, color: Colors.black)
                      )),
                      MaterialButton(onPressed: () {Navigator.pushNamed(context, '/guild');}, color: Colors.blueGrey, child: Text(
                        'Guild View', style: TextStyle(color: Colors.white),),),
                      Text('Your Current Quiz Points:', style: TextStyle(fontSize: 20, color: Colors.black)),
                      Text(points.toString(), style: TextStyle(fontSize: 25))
                    ],
                  )
              )
          )
      ),
    );
  }
}




