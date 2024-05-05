import 'package:flutter/material.dart';

import 'circular_data_model.dart';

@immutable
class AllCircularDataModel {
  final List<CircularDataModel> running;
  final List<CircularDataModel> upcoming;
  final List<CircularDataModel> completed;

  const AllCircularDataModel({
    required this.running,
    required this.upcoming,
    required this.completed,
  });

  factory AllCircularDataModel.fromJson(Map<String, dynamic> json) =>
      AllCircularDataModel(
        running: json["running"] != null
            ? List<CircularDataModel>.from(
                (json["running"]).map((x) => CircularDataModel.fromJson(x)))
            : [],
        upcoming: json["upcoming"] != null
            ? List<CircularDataModel>.from(
                (json["upcoming"]).map((x) => CircularDataModel.fromJson(x)))
            : [],
        completed: json["completed"] != null
            ? List<CircularDataModel>.from(
                (json["completed"]).map((x) => CircularDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "running": List<CircularDataModel>.from(running.map((x) => x.toJson())),
        "upcoming":
            List<CircularDataModel>.from(upcoming.map((x) => x.toJson())),
        "completed":
            List<CircularDataModel>.from(completed.map((x) => x.toJson())),
      };
}
