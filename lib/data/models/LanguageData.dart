class LanguageData {
  LanguageData({this.statusCode, this.success, this.payload});

  final int? statusCode;
  final bool? success;

  final List<PayloadLanguageData>? payload;

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
      statusCode: json["statusCode"],
      success: json["success"],
      payload: List<dynamic>.from(json['payload'])
          .map((i) => PayloadLanguageData.fromJson(i))
          .toList()
  );
}

class PayloadLanguageData {
  PayloadLanguageData(this.id, this.code, this.name);

  int id;
  String code;
  String name;

  factory PayloadLanguageData.fromJson(Map<String, dynamic> json) =>
      PayloadLanguageData(
        json["id"],
        json["code"],
        json["name"],
      );
}
