import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import './screens/homepage/homepage.dart';
import './screens/guild_view/guild_view.dart';
import './screens/guild_view/change_guild.dart';
import './screens/guild_view/guild_rankings.dart';
import './screens/guild_view/user_rankings.dart';
import './screens/user_profile/user_profile.dart';
import './screens/game_end/game_end.dart';
import './screens/game_lobby/game_lobby.dart';
import './screens/game_lobby/game_lobby_SP.dart';
import './screens/game_session/game_session.dart';
import './screens/game_session/long_game_session.dart';
import './screens/join_game/join_game.dart';
import './screens/login/login.dart';
import './screens/login/account_setup.dart';
import './screens/game_lobby/game_settings.dart';
// import './screens/login/authenticator.dart';
import './screens/loadingscreen/loadingscreen.dart';
import './screens/loadingscreen/loading_before_game.dart';

// final User _user = checkUserLoggedIn();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Code&Sorcery',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/splash',
    // home: _user == null ? LoginPage() : Homepage(),
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/homepage': (context) => Homepage(),
      '/login': (context) => LoginPage(),
      '/setup': (context) => AccountSetup(),
      '/lobby': (context) => GameLobby(),
      '/lobbySP': (context) => GameLobbySP(),
      '/settings': (context) => GameSettings(),
      '/join': (context) => JoinGame(),
      '/profile': (context) => UserProfile(),
      '/leaderboard': (context) => Leaderboard(),
      '/ingame': (context) => Game1(),
      '/ingameLong': (context) => QuestLong(),
      '/guild': (context) => Guild(),
      '/change': (context) => ChangeGuild(),
      '/guildrankings': (context) => GuildRankings(),
      '/userrankings': (context) => UserRankings(),
      '/splash': (context) => LoadingScreen(),
      '/gameLoading': (context) => LoadingBeforeGame(),
    },
  ));
}
