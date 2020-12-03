import 'package:flutter/material.dart';
import 'package:my_first_rest_flutter/services/notes_service.dart';
import 'package:my_first_rest_flutter/services/theme.dart';
import 'package:my_first_rest_flutter/views/note_list.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.getTheme(
        //primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}
