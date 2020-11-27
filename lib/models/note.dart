class Note {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;

//Constructor //Initialiserer en instans af et NoteForListing objekt
  Note(
      {this.noteID,
      this.noteTitle,
      this.noteContent,
      this.createDateTime,
      this.latestEditDateTime});

  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      noteID: item["noteID"],
      noteTitle: item["noteTitle"],
      noteContent: item["noteContent"],
      createDateTime: DateTime.parse(
        item["createDateTime"],
      ),
      //hvis latestEditDateTime ikke er null, så send data, hvis den ikke er null så sæt den til null
      latestEditDateTime: item["latestEditDateTime"] != null
          ? DateTime.parse(item["latestEditDateTime"])
          : null,
    );
  }
}
