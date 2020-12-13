import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

class AccountSetup extends StatefulWidget {
  AccountSetup({this.title, this.someText});
  final Widget title, someText;
  @override
  AccountSetupState createState() => new AccountSetupState();
}

class AccountSetupState extends State<AccountSetup> {
  final databaseReference = FirebaseFirestore.instance;
  final usernameController = TextEditingController();
  final guildController = TextEditingController();
  String usernameValue = "";
  String dropdownGuildValue = "";

  // set the default guild and class
  @override
  void initState() {
    super.initState();
    playerClass = 'Warrior';
    guild = 'Backenders';
  }

  @override
  Widget build(BuildContext ctxt) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: color3,
          ),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(40)),
                    Text('SET UP YOUR ACCOUNT, ADVENTURER!',
                        style: TextStyle(fontSize: 26)),
                    Padding(padding: EdgeInsets.all(40)),
                    Text("CHOOSE YOUR USERNAME"),
                    SizedBox(height: 10),
                    TextField(
                      controller: usernameController,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Type your username"),
                      onChanged: (String text) {
                        setState(() {
                          usernameValue = usernameController.text;
                          print('usernameValue $usernameValue');
                          print('test');
                          username = usernameValue;
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    Text("CHOOSE YOUR GUILD"),
                    SizedBox(height: 10),
                    InputDecorator(
                      decoration: const InputDecoration(
                        filled: true,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: "Backenders",
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 20,
                          elevation: 8,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownGuildValue = newValue;
                              guild = dropdownGuildValue;
                            });
                          },
                          items: <String>[
                            'Backenders',
                            'Frontenders',
                            'Fullstackers'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child:
                                  Text(value, style: TextStyle(fontSize: 16)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text("CLASS:"),
                    SizedBox(height: 10),
                    Container(
                      height: 64,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.orange,
                      ),
                      child: TextButton(
                        style:
                            TextButton.styleFrom(primary: Colors.transparent),
                        onPressed: () {
                          switch (playerClass) {
                            case 'Warrior':
                              {
                                setState(() {
                                  playerClass = 'Wizard';
                                  print('Wizard');
                                });
                              }
                              break;
                            case 'Wizard':
                              {
                                setState(() {
                                  playerClass = 'Warrior';
                                  print('Warrior');
                                });
                              }
                              break;
                            default:
                              {
                                setState(() {
                                  playerClass = 'Warrior';
                                });
                              }
                              break;
                          }
                        },
                        child: Text(
                          playerClass,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 50,
                      width: 300,
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.black, width: 1),
                      // ),
                      child: Text((() {
                        if (playerClass == 'Warrior') {
                          return 'Tough and mighty, Warriors add +1 to Party Health';
                        } else if (playerClass == 'Wizard') {
                          return 'Wise and perceptive, Wizards add a 10% chance of success in random events';
                        } else
                          return 'No class is selected!';
                      })()),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith(getColor2),
                        ),
                        onPressed: () {
                          if (usernameValue == '') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Please enter a username!"),
                                  );
                                });
                          } else {
                            setUsernameGuildClass();
                            Navigator.pushNamed(context, '/homepage');
                          }
                        },
                        child: Text('Submit'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // update username and guild for user in database
  void setUsernameGuildClass() async {
    await databaseReference.collection("users").doc(uID).update({
      'guild': guild,
      'username': username,
      'profileImg': '1',
      'points': 0,
      'playerClass': playerClass
    });
  }
}
