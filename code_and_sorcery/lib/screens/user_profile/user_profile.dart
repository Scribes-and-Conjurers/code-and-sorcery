import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';


class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile page"),
        ),
        body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child:Text("Guild"),
        onPressed: () {
          Navigator.pushNamed(context, '/guild');
        },
      ),


    );
  }
}

Widget _buildBody(BuildContext context) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(uID)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print('Document data: ${documentSnapshot.data()}');
      // username = documentSnapshot.data().map('username');
    } else {
      print('Document does not exist on the database');
    }
  });
  // DocumentReference user = FirebaseFirestore.instance.collection('users').doc(uID);
  // return StreamBuilder<DocumentSnapshot>(
  //   stream: user.snapshots(),
  //   builder: (context, snapshot) {
  //     print(user.snapshots());
  //     if (!snapshot.hasData) return LinearProgressIndicator();
  //
  //     return _buildList(context, snapshot.data);
  //   },
  // );
}


// Widget _buildList(BuildContext context, snapshot) {
//   return ListView(
//     padding: const EdgeInsets.only(top: 20.0),
//     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//   );
// }
//
// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//   final record = Record.fromSnapshot(data);
//
//   return Padding(
//     key: ValueKey(record.username),
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: ListTile(
//         title: Text(record.username),
//         trailing: Text(record.points.toString()),
//           onTap: () => record.reference.update({'points': record.points + 1})
//
//       ),
//     ),
//   );
// }
//
// class Record {
//   final String username;
//   final int points;
//   final String guild;
//   final DocumentReference reference;
//
//   Record.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['username'] != null),
//         assert(map['points'] != null),
//         assert(map['guild'] != null),
//         username = map['username'],
//         points = map['points'],
//         guild = map['guild'];
//
//
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data(), reference: snapshot.reference);
//
//   @override
//   String toString() => "Record<$username:$points:$guild>";
// }



