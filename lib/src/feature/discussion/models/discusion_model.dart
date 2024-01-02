import 'package:lms/src/feature/discussion/models/comment_model.dart';

class DiscussionModel {
  int? discussionId;
  String? title;
  String? description;
  String? userName;
  String? avatar;
  String? createdAt;
  List<CommentModel>? comments;

  DiscussionModel({
    this.discussionId,
    this.userName,
    this.title,
    this.description,
    this.avatar,
    this.createdAt,
    this.comments,
  });
}
