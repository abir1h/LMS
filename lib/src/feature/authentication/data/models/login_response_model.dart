import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final Data? data;
  final String? message;

  LoginResponse({
    this.data,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;

  Data({
    this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  factory Data.empty() => Data(
        accessToken: "",
        refreshToken: "",
        expiresAt: DateTime.now(),
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_at": expiresAt?.toIso8601String(),
      };
}
