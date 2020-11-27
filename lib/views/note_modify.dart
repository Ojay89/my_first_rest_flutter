import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_rest_flutter/models/note.dart';
import 'package:my_first_rest_flutter/services/notes_service.dart';

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

    setState(() {
      _isLoading = true;
    });

    notesService.getNote(widget.noteID).then((response) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Genrbug Hvis isEditing så skriv Rediger Note eller Opret Note
      appBar: AppBar(title: Text(isEditing ? "Rediger Note" : "Opret Note")),
      body: Padding(
        padding: const EdgeInsets.all(12),
          //Hvis loading så vis progressindicator eller vis Column
        child: _isLoading ? Center(child:  CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: "Titel til Note"
              ),
            ),
            Container(height: 8),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: "Skriv din note"
              ),
            ),
            Container(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: RaisedButton(
                child: Text("Gem",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
