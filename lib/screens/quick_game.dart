import 'package:flibers/screens/game.dart';
import 'package:flutter/material.dart';
import 'players.dart';
import '../main.dart';

class QuickGame extends StatelessWidget {
  Map stats;

  QuickGame(this.stats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("Please select difficulty level"),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {
              //_addItem();
              var tricks = await Logic().getRandom(1);
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(name: "Game"),
                    builder: (context) => Game(tricks, stats)),
              );
            },
            child: const Text('Easy'),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {
              var tricks = await Logic().getRandom(2);
              print(tricks);
            },
            child: const Text('Medium'),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {},
            child: const Text('Hard'),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {
              var tricks = await Logic().getTricks();
              for (var i = 0; i < tricks.length; i++) {
                print(tricks[i]);
              }
            },
            child: const Text('Insane (dev: get all tricks)'),
          ),
        ],
      )),
    );
  }
}
