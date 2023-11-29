import 'package:flutter/foundation.dart';

@immutable
class ActivityDurationDataModel {
  final List<int> x;
  final List<int> y;

  const ActivityDurationDataModel({required this.x, required this.y});

  factory ActivityDurationDataModel.fromJson(Map<String, dynamic> json) =>
      ActivityDurationDataModel(
          x: json['x'] == null ? [] : List<int>.from(json["x"].map((x) => x)),
          y: json['y'] == null ? [] : List<int>.from(json["y"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "x": List<dynamic>.from(x.map((x) => x)),
        "y": List<dynamic>.from(y.map((x) => x)),
      };
}
