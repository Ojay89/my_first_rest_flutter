import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_rest_flutter/models/note.dart';
import 'package:my_first_rest_flutter/models/note_manipulation.dart';
import 'package:my_first_rest_flutter/services/notes_service.dart';
import 'package:provider/provider.dart';

class NoteModify extends StatefulWidget {
  final String noteID;

  NoteModify({this.noteID});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.instance<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID).then((response) {
        setState(() {
          setState(() {
            _isLoading = false;
          });

          if (response.error) {
            errorMessage = response.errorMessage ?? "Fejl opstået";
          }
          note = response.data;
          _titleController.text = note.noteTitle;
          _contentController.text = note.noteContent;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Genrbug Hvis isEditing så skriv Rediger Note eller Opret Note
      appBar: AppBar(title: Text(isEditing ? "Rediger Note" : "Opret Note"),
          actions: <Widget>[
          IconButton(
          icon: Icon(Icons.save_rounded),
        onPressed: () async {
            if(isEditing) {
              setState(() {
                _isLoading = true;
              });
              final note = NoteManipulation(noteTitle: _titleController.text, noteContent: _contentController.text);
              final result = await notesService.updateNote(widget.noteID, note);
              setState(() {
                _isLoading = false;
              });
              final title = "Gennemført";
              final text = result.error? (result.errorMessage ?? "Fejl opstået"): "Note opdateret";
              showDialog(context: context,
              builder: (_) => AlertDialog (
                title: Text(title),
                content: Text(text),
                actions: <Widget> [
                  FlatButton(
                    child: Text ("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              );
            };
        }),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        //Hvis loading så vis progressindicator eller vis Column
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: TextField(
                      controller: _titleController,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(hintText: "Titel til Note"),
                    ),
                  ),
                  Container(
                    height: 12,
                  ),
                  TextField(
                    maxLines: 12,
                    controller: _contentController,
                    decoration: InputDecoration(
                        hintText: "Skriv din note",
                        border: OutlineInputBorder()),

                  ),
                 /* Container(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: RaisedButton(
                      child: Text("Gem",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        if (isEditing) {
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteManipulation(
                              noteTitle: _titleController.text,
                              noteContent: _contentController.text);
                          final result = await notesService.updateNote(widget.noteID, note);

                          setState(() {
                            _isLoading = false;
                          });

                          final title = "Gennemført";
                          final text = result.error
                              ? (result.errorMessage ?? 'Fejl opstået')
                              : 'Note opdateret';
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteManipulation(
                              noteTitle: _titleController.text,
                              noteContent: _contentController.text);
                          final result = await notesService.createNote(note);

                          setState(() {
                            _isLoading = false;
                          });

                          final title = "Gennemført";
                          final text = result.error
                              ? (result.errorMessage ?? 'Fejl opstået')
                              : 'Note oprettet';
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                    ),
                  ) */
                ],
              ),
      ),
    );
  }
}
