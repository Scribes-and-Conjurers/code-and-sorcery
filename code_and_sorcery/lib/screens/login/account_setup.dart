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
  String dropdownGuildValue = "The Scarlet Authenticators";
  String _hintText = "Select your guild";

  // set the default guild and class
  @override
  void initState() {
    super.initState();
    playerClass = 'Warrior';
    guild = 'The Scarlet Authenticators';
  }

  @override
  Widget build(BuildContext ctxt) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: color1,
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
                        style: TextStyle(fontSize: 26, color: textBright)),
                    Padding(padding: EdgeInsets.all(40)),
                    Text("CHOOSE YOUR USERNAME",
                        style: TextStyle(fontSize: 18, color: textBright)),
                    SizedBox(height: 5),
                    Divider(thickness: 5.0, color: color3),
                    TextField(
                      style: TextStyle(color: textBright),
                      controller: usernameController,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: color3),
                          ),
                          hintText: "Type your username",
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: textBright)),
                      onChanged: (String text) {
                        setState(() {
                          usernameValue = usernameController.text;
                          print('usernameValue $usernameValue');
                          print('test');
                          username = usernameValue;
                        });
                      },
                    ),
                    SizedBox(height: 60),
                    Text("CHOOSE YOUR GUILD",
                        style: TextStyle(fontSize: 18, color: textBright)),
                    SizedBox(height: 5),
                    Divider(thickness: 5.0, color: color3),
                    InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        filled: true,
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(canvasColor: color2),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _hintText,
                            // icon: Icon(Icons.arrow_downward),
                            //iconSize: 20,
                            elevation: 8,
                            style: TextStyle(color: textBright, fontSize: 16),
                            underline: Container(
                              height: 1,
                              color: textBright,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownGuildValue = newValue;
                                guild = dropdownGuildValue;
                              });
                            },
                            items: <String>[
                              'The Scarlet Authenticators',
                              'The Callback Crusade',
                              'The Microtask Ascendancy'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        fontSize: 16, color: textBright)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text("CLASS:",
                        style: TextStyle(fontSize: 18, color: textBright)),
                    SizedBox(height: 5),
                    Divider(thickness: 5.0, color: color3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          warriorButton(),
                          wizardButton(),
                        ]),
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
                      })(), style: TextStyle(color: textBright)),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith(getColor3),
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
                        child:
                            Text('Submit', style: TextStyle(color: textDark)),
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

  Widget warriorButton() {
    return playerClass == 'Warrior'
        ? Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              color: Colors.orange[600],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  playerClass = 'Warrior';
                });
              },
              child: Text(
                'Warrior',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.orange[200],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  playerClass = 'Warrior';
                });
              },
              child: Text(
                'Warrior',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
  }

  Widget wizardButton() {
    return playerClass == 'Wizard'
        ? Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              color: Colors.orange[600],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  playerClass = 'Wizard';
                });
              },
              child: Text(
                'Wizard',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container(
            height: 64,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.orange[200],
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                setState(() {
                  playerClass = 'Wizard';
                });
              },
              child: Text(
                'Wizard',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
  }
}
