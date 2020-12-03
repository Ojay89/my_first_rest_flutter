import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_rest_flutter/models/api_response.dart';
import 'package:my_first_rest_flutter/models/note_for_listing.dart';
import 'package:my_first_rest_flutter/services/notes_service.dart';
import 'package:my_first_rest_flutter/views/note_modify.dart';
import 'note_delete.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.instance<NotesService>();

  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }
  _fetchNotes () async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse= await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mine Noter")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteModify()))
              .then((_) {
            _fetchNotes();
          });

          },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder:(_) {
          if(_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }

          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              //listens design
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].noteID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context,
                      //_ er Dart funktion - (_) er en variable når builder ikke skal bruge en paramter
                      builder: (_) => NoteDelete()
                  );
                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,),
                ),
                child: ListTile(
                  title: Text(
                    _apiResponse.data[index].noteTitle,
                    style: TextStyle(color: Theme
                        .of(context)
                        .primaryColor),
                  ),
                  subtitle: Text(
                      "Senest opdateret den ${formatDateTime(
                          _apiResponse.data[index].latestEditDateTime ?? _apiResponse.data[index].createDateTime)}"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => NoteModify(noteID: _apiResponse.data[index].noteID)));
                  },
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      ),
    );
  }
}
