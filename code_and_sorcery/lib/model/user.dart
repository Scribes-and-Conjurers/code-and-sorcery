import 'package:flutter/services.dart';

class User {

  String name;
  String uID;

  User({this.name, this.uID});

  User.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      uID = json['uID']
  ;

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'uID': uID
      };

}