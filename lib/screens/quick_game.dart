import 'package:flibers/screens/game.dart';
import 'package:flibers/models/tricks.dart';
import 'package:flutter/material.dart';
import 'players.dart';
import '../main.dart';

class QuickGame extends StatelessWidget {
  Map stats;
  String gameMode;

  QuickGame(this.stats, this.gameMode, {Key? key}) : super(key: key);

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
              var tricks = await Tricks().getRandom("Easy");
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: "Game"),
                    builder: (context) => Game(tricks, stats, gameMode)),
              );
            },
            child: const Text('Easy'),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {
              var tricks = await Tricks().getRandom("Medium");
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: "Game"),
                    builder: (context) => Game(tricks, stats, gameMode)),
              );
            },
            child: const Text('Medium'),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {
              var tricks = await Tricks().getRandom("Hard");
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: "Game"),
                    builder: (context) => Game(tricks, stats, gameMode)),
              );
            },
            child: const Text('Hard'),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {
              var tricks = await Tricks().getTricks();
              for (var i = 0; i < tricks.length; i++) {
                print(tricks[i]);
              }
              /*
              var tricks = await Logic().getRandom("Insane");
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: "Game"),
                    builder: (context) => Game(tricks, stats)),
              );*/
            },
            child: const Text('Insane (dev: get all tricks)'),
          ),
        ],
      )),
    );
  }
}
