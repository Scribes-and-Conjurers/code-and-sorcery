import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var userGuild = 'backenders';
var userName = 'Clay';

class GameContent{
  var images = ["monster1", "monster2", "monster3", "boss1"];

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

                      new Image.asset(
                          "images/${game.images[questionNumber]}.jpg",
                          height: 200,
                      ),

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
        Navigator.push(context, MaterialPageRoute(builder: (context) => new Summary(score: finalScore)));
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
    });
  }
}

class Summary extends StatelessWidget{
  final databaseReference = FirebaseFirestore.instance;
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

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

                      Text("Final score: $score",
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
        .doc(userName)
        .update({
      'points': FieldValue.increment(score),
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
        .doc(userGuild)
        .update({
      'totalPoints': FieldValue.increment(score),
    });
  }
}



// class InGame extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("In game"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate back to the first screen by popping the current route
//             // off the stack.
//             Navigator.pushNamed(context, '/leaderboard');
//           },
//           child: Text('Escape the game'),
//         ),
//       ),
//     );
//   }
// }