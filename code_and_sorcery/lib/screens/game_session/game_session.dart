import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import 'package:provider/provider.dart';
import './question_list.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




class GameContent{
  var images = ["slimegreen1", "slimered1", "bossmonster", "bossmonster"];

  final CollectionReference questionCollection = FirebaseFirestore.instance.collection('mc_question');

  Stream<QuerySnapshot> get questionSnapshot {
    return questionCollection.snapshots();
  }

  List<dynamic> questions = [
    "What does JS stand for?",
    "What is Vue.js?",
    "Best JavaScript library ever?",
    "How do you print to the console in JS?"
  ];

  List<dynamic> choices0 = ["JesusSighs", "Justice served", "JavaScript", "Just subtleties"];
  List<dynamic> choices1 = ["Encoder", "Framework", "Language", "Library"];
  List<dynamic> choices2 = ["React", "Vue", "Angular", "Underscore"];
  List<dynamic> choices3 = ["console.log()", "print()", "log.Debug();", "WriteLine();"];

  List<List<dynamic>> choices = [
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
    ["loading", "loading", "loading", "loading"],
  ];

  List<dynamic> correctAnswers = [
    "JavaScript", "Library", "Vue", "console.log()"
  ];
}

// game variables
var finalScore = 0;
var questionNumber = 0;
var buttonNumber = 0;

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
  void initState() {
    // update game content when Game is initiated!!
    updateGameContent('JIfrv2SOOdlxkv5RJP3i');

  }


  Widget build(BuildContext context) {

    return StreamProvider<QuerySnapshot>.value(

      value: game.questionSnapshot,
      child: WillPopScope(
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

                                  Text("Question ${questionNumber + 1}",
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


                        Padding(padding: EdgeInsets.all(10.0)),

                        // image
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
      ),
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

  void updateGameContent(String questName) async {
    await FirebaseFirestore.instance
        .collection('ready-quests')
        .doc(questName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // define questions
        game.questions = documentSnapshot.data()['questions'];

        // define choices for each question
        game.choices0 = documentSnapshot.data()['choices1'];
        game.choices1 = documentSnapshot.data()['choices2'];
        game.choices2 = documentSnapshot.data()['choices3'];
        game.choices3 = documentSnapshot.data()['choices4'];

        // put all four choices arrays in one main array
        game.choices = [game.choices0, game.choices1, game.choices2, game.choices3];

        // define answers
        game.correctAnswers = documentSnapshot.data()['answers'];
        print('answers: ${game.correctAnswers}');
      }
    });

  }
}


class Summary extends StatelessWidget{
  final databaseReference = FirebaseFirestore.instance;
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: game.questionSnapshot,
      child: WillPopScope(
          onWillPop: ()async => false,
          child: Scaffold(

              body: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // InsertQuestData("JIfrv2SOOdlxkv5RJP3i", "questions"),
                        // FutureBuilder(
                        //   future: _getImage(context, "bossmonster.png"),
                        //   builder: (context, snapshot) {
                        //     if(snapshot.connectionState == ConnectionState.done){
                        //       return Container(
                        //           width: MediaQuery.of(context).size.width / 1.2,
                        //           height: MediaQuery.of(context).size.width / 1.2,
                        //           child: snapshot.data,
                        //       );
                        //     }
                        //
                        //     if(snapshot.connectionState == ConnectionState.waiting) {
                        //       return Container(
                        //         width: MediaQuery.of(context).size.width / 1.2,
                        //         height: MediaQuery.of(context).size.width / 1.2,
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     }
                        //
                        //     return Container();
                        //   }),

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
      ),
    );
  }


  void updatePlayerPoints() async {
    await databaseReference.collection("users")
        .doc(uID)
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
        .doc(guild)
        .update({
      'totalPoints': FieldValue.increment(score),
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



// PLEASE DON'T DELETE THE BELOW COMMENTS YET

// class BuildQuestData extends StatelessWidget {
//   final String quest;
//   final String dataName;
//
//
//   BuildQuestData(this.quest, this.dataName);
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference questCollection = FirebaseFirestore.instance.collection('ready-quests');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: questCollection.doc(quest).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         var testArray = [];
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           // storing all data of that quest in 'data' map object
//           Map<String, dynamic> data = snapshot.data.data();
//
//
//           // in case it's a question:
//           if(this.dataName == 'questions') {
//             for (var question in data[dataName]) {
//               testArray.add(question);
//             };
//             return Text("Question:  ${testArray}");
//
//           }
//
//
//           }
//         return Text("loading");
//       },
//     );
//   }
// }


// class InsertQuestData extends StatelessWidget {
//   final String quest;
//   final String dataName;
//
//   InsertQuestData(this.quest, this.dataName);
//
//   fetchData() async{
//     CollectionReference questCollection = FirebaseFirestore.instance.collection('ready-quests');
//     var snapshot;
//     snapshot = await questCollection.doc(quest).get();
//
//     if (snapshot.hasError) {
//       return Text("Something went wrong");
//     }
//
//     if (snapshot.connectionState == ConnectionState.done) {
//       // storing all data of that quest in 'data' map object
//       Map<String, dynamic> data = snapshot.data.data();
//
//
//       // in case it's a question:
//       if (this.dataName == 'questions') {
//         for(var question in data[dataName]) {
//
//         }
//
//         // game.questions.add();
//         return Text("Question:  ${data[dataName]}");
//       }
//     }
//     return Text("loading");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // game.questions.add
//     return Container();
//   }
// }
//







