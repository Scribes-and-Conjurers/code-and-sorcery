import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




class GameContent{
  var images = ["slimegreen1", "slimered1", "bossmonster", "bossmonster"];

  var questions = [
    "What does JS stand for?",
    "What is Vue.js?",
    "Best JavaScript library ever?",
    "How do you print to the console in JS?"
  ];

  var choices = [
    ["JesusSighs", "Justice served", "JavaScript", "Just subtleties"],
    ["Encoder", "Framework", "Language", "Library"],
    ["React", "Vue", "Angular", "Underscore"],
    ["console.log()", "print()", "log.Debug();", "WriteLine();"]
  ];

  var correctAnswers = [
    "JavaScript", "Library", "Vue", "console.log()"
  ];
}

// game variables
var finalScore = 0;
var questionNumber = 0;
// variable that holds game object:
var game = new GameContent();

// Game widget class
class Game1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Game1State();
  }
}

// Game widget state
class Game1State extends State<Game1>{
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: ()async => false,
        child: Scaffold(

            // body
            body: new Container(
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                child: new Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10.0)),

                      // top row that displays question number and current score
                      Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                Text("Question ${questionNumber + 1} of ${game.questions.length}",
                                  style: TextStyle(
                                      fontSize: 22.0
                                  ),),

                                Text("Score: $finalScore",
                                  style: TextStyle(
                                      fontSize: 22.0
                                  ),),
                              ]
                          )
                      ),

                      // image
                      Padding(padding: EdgeInsets.all(10.0)),

                      FutureBuilder(
                          future: _getImage(context, "${game.images[questionNumber]}.png"),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              return Container(
                                width: MediaQuery.of(context).size.width / 1,
                                height: MediaQuery.of(context).size.width / 1.5,
                                child: snapshot.data,
                              );
                            }

                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                width: MediaQuery.of(context).size.width / 1,
                                height: MediaQuery.of(context).size.width / 1.5,
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(),

                                )
                              );
                            }

                            return SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(),
                            );
                          }),

                      // new Image.asset(
                      //     "images/${game.images[questionNumber]}.png",
                      //     height: 200,
                      // ),

                      Padding(padding: EdgeInsets.all(10.0)),

                      // question
                      Text(game.questions[questionNumber],
                        style: TextStyle(
                          fontSize: 20.0,
                        ),),

                      Padding(padding: EdgeInsets.all(10.0),),

                      // answers row 1
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            //button 1
                            MaterialButton(
                              minWidth: 120.0,
                              color: Colors.blueGrey,
                              onPressed: () {
                                if(game.choices[questionNumber][0] == game.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  finalScore++;
                                  updateGame();
                                } else {
                                  debugPrint('oh noes... that is incorrect');
                                }
                                updateQuestion();
                              },
                              child: Text(game.choices[questionNumber][0],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // button 2
                            MaterialButton(
                              minWidth: 120.0,
                              color: Colors.blueGrey,
                              onPressed: () {
                                if(game.choices[questionNumber][1] == game.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  finalScore++;
                                  updateGame();
                                } else {
                                  debugPrint('oh noes... that is incorrect');
                                }
                                updateQuestion();
                              },
                              child: Text(game.choices[questionNumber][1],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ]
                      ),

                      Padding(padding: EdgeInsets.all(10.0),),

                      // answers row 2
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            //button 3
                            MaterialButton(
                              minWidth: 120.0,
                              color: Colors.blueGrey,
                              onPressed: () {
                                if(game.choices[questionNumber][2] == game.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  finalScore++;
                                  updateGame();
                                } else {
                                  debugPrint('oh noes... that is incorrect');
                                }
                                updateQuestion();
                              },
                              child: Text(game.choices[questionNumber][2],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // button 4
                            MaterialButton(
                              minWidth: 120.0,
                              color: Colors.blueGrey,
                              onPressed: () {
                                if(game.choices[questionNumber][3] == game.correctAnswers[questionNumber]) {
                                  debugPrint('correctamundo');
                                  finalScore++;
                                  updateGame();
                                } else {
                                  debugPrint('oh noes... that is incorrect');
                                }
                                updateQuestion();
                              },
                              child: Text(game.choices[questionNumber][3],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ]
                      ),

                      Padding(padding: EdgeInsets.all(10.0),),

                      // reset button
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: MaterialButton(
                            color: Colors.redAccent,
                            minWidth: 240.0,
                            height: 30.0,
                            onPressed: resetGame,
                            child: Text("Quit",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                      )
                    ]
                )
            )
        )
    );
  }

  // resetting question/answer screen
  void resetGame() {
    setState(() {
      // close current screen:
      Navigator.pop(context);
      // reset variables:
      finalScore = 0;
      questionNumber = 0;
    });
  }

  // changing to new question OR go to leaderboard if last question
  void updateQuestion() {
    setState(() {
      if(questionNumber == game.questions.length -1){
        // if(player1)
        Navigator.push(context, MaterialPageRoute(builder: (context) => new Summary(player1Score: finalScore)));
      } else {
        questionNumber++;
      }
    });
  }


  void updateGame() async {
    await databaseReference.collection("games")
        .doc('testGameSession')
        .update({
      'player1Points': FieldValue.increment(1),
      'player2Points': FieldValue.increment(1),
    });
  }
}

class Summary extends StatelessWidget{
  final databaseReference = FirebaseFirestore.instance;
  final int player1Score;
  final int player2Score;
  Summary({Key key, @required this.player1Score,@required this.player2Score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async => false,
        child: Scaffold(

            body: Container(
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      FutureBuilder(
                        future: _getImage(context, "bossmonster.png"),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            return Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: MediaQuery.of(context).size.width / 1.2,
                                child: snapshot.data,
                            );
                          }

                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.width / 1.2,
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Container();
                        }),

                      Text("Player 1 score: $player1Score",
                        style: TextStyle(
                            fontSize: 25.0
                        ),),
                      Text("Player 2 score: $player2Score",
                        style: TextStyle(
                            fontSize: 25.0
                        ),),

                      Padding(padding: EdgeInsets.all(10.0)),

                      MaterialButton(
                          color: Colors.red,
                          onPressed: () {
                            updatePlayerPoints();
                            updateGuildPoints();
                            updateGame();
                            questionNumber = 0;
                            finalScore = 0;
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("Leave the game",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ))
                      )

                    ]
                )
            )

        )
    );
  }


  void updatePlayerPoints() async {
    await databaseReference.collection("users")
        .doc(uID)
        .update({
      // 'points': FieldValue.increment(score),
    });
  }

  void updateGame() async {
    await databaseReference.collection("games")
        .doc('testGameSession')
        .update({
      'finished': true,
    });
  }

  void updateGuildPoints() async {
    await databaseReference.collection("guilds")
        .doc(guild)
        .update({
      // 'totalPoints': FieldValue.increment(score),
    });
  }
}

// utility method for fetching images from Firebase storage
class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

// method returning image with a certain name from storage; uses firestorageservice util method
Future<Widget> _getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}














