// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue[400]],
            ),
          ),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(70),
                  child: Column(
                    children: [
                      Text(
                        username + '  -  ' + playerClass,
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      Divider(
                        thickness: 5,
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(guild,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black))),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/guild');
                        },
                        color: Colors.blueGrey,
                        child: Text(
                          'Guild View',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text('Your Current Quiz Points:',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      // Text(points.toString(), style: TextStyle(fontSize: 25))
                      pointGetter(context),
                    ],
                  )))),
      floatingActionButton: FloatingActionButton(
        child: Text('Back'),
        onPressed: () {
          Navigator.pushNamed(context, '/homepage');
        },
      ),
    );
  }
}

// this function fetches points live
Widget pointGetter(BuildContext context) {
  // String userId = "skdjfkasjdkfja";
  return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uID).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          userDocument['points'].toString(),
          style: TextStyle(fontSize: 25),
        );
      });
}

// Widget _buildBody(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance.collection('users').doc(uID).snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) return LinearProgressIndicator();
//       return _buildList(context, snapshot.data.docs);
//     },
//   );
// }
// Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//   return ListView(
//     padding: const EdgeInsets.only(top: 20.0),
//     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//   );
// }
// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//   final record = Record.fromSnapshot(data);
//   username = record.username;
//   return Padding(
//     key: ValueKey(record.username),
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: ListTile(
//           title: Text(record.username),
//           trailing: Text(record.points.toString()),
//           onTap: () => record.reference.update({'points': record.points + 1})
//       ),
//     ),
//   );
// }
// class Record {
//   final String username;
//   final int points;
//   final String guild;
//   final DocumentReference reference;
//   Record.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['username'] != null),
//         assert(map['points'] != null),
//         assert(map['guild'] != null),
//         username = map['username'],
//         points = map['points'],
//         guild = map['guild'];
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data(), reference: snapshot.reference);
//   @override
//   String toString() => "Record<$username:$points:$guild>";
