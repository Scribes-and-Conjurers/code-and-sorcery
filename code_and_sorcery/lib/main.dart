import 'package:flutter/material.dart';
import './screens/homepage/homepage.dart';
import './screens/guild_view/guild_view.dart';
import './screens/user_profile/user_profile.dart';
import './screens/game_end/game_end.dart';
import './screens/game_lobby/game_lobby.dart';
import './screens/game_session/game_session.dart';
import './screens/join_game/join_game.dart';
import './screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MaterialApp(
    title: 'Code&Sorcery',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/login',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/login': (context) => LoginPage(),
      '/': (context) => Homepage(),
      '/lobby': (context) => GameLobby(),
      '/join': (context) => JoinGame(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/profile': (context) => UserProfile(),
      '/leaderboard': (context) => Leaderboard(),
      '/ingame': (context) => InGame(),
      '/guild': (context) => GuildView(),
    },
  ));
}





