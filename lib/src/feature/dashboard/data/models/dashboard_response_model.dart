import 'package:flutter/foundation.dart';

import 'dashboard_data_model.dart';

@immutable
class DashboardResponseModel {
  final String message;
  final DashboardDataModel? data;
  final List<Map<String, String>>? errors;

  const DashboardResponseModel(
      {required this.message, required this.data, required this.errors});

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardResponseModel(
          message: json['message'] ?? "",
          data: json['data'] == null
              ? null
              : DashboardDataModel.fromJson(json["data"]),
          errors: json['error'] == null
              ? null
              : List<Map<String, String>>.from(json["error"].map((x) => x)));
}
