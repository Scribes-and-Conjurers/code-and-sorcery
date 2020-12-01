import 'package:flutter/material.dart';
import './screens/homepage/homepage.dart';
import './screens/guild_view/guild_view.dart';
import './screens/guild_view/change_guild.dart';
import './screens/user_profile/user_profile.dart';
import './screens/game_end/game_end.dart';
import './screens/game_lobby/game_lobby.dart';
import './screens/game_session/game_session.dart';
import './screens/join_game/join_game.dart';
import './screens/login/login.dart';
import './screens/login/account_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/login/authenticator.dart';
// FireBase
import 'package:firebase_auth/firebase_auth.dart';
// final User _user = checkUserLoggedIn();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Code&Sorcery',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/login',
    // home: _user == null ? LoginPage() : Homepage(),
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/homepage': (context) => Homepage(),
      '/login': (context) => LoginPage(),
      '/setup': (context) => AccountSetup(),
      '/lobby': (context) => GameLobby(),
      '/join': (context) => JoinGame(),
      '/profile': (context) => UserProfile(),
      '/leaderboard': (context) => Leaderboard(),
      '/ingame': (context) => Game1(),
      '/guild': (context) => Guild(),
      '/change': (context) => ChangeGuild(),
    },
  ));
}



// import 'package:flutter/material.dart';
// import './screens/login/log_in.dart';
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Login',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//     );
//   }
// }

