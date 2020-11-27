import 'package:flutter/material.dart';
import 'package:my_first_rest_flutter/services/notes_service.dart';
import 'package:my_first_rest_flutter/views/note_list.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => NotesService());
}

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}
