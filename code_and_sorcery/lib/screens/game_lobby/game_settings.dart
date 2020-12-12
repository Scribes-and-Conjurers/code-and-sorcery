import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';

class GameSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GameSettingState();
  }
}

// Game widget sta
class GameSettingState extends State<GameSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 0),
              Text(
                'Difficulty',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  switch (difficulty) {
                    case 'Normal':
                      {
                        setState(() {
                          difficulty = 'Easy';
                          print('easy');
                        });
                      }
                      break;
                    case 'Easy':
                      {
                        setState(() {
                          difficulty = 'Normal';
                          print('normal');
                        });
                      }
                  }
                },
                child: Text(difficulty,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
