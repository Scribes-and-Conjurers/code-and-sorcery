import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/homepage/homepage.dart';
import './screens/guild_view/guild_view.dart';
import './screens/guild_view/change_guild.dart';
import './screens/guild_view/guild_rankings.dart';
import './screens/guild_view/user_rankings.dart';
import './screens/user_profile/user_profile.dart';
import './screens/game_lobby/game_lobby.dart';
import './screens/game_lobby/game_lobby_SP.dart';
import './screens/game_session/game_session.dart';
import './screens/game_session/game_session_SP.dart';
import './screens/game_session/long_game_session.dart';
import './screens/game_session/long_game_session_MP.dart';
import './screens/join_game/join_game.dart';
import './screens/login/login.dart';
import './screens/login/account_setup.dart';
import './screens/game_lobby/game_settings.dart';
import './screens/loadingscreen/loadingscreen.dart';
import './screens/random_chest/success_chest.dart';
import './screens/random_chest/failure_chest.dart';
import './screens/random_beggar/success_beggar.dart';
import './screens/random_beggar/failure_beggar.dart';
import './screens/loadingscreen/loading_before_game.dart';
import './screens/loadingscreen/loading_before_gameMP.dart';
import './screens/game_over/game_over.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Code&Sorcery',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/splash',
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
      '/ingame': (context) => GameSession(),
      '/ingameSP': (context) => GameSessionSP(),
      '/ingameLong': (context) => QuestLong(),
      '/ingameLongMP': (context) => QuestLongMP(),
      '/guild': (context) => Guild(),
      '/change': (context) => ChangeGuild(),
      '/guildrankings': (context) => GuildRankings(),
      '/userrankings': (context) => UserRankings(),
      '/splash': (context) => LoadingScreen(),
      '/successChest': (context) => SuccessChest(),
      '/failureChest': (context) => FailureChest(),
      '/successBeggar': (context) => SuccessBeggar(),
      '/failureBeggar': (context) => FailureBeggar(),
      '/gameLoading': (context) => LoadingBeforeGame(),
      '/gameLoadingMP': (context) => LoadingBeforeGameMP(),
      '/gameOver': (context) => GameOver(),
    },
  ));
}
