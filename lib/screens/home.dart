import 'package:flutter/material.dart';
import 'players.dart';
import 'custom_game.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  //final Logic logic;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String gameMode;
    return Scaffold(
      backgroundColor: const Color(0xff194346),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              //Navigator.pushNamed(context, '/players', arguments: logic);
              gameMode = "Quick Game";
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: "Players"),
                    builder: (context) => Players(gameMode)),
              );
            },
            child: const Text('Quick Game'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              gameMode = "Custom Game";
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: "Players"),
                    builder: (context) => Players(gameMode)),
              );
            },
            child: const Text('Custom Game'),
          ),
        ],
      )),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FlibersApp()),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
