import 'package:flutter/services.dart';

class dbUser {

  String username;
  String uID;
  String email;
  int points;
  String guild;

  dbUser({this.username, this.uID, this.email, this.points, this.guild});

  dbUser.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      uID = json['uID'],
      email = json['email'],
      points = json['points'],
      guild = json['guild']
  ;

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'uID': uID,
        'email': email,
        'points': points,
        'guild': guild
      };

}