import 'package:dive_music/notes.dart';
import 'package:dive_music/player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _navigationWidgets = [MusicPlayer(), Notes()];

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(index: _currentIndex, children: _navigationWidgets),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
            ),
            label: "Player",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.create_rounded,
            ),
            label: "Notes",
          )
        ],
        onTap: setCurrentIndex,
      ),
    );
  }
}
