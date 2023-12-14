class CommentModel {
  int commentId;
  String userName;
  String avatar;
  String comment;
  int likeCount;
  String createdAt;

  CommentModel({
    required this.commentId,
    required this.userName,
    required this.avatar,
    required this.comment,
    required this.likeCount,
    required this.createdAt,
  });
}
