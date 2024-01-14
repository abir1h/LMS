import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  Data data;
  String message;

  LoginResponse({
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String url;

  Data({
    required this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}