import 'package:flutter/material.dart';

@immutable
class UserDataModel {
  final String id;
  final String username;
  final String name;
  final String designation;
  final List<String> role;
  final String type;
  final String fcmToken;

  const UserDataModel({
    required this.id,
    required this.username,
    required this.name,
    required this.designation,
    required this.role,
    required this.type,
    required this.fcmToken,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        name: json["name"] ?? "",
        designation: json["designation"] ?? "",
        role: json["role"] == null
            ? []
            : List<String>.from(json["role"].map((x) => x)),
        type: json["type"] ?? "",
        fcmToken: json["fcm_token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "designation": designation,
        "role": List<String>.from(role.map((x) => x)),
        "type": type,
        "fcm_token": fcmToken,
      };
}
