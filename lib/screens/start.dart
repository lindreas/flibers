import 'package:flutter/material.dart';
import '../main.dart';

class GameStart extends StatelessWidget {
  //final Logic logic;
  final List tricks;

  GameStart(this.tricks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff194346),
      appBar: AppBar(
        //separate button for back function?
        backgroundColor: const Color(0xff194346),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("Ready?",
              style: TextStyle(
                color: Color(0xffE47474),
                fontSize: 50.0,
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              print(tricks); //GO TO GAME
            },
            child: const Text("START"),
          )
        ],
      )),
    );
  }
}
