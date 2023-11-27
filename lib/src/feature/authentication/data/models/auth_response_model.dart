import 'auth_data_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class AuthResponseModel {
  final String message;
  final AuthDataModel? data;
  final List<Map<String, String>>? errors;

  const AuthResponseModel(
      {required this.message, required this.data, required this.errors});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
          message: json['message'] ?? "",
          data: json['data'] == null
              ? null
              : AuthDataModel.fromJson(json["data"]),
          errors: json['error'] == null
              ? null
              : List<Map<String, String>>.from(json["error"].map((x) => x)));
}
