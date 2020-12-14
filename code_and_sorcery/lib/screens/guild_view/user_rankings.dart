import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

class UserRankings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('User Rankings')),
      body: Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 100),
          decoration: BoxDecoration(
            color: color1,
          ),
          child: _buildBody(context)),
      floatingActionButton: FloatingActionButton(
        child: Text('Guild'),
        onPressed: () {
          Navigator.pushNamed(context, '/guild');
        },
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .where("guild", isEqualTo: guild)
        .orderBy("points", descending: true)
        .limit(3)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.docs);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  return Padding(
    key: ValueKey(record.usernameRanked),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: color3),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(record.usernameRanked,
            style: TextStyle(
              fontSize: 18.0,
              color: textBright,
            )),
        trailing: Text(record.points.toString(),
            style: TextStyle(
              fontSize: 18.0,
              color: textBright,
            )),
      ),
    ),
  );
}

class Record {
  final String usernameRanked;
  final int points;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['username'] != null),
        assert(map['points'] != null),
        usernameRanked = map['username'],
        points = map['points'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$usernameRanked:$points>";
}
