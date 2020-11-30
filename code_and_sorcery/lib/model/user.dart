import 'package:flutter/services.dart';

class User {

  String username;
  String uID;
  String email;
  int points;
  String guild;

  User({this.username, this.uID, this.email, this.points, this.guild});

  User.fromJson(Map<String, dynamic> json)
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