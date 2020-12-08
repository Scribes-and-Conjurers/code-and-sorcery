import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';

class GameSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GameSettingState();
  }
}

// Game widget state
class GameSettingState extends State<GameSettings> {
  List<bool> _difficulty = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game settings"),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 0),
              Text('Difficulty',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),),
              ToggleButtons(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Easy',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Normal',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Hard',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < _difficulty.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        _difficulty[buttonIndex] = true;
                      } else {
                        _difficulty[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: _difficulty,
                fillColor: Colors.white,
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
