class NoteModel {
  int? id;
  String? title;
  String? time;
  String? reference;
  List<dynamic>? description;

  NoteModel({this.title, this.time, this.description, this.id, this.reference});
}
