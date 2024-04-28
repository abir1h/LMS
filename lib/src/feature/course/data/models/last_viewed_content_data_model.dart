import 'package:flutter/material.dart';

@immutable
class LastViewedContentDataModel {
  final String contentTitleEn;
  final String contentTitleBn;
  final String contentType;
  final int contentId;
  final int sort;
  final bool isCompleted;
  final String lastWatchTime;

  const LastViewedContentDataModel({
    required this.contentTitleEn,
    required this.contentTitleBn,
    required this.contentType,
    required this.contentId,
    required this.sort,
    required this.isCompleted,
    required this.lastWatchTime,
  });

  factory LastViewedContentDataModel.fromJson(Map<String, dynamic> json) =>
      LastViewedContentDataModel(
        contentTitleEn: json["content_title_en"] ?? "",
        contentTitleBn: json["content_title_bn"] ?? "",
        contentType: json["content_type"] ?? "",
        contentId: json["content_id"] ?? -1,
        sort: json["sort"] ?? -1,
        isCompleted: json["is_completed"] ?? false,
        lastWatchTime: json["last_watch_time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "content_title_en": contentTitleEn,
        "content_title_bn": contentTitleBn,
        "content_type": contentType,
        "content_id": contentId,
        "sort": sort,
        "is_completed": isCompleted,
        "last_watch_time": lastWatchTime,
      };
}
