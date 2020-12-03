import 'package:my_first_rest_flutter/models/note.dart';
import 'package:my_first_rest_flutter/models/note_for_listing.dart';
import 'package:my_first_rest_flutter/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_first_rest_flutter/models/note_insert.dart';

class NotesService {
  static const API = "https://tq-notes-api-jkrgrdggbq-el.a.run.app";
  static const headers = {
    'apiKey': '0a8fe217-3938-4591-b882-c95482744bdf',
    'Content-Type': 'application/json'
  };

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
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: "Fejl opstået");
    }).catchError((_) => APIResponse<List<NoteForListing>>(
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

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(API + "/notes",
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        //jsonData viser json på en liste
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "Fejl opstået");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "Fejl opstået"));
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(API + "/notes/" + noteID, headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        //jsonData viser json på en liste
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "Fejl opstået");
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: "Fejl opstået"));
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(API + "/notes/" + noteID, headers: headers).then((data) {
      if (data.statusCode == 204) {
        //jsonData viser json på en liste
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "Fejl opstået");
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: "Fejl opstået"));
  }

}
