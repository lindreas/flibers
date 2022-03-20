import 'package:flutter/material.dart';
import 'quick_game.dart';
import 'custom_game.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  final Logic logic;

  HomePage(this.logic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff194346),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuickGame(logic)),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomGame(logic)),
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
      MaterialPageRoute(builder: (context) => FlibersApp(logic)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
