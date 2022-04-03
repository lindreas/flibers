import 'package:flutter/material.dart';
import '../main.dart';
import 'game.dart';

class StartCheck extends StatelessWidget {
  //final Logic logic;
  final List tricks;

  StartCheck(this.tricks);

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
          const Text("Ready?"),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Game(tricks)),
              );*/ //GO TO GAME
            },
            child: const Text("START"),
          )
        ],
      )),
    );
  }
}
