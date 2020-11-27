class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

//Constructor //Initialiserer en instans af et NoteForListing objekt
  NoteForListing(
      {this.noteID,
      this.noteTitle,
      this.createDateTime,
      this.latestEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      noteID: item["noteID"],
      noteTitle: item["noteTitle"],
      createDateTime: DateTime.parse(
        item["createDateTime"],
      ),
      //hvis latestEditDateTime ikke er null, så send data, hvis den ikke er null så sæt den til null
      latestEditDateTime: item["latestEditDateTime"] != null? DateTime.parse(item["latestEditDateTime"]): null,
    );
  }
}
