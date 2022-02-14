import 'package:flutter/material.dart';
import 'db.dart';

void main() {
  runApp(FlibersApp(new Logic()));
}

class Logic {
  //Change name of logic to maybe database value choices?
  void quickGame() {
    print("täällä 1");
  }

  void customGame() {
    print("täällä 2");
  }
}

class FlibersApp extends StatelessWidget {
  final Logic logic;

  FlibersApp(this.logic);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomePage(logic),
    );
  }
}

class HomePage extends StatelessWidget {
  final Logic logic;

  HomePage(this.logic);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontFamily: "Droid Sans"),
        primary: const Color(0xffE47474),
        minimumSize: const Size(225, 35));
    return Scaffold(
      backgroundColor: const Color(0xff194346),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
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
            style: style,
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

class QuickGame extends StatelessWidget {
  final Logic logic;

  QuickGame(this.logic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //separate button for back function?
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: const Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: Card(child: Text("Please select difficulty level")),
        ),
      ),
    );
  }
}

class CustomGame extends StatelessWidget {
  final Logic logic;

  CustomGame(this.logic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //separate button for back function?
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: const Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: Card(child: Text("Please select difficulty level")),
        ),
      ),
    );
  }
}
