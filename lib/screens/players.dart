import 'game.dart';
import 'package:flutter/material.dart';
import 'start.dart';
import 'quick_game.dart';
import '../main.dart';

Map stats = {
  "player1": {"name": "", "score": [], "firstToGo": null},
  "player2": {"name": "", "score": [], "firstToGo": null}
};

createPlayers(String player, String name) {
  stats[player]["name"] = name;
  return stats;
}

class ScreenArguments {
  final Logic logic;
  Map stats;
  ScreenArguments(this.logic, this.stats);
}

class Players extends StatelessWidget {
  //List tricks;
  //Players(this.tricks);
  final Logic logic;
  Players(this.logic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Player 1, enter your name:"),
            TextField(
              //obscureText: true,
              onSubmitted: (String value) async {
                Map stats = await createPlayers("player1", value);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: RouteSettings(name: "Players2"),
                      builder: (context) => Players2(stats, logic)), //tricks,
                );
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Player 1',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Players2 extends StatelessWidget {
  //List tricks;
  Logic logic;
  Map stats;
  Players2(this.stats, this.logic); //this.tricks,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Player 2, enter your name:",
                style: TextStyle(
                  color: Color(0xffE47474),
                )),
            TextField(
              //obscureText: true,
              onSubmitted: (String value) async {
                Map stats = await createPlayers("player2", value);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: RouteSettings(name: "QuickGame"),
                      builder: (context) => QuickGame(stats)), //tricks,
                );
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Player 2',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
