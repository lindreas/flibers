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
  String gameMode;

  Game(this.tricks, this.stats, this.gameMode, {Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  static String firstPlayer = "player" + num.toString();

  Text player = Text(stats[firstPlayer]["name"] + ", set the trick!");

  bool landedSecondTry = false;
  bool gameOver = false;
  bool landed = false;
  bool player1SecondTry = false;
  bool player2SecondTry = false;
  String currentTurn = firstPlayer;

  void gameLogic(bool bailed) {
    setState(() {
      if (player1SecondTry && !bailed) {
        landedSecondTry = true;
        player1SecondTry = false;
        i += 1;
      }
      if (player2SecondTry && !bailed) {
        landedSecondTry = true;
        player2SecondTry = false;
        i += 1;
      }

      switch (currentTurn) {
        case "player1":
          if (!player1SecondTry) {
            if (stats["player2"]["firstToGo"] == true || bailed == true) {
              player = Text(stats["player2"]["name"] + ", set the trick!");
            } else {
              player = Text(stats["player2"]["name"] + ", land it!");
            }
          }

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
                  if (player1SecondTry) {
                    stats["player1"]["score"].add("E");
                    gameOver = true;
                  } else {
                    player = Text(stats["player1"]["name"] +
                        ", one more try! You bail, you lose.");
                    player1SecondTry = true;
                  }

                  break;
                default:
              }
            } else {
              stats["player1"]["firstToGo"] = false;
              stats["player2"]["firstToGo"] = true;
            }
          }

          if (!player1SecondTry) {
            currentTurn = "player2";
          } else {
            currentTurn = "player1";
            i -= 1;
          }

          break;

        case "player2":
          if (!player2SecondTry) {
            if (stats["player1"]["firstToGo"] == true || bailed == true) {
              player = Text(stats["player1"]["name"] + ", set the trick!");
            } else {
              player = Text(stats["player1"]["name"] + ", land it!");
            }
          }

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
                  if (player2SecondTry) {
                    stats["player2"]["score"].add("E");
                    gameOver = true;
                  } else {
                    player = Text(stats["player2"]["name"] +
                        ", one more try! You bail, you lose.");
                    player2SecondTry = true;
                  }

                  break;
                default:
              }
            } else {
              stats["player2"]["firstToGo"] = false;
              stats["player1"]["firstToGo"] = true;
            }
          }
          if (!player2SecondTry) {
            currentTurn = "player1";
          } else {
            currentTurn = "player2";
            i -= 1;
          }

          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (gameOver) {
      Future.delayed(Duration.zero, () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              settings: const RouteSettings(name: "GameOver"),
              builder: (context) =>
                  GameOver(widget.tricks, stats, widget.gameMode)),
        ).then((value) => setState(() {
              player = Text(stats[firstPlayer]["name"] + ", set the trick!");
              stats["player1"]["firstToGo"] = null;
              stats["player2"]["firstToGo"] = null;
              stats["player1"]["score"] = [];
              stats["player2"]["score"] = [];
              landedSecondTry = false;
              gameOver = false;
              landed = false;
              player1SecondTry = false;
              player2SecondTry = false;
            }));
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff194346),
        title: DropDownMenu(widget.gameMode),
        automaticallyImplyLeading: false,
      ),
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
                if (!landedSecondTry) {
                  i += 1;
                }
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
