import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Advarsel"),
        content: Text("Er du sikker på at du vil slette noten?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ja"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text("Nej"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          )
        ]);
  }
}
