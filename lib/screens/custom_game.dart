import 'package:flutter/material.dart';
import 'package:flibers/screens/game.dart';
import 'package:flibers/models/tricks.dart';
import 'package:provider/provider.dart';
import 'package:flibers/models/db.dart';
import '../main.dart';

class TrickSelection extends StatefulWidget {
  Map stats;
  String gameMode;

  TrickSelection(this.stats, this.gameMode, {Key? key}) : super(key: key);

  @override
  _TrickSelectionState createState() => _TrickSelectionState();
}

class _TrickSelectionState extends State<TrickSelection> {
  List<String> _selectedItems = <String>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Tricks().getTricks(),
      builder: (context, _tricks) {
        if (_tricks.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Select Tricks"),
              centerTitle: true,
              backgroundColor: const Color(0xff194346),
            ),
            backgroundColor: const Color(0xff194346),
            body: Center(
              child: Column(
                children: <Widget>[
                  Flexible(
                      child: ListView.builder(
                    //scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    itemCount: _tricks.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          color: (_selectedItems
                                  .contains(_tricks.data![index]['name']))
                              ? Color(0xffE47474)
                              : Color(0xff194346),
                          child: ListTile(
                            onTap: () {
                              if (!_selectedItems
                                  .contains(_tricks.data![index]['name'])) {
                                setState(() {
                                  _selectedItems
                                      .add(_tricks.data![index]['name']);
                                });
                              } else {
                                setState(() {
                                  _selectedItems.removeWhere((val) =>
                                      val == _tricks.data![index]['name']);
                                });
                              }
                            },
                            title: Text(_tricks.data![index]['name'].toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Droid Sans",
                                    color: Colors.white)),
                          ));
                    },
                  )),
                  ElevatedButton(
                    style: AppStyle().buttonStyle,
                    onPressed: () {
                      _selectedItems.shuffle();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: const RouteSettings(name: "Game"),
                            builder: (context) => Game(
                                _selectedItems, widget.stats, widget.gameMode)),
                      );
                    },
                    child: const Text('Start Game'),
                  ),
                  ElevatedButton(
                    style: AppStyle().buttonStyle,
                    onPressed: () {
                      setState(() {
                        for (var i = 0; i < _tricks.data!.length; i++) {
                          _selectedItems.add(_tricks.data![i]['name']);
                        }
                      });
                    },
                    child: const Text('Add All'),
                  ),
                  ElevatedButton(
                    style: AppStyle().buttonStyle,
                    onPressed: () {
                      setState(() {
                        _selectedItems.removeRange(0, _selectedItems.length);
                      });
                    },
                    child: const Text('Remove All'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text("No data");
        }
      },
    );
    /*
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("Select List Items")),
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                    color: (_selectedItems.contains(index))
                        ? Colors.blue.withOpacity(0.5)
                        : Colors.transparent,
                    child: ListTile(
                      onTap: () {
                        if (!_selectedItems.contains(index)) {
                          setState(() {
                            _selectedItems.add(index);
                          });
                        } else {
                          setState(() {
                            _selectedItems.removeWhere((val) => val == index);
                          });
                        }
                      },
                      title: Text('$index'),
                    ));
              },
            )));*/
  }
}

/*
class TrickSelection extends StatelessWidget {
  const TrickSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff194346),
        title: const Text(
          "Choose tricks",
          style: TextStyle(
              fontSize: 20, fontFamily: "Droid Sans", color: Color(0xffE47474)),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton(
              items: null,
              onChanged: null,
              hint: const Text(
                "Easy",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Droid Sans",
                    color: Color(0xffE47474)),
              ),
            ),
            DropdownButton(
              items: null,
              onChanged: null,
              hint: const Text(
                "Medium",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Droid Sans",
                    color: Color(0xffE47474)),
              ),
            ),
            DropdownButton(
              items: null,
              onChanged: null,
              hint: const Text(
                "Hard",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Droid Sans",
                    color: Color(0xffE47474)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*

class _AddButton extends StatelessWidget {
  final Trick trick;

  const _AddButton({required this.trick, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<TrickModel, bool>(
      (cart) => cart.tricks.contains(trick),
    );
    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              var cart = context.read<TrickModel>();
              cart.add(trick);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

class _ListItem extends StatelessWidget {
  final int index;

  const _ListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<TrickModel, Trick>(
      (catalog)
    );
    return Container(
      child: Row(
        children: [SizedBox(width: 10), Expanded(child: Text(data))],
      ),
    );
  }
}*/
