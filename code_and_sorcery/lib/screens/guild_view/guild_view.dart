import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var userGuild = 'Backenders';

class Guild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guild"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child:Text("Profile"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),


    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('guilds').snapshots(),
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
    key: ValueKey(record.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
          title: Text(record.name),
          trailing: Text(record.totalPoints.toString()),

      ),
    ),
  );
}


CollectionReference guilds = FirebaseFirestore.instance.collection('guilds');


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
