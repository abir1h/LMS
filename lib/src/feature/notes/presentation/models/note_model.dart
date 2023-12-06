class NoteModel {
  int? id;
  String? title;
  String? time;
  List<dynamic>? description;

  NoteModel({
     this.title,
     this.time,
     this.description,
    this.id
  });
}