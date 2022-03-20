import 'package:flutter/material.dart';
import 'start.dart';
import '../db.dart';
import '../main.dart';

class QuickGame extends StatelessWidget {
  Logic logic;

  QuickGame(this.logic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //separate button for back function?
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("Please select difficulty level",
              style: TextStyle(
                color: Color(0xffE47474),
              )),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () async {
              //_addItem();
              var tricks = await Logic().getRandom(1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameStart(tricks)),
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
            onPressed: () {
              //Logic()._deleteItem(8);
            },
            child: const Text('Hard'),
          ),
          ElevatedButton(
            style: AppStyle().buttonStyle,
            onPressed: () {
              print(SQLHelper.getItems);
            },
            child: const Text('Insane'),
          ),
        ],
      )),
    );
  }
}
