import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';



class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  @override
  Widget build(BuildContext context) {

    final questions = Provider.of<QuerySnapshot>(context);
    for (var doc in questions.docs) {
      print(doc.data);
    }
    return Container();
  }
}

// different try:

CollectionReference questions = FirebaseFirestore.instance.collection('mc_question');
//
// Widget _buildQuestion(BuildContext context, DocumentSnapshot data) {
//   final record = Record.fromSnapshot(data);
//
//   return Padding(
//     key: ValueKey(record.question),
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: Text(
//
//         ),
//       ),
//     );
//   );
// }




class Record {
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correct;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['text'] != null),
        assert(map['1'] != null),
        assert(map['2'] != null),
        assert(map['3'] != null),
        assert(map['4'] != null),
        assert(map['answer'] != null),
        question = map['text'],
        answer1 = map['1'],
        answer2 = map['2'],
        answer3 = map['3'],
        answer4 = map['4'],
        correct = map['answer'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$question:$correct>";
}


















