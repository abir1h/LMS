import 'package:flutter/cupertino.dart';
import 'package:lms/src/feature/profile/data/models/emis_user_data_model.dart';

@immutable
class UserInfoDataModel {
  final int id;
  final int pdsId;
  final String createdAt;
  final String updateAt;
  final String deletedAt;
  final String role;
  final String status;
  final EmisUserDataModel? emisUserDataModel;

  const UserInfoDataModel(
      {required this.id,
      required this.pdsId,
      required this.createdAt,
      required this.updateAt,
      required this.deletedAt,
      required this.role,
      required this.status,
      required this.emisUserDataModel});

  factory UserInfoDataModel.fromJson(Map<String, dynamic> json) =>
      UserInfoDataModel(
        id: json["id"] ?? -1,
        pdsId: json["pdsId"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updateAt: json["update_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        role: json["role"] ?? "",
        status: json["status"] ?? "",
        emisUserDataModel: json['emisUser'] != null
            ? EmisUserDataModel.fromJson(json['emisUser'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pdsId": pdsId,
        "created_at": createdAt,
        "update_at": updateAt,
        "deleted_at": deletedAt,
        "role": role,
        "status": status,
        "emisUser": emisUserDataModel,
      };
}
