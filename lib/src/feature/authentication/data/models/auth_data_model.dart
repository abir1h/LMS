import 'package:flutter/foundation.dart';

import 'user_data_model.dart';

@immutable
class AuthDataModel {
  final UserDataModel? user;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final List<String> policy;

  const AuthDataModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.policy,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) => AuthDataModel(
        user:
            json["user"] != null ? UserDataModel.fromJson(json["user"]) : null,
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
        policy: json["policy"] == null
            ? []
            : List<String>.from(json["policy"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
        "policy": List<String>.from(policy.map((x) => x)),
      };
}
