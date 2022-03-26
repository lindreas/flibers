import 'game_over.dart';
import 'players.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:math';

Random rng = Random();
int num = rng.nextInt(2) + 1;
int i = 0;

class Game extends StatefulWidget {
  List tricks;
  Map stats;

  Game(this.tricks, this.stats, {Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  static String firstPlayer = "player" + num.toString();

  Text player = Text(stats[firstPlayer]["name"] + ", your turn!");

  bool gameOver = false;
  bool landed = false;
  String currentTurn = firstPlayer;

  //bug: one more trick after gameover

  void gameLogic(bool bailed) {
    //gameOver = true;
    setState(() {
      if (!gameOver) {
        switch (currentTurn) {
          case "player1":
            player = Text(stats["player2"]["name"] + ", your turn!");
            if (bailed) {
              if (stats["player1"]["firstToGo"] == false) {
                switch (stats["player1"]["score"].length) {
                  case 0:
                    stats["player1"]["score"].add("S");
                    break;
                  case 1:
                    stats["player1"]["score"].add("K");
                    break;
                  case 2:
                    stats["player1"]["score"].add("A");
                    break;
                  case 3:
                    stats["player1"]["score"].add("T");
                    break;
                  case 4:
                    stats["player1"]["score"].add("E");
                    gameOver = true;
                    break;
                  default:
                }
              } else {
                stats["player1"]["firstToGo"] = false;
                stats["player2"]["firstToGo"] = true;
              }
            }
            currentTurn = "player2";
            break;
          case "player2":
            player = Text(stats["player1"]["name"] + ", your turn!");
            if (bailed) {
              if (stats["player2"]["firstToGo"] == false) {
                switch (stats["player2"]["score"].length) {
                  case 0:
                    stats["player2"]["score"].add("S");
                    break;
                  case 1:
                    stats["player2"]["score"].add("K");
                    break;
                  case 2:
                    stats["player2"]["score"].add("A");
                    break;
                  case 3:
                    stats["player2"]["score"].add("T");
                    break;
                  case 4:
                    stats["player2"]["score"].add("E");
                    gameOver = true;
                    break;
                  default:
                }
              } else {
                stats["player2"]["firstToGo"] = false;
                stats["player1"]["firstToGo"] = true;
              }
            }
            currentTurn = "player1";
            break;
          default:
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (gameOver) {
      stats["player1"]["score"] = [];
      stats["player2"]["score"] = [];
      gameOver = false;
      Future.delayed(Duration.zero, () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              settings: RouteSettings(name: "GameOver"),
              builder: (context) => GameOver(widget.tricks, stats)),
        );
      });
    }

    if (widget.tricks.length == i) {
      i = 0;
      widget.tricks.shuffle();
    }
    String currentTrick = widget.tricks[i];
    if (stats[firstPlayer]["firstToGo"] == null) {
      switch (firstPlayer) {
        case "player1":
          stats["player1"]["firstToGo"] = true;
          stats["player2"]["firstToGo"] = false;
          break;
        case "player2":
          stats["player2"]["firstToGo"] = true;
          stats["player1"]["firstToGo"] = false;
          break;
        default:
      }
    }
    print(stats);
    print(widget.tricks);
    print(widget.tricks.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff194346),
      ),
      drawer: const MyDrawer(),
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(stats["player1"]["name"].toString() +
              " score: " +
              stats["player1"]["score"]
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(',', '')),
          Text(stats["player2"]["name"].toString() +
              " score: " +
              stats["player2"]["score"]
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(',', '')),
          const SizedBox(
            height: 15,
          ),
          Text(player.data.toString()),
          Text(currentTrick),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              gameLogic(false);
              if (landed) {
                i += 1;
                landed = false;
              } else {
                landed = true;
              }
            },
            child: const Text("Landed!"),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              gameLogic(true);
              landed = false;
              i += 1;
            },
            child: const Text('Bailed!'),
          ),
        ]),
      ),
    );
  }
}



/*
class GameStart extends StatefulWidget {
  const GameStart({Key? key}) : super(key: key);

  @override
  State<GameStart> createState() => _GameStartState();
}

class _GameStartState extends State<GameStart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-5.0, 0.0),
    end: const Offset(10.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Text(stats["player1"]["name"]),
    );
  }
}*/
