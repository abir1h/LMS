class NotePostModel {
  int? courseModuleId;
  int? contentId;
  String? contentType;
  String? title;
  String? description;
  int? status;
  NotePostModel({
     this.courseModuleId,
     this.contentId,
     this.contentType,
     this.title,
     this.description,
     this.status=1,
  });
  factory NotePostModel.fromJson(Map<String, dynamic> json) => NotePostModel(
    courseModuleId: json["course_module_id"],
    contentId: json["content_id"],
    contentType: json["content_type"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
  );
  Map<String, dynamic> toJson() => {
    "course_module_id": courseModuleId,
    "content_id": contentId,
    "content_type": contentType,
    "title": title,
    "description": description,
    "status": status,
  };
}
