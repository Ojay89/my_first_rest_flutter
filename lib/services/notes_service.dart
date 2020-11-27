import 'package:my_first_rest_flutter/models/note.dart';
import 'package:my_first_rest_flutter/models/note_for_listing.dart';
import 'package:my_first_rest_flutter/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotesService {
  static const API = "https://tq-notes-api-jkrgrdggbq-el.a.run.app";
  static const headers = {"apiKey": "0a8fe217-3938-4591-b882-c95482744bdf"};

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + "/notes", headers: headers).then((data) {
      if (data.statusCode == 200) {
        //jsonData viser json på en liste
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: "Fejl opstået");
    })
        .catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: "Fejl opstået"));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + "/notes/" + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        //jsonData viser json på en liste
        final jsonData = json.decode(data.body);

        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: "Fejl opstået");
    }).catchError(
        (_) => APIResponse<Note>(error: true, errorMessage: "Fejl opstået"));
  }
}
