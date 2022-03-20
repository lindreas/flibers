import 'package:flutter/material.dart';
import '../main.dart';

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
