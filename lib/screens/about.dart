import 'package:flutter/material.dart';
import '../main.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Text("This is the about page"),
      ),
    );
  }
}
