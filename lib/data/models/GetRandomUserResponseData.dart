class GetRandomUserResponseData {
  GetRandomUserResponseData({this.statusCode, this.success, this.payload});

  final int? statusCode;
  final bool? success;
  final PayloadRandomUserData? payload;

  factory GetRandomUserResponseData.fromJson(Map<String, dynamic> json) =>
      GetRandomUserResponseData(
          statusCode: json["statusCode"],
          success: json["success"],
          payload: PayloadRandomUserData.fromJson(json["payload"]));
}

class PayloadRandomUserData {
  PayloadRandomUserData(
      this.id, this.firstName, this.username, this.avatar, this.isOnline);

  int id;
  String firstName;
  String? username;
  String? avatar;
  bool isOnline;

  factory PayloadRandomUserData.fromJson(Map<String, dynamic> json) =>
      PayloadRandomUserData(
        json["id"],
        json["first_name"],
        json["username"],
        json["avatar"],
        json["is_online"],
      );
}
