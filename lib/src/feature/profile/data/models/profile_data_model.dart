import 'package:flutter/foundation.dart';

@immutable
class ProfileDataModel {
  final String name;
  final String email;
  final String profileImage;
  final String pdsId;
  final String designation;
  final String subject;
  final String institution;
  final String mobile;
  final String zila;
  final String type;

  const ProfileDataModel({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.pdsId,
    required this.designation,
    required this.subject,
    required this.institution,
    required this.mobile,
    required this.zila,
    required this.type,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
          name: json["name"] ?? "",
          email: json["email"] ?? "",
          profileImage: json["profile_image"] ?? "", ///TODO: change property
          pdsId: json["pdsid"] ?? "",
          designation: json["designation"] ?? "",
          subject: json["subject"] ?? "",
          institution: json["institution"] ?? "",
          mobile: json["mobile"] ?? "",
          zila: json["zila"] ?? "",
          type: json["type"] ?? "");

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profileImage": profileImage,
        "pdsid": pdsId,
        "designation": designation,
        "subject": subject,
        "institution": institution,
        "mobile": mobile,
        "zila": zila,
        "type": type,
      };
}
