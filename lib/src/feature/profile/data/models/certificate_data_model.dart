class CertificateDataModel {
  final String courseNameEn;
  final String courseNameBn;
  final int courseProgress;
  final String certificateUrl;

  CertificateDataModel({
    required this.courseNameEn,
    required this.courseNameBn,
    required this.courseProgress,
    required this.certificateUrl,
  });

  factory CertificateDataModel.fromJson(Map<String, dynamic> json) =>
      CertificateDataModel(
        courseNameEn: json["course_name_en"] ?? "",
        courseNameBn: json["course_name_bn"] ?? "",
        courseProgress: json["courseprogress"] ?? -1,
        certificateUrl: json["certificateurl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "course_name_en": courseNameEn,
        "course_name_bn": courseNameBn,
        "courseprogress": courseProgress,
        "certificateurl": certificateUrl,
      };
}
