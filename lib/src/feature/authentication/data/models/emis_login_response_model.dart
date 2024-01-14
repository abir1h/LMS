import 'dart:convert';

EMISLoginResponse loginResponseFromJson(String str) => EMISLoginResponse.fromJson(json.decode(str));

String loginResponseToJson(EMISLoginResponse data) => json.encode(data.toJson());

class EMISLoginResponse {
  Data data;
  String message;

  EMISLoginResponse({
    required this.data,
    required this.message,
  });

  factory EMISLoginResponse.fromJson(Map<String, dynamic> json) => EMISLoginResponse(
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