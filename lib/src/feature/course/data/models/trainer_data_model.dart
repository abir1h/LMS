import 'package:flutter/cupertino.dart';

@immutable
class TrainerDataModel{
  final int id;
  final int emisUserId;
  final String fullnameEn;
  final String fullnameBn;

  const TrainerDataModel({
    required this.id,
    required this.emisUserId,
    required this.fullnameEn,
    required this.fullnameBn,
  });

  factory TrainerDataModel.fromJson(Map<String, dynamic> json) => TrainerDataModel(
    id: json["id"]??-1,
    emisUserId: json["emis_user_id"]??-1,
    fullnameEn: json["fullname_en"]??"",
    fullnameBn: json["fullname_bn"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emis_user_id": emisUserId,
    "fullname_en": fullnameEn,
    "fullname_bn": fullnameBn,
  };
}
