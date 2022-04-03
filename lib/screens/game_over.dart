import 'package:flibers/screens/quick_game.dart';
import 'package:flibers/screens/custom_game.dart';

import 'game.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class GameOver extends StatelessWidget {
  //const GameOver({Key? key}) : super(key: key);
  List tricks;
  Map stats;
  String gameMode;

  GameOver(this.tricks, this.stats, this.gameMode, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Game Over!"),
            ElevatedButton(
              style: AppStyle().buttonStyle,
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('Game'));
              },
              child: const Text("Play Again"),
            ),
            ElevatedButton(
              style: AppStyle().buttonStyle,
              onPressed: () {
                switch (gameMode) {
                  case "Quick Game":
                    Navigator.popUntil(
                        context, ModalRoute.withName('QuickGame'));
                    break;
                  case "Custom Game":
                    Navigator.popUntil(
                        context, ModalRoute.withName('CustomGame'));
                    break;
                  default:
                }
              },
              child: const Text('New Game'),
            ),
          ],
        ),
      ),
    );
  }
}
