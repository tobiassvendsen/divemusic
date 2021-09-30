import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  //Text controller for the textfield
  TextEditingController _textController = TextEditingController();

  //String variable to hold the stored notes read from storage
  String _notes = "";

  @override
  initState() {
    super.initState();
    loadNotes();
  }

  //Loads notes from storage using shared preferences
  loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedNotes = prefs.getString("notes").toString();
    if (savedNotes != 'null') {
      _notes = savedNotes;
    }
    setState(() {
      _textController.text = _notes;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  //Saves notes to shared preferences
  saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("notes", _textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _textController,
        expands: true,
        maxLines: null,
        onChanged: (text) => saveNotes(),
      ),
    );
  }
}
