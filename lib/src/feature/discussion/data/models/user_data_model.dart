import 'package:flutter/foundation.dart';

@immutable
class UserDataModel {
  final int id;
  final String fullnameEn;
  final String fullnameBn;
  final String image;

  const UserDataModel({
    required this.id,
    required this.fullnameEn,
    required this.fullnameBn,
    required this.image,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"] ?? -1,
        fullnameEn: json["fullname_en"] ?? "",
        fullnameBn: json["fullname_bn"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname_en": fullnameEn,
        "fullname_bn": fullnameBn,
        "image": image,
      };
}
