import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

// import 'guild_view.dart';

class GuildRankings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Guild Rankings')),
      body: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color1,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: guildRanker(context),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color3,
        foregroundColor: color2,
        child: Text('Back'),
        onPressed: () {
          Navigator.pushNamed(context, '/guild');
        },
      ),
    );
  }
}

Widget guildRanker(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('guilds')
        .orderBy("totalPoints", descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.docs);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return Column(children: [
    Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text("Top Guilds",
            style: TextStyle(fontSize: 30, color: textBright))),
    Divider(
      thickness: 5,
      color: color3,
    ),
    Expanded(
        child: ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    ))
  ]);
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  // username = record.name;
  return Padding(
    key: ValueKey(record.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: color3),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(record.name,
            style: TextStyle(
              fontSize: 18.0,
              color: textBright,
            )),
        trailing: Text(record.totalPoints.toString(),
            style: TextStyle(
              fontSize: 18.0,
              color: textBright,
            )),
      ),
    ),
  );
}

class Record {
  final String name;
  final int totalPoints;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['totalPoints'] != null),
        name = map['name'],
        totalPoints = map['totalPoints'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$totalPoints>";
}
