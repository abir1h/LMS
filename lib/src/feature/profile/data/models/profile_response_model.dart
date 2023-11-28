import 'package:flutter/foundation.dart';

import 'profile_data_model.dart';

@immutable
class ProfileResponseModel {
  final String message;
  final ProfileDataModel? data;
  final List<Map<String, String>>? errors;

  const ProfileResponseModel(
      {required this.message, required this.data, required this.errors});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
          message: json['message'] ?? "",
          data: json['data'] == null
              ? null
              : ProfileDataModel.fromJson(json["data"]),
          errors: json['error'] == null
              ? null
              : List<Map<String, String>>.from(json["error"].map((x) => x)));
}
