class GetMeData{
  GetMeData({this.statusCode, this.success, this.payload});

  final int? statusCode;
  final bool? success;

  final PayloadGetMeData? payload;

  factory GetMeData.fromJson(Map<String, dynamic> json) =>
      GetMeData(
          statusCode: json["statusCode"],
          success: json["success"],
          payload: PayloadGetMeData.fromJson(json["payload"]));
}

class PayloadGetMeData {
  PayloadGetMeData(
      this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.avatar,
      this.email,
      this.phoneNumber,
      this.isOnline,
      this.role,
      this.createdAt,
      this.updatedAt);

  int id;
  String firstName;
  String? lastName;
  String? username;
  String? avatar;
  String? email;
  String? phoneNumber;
  bool isOnline;
  String role;
  String createdAt;
  String updatedAt;

  factory PayloadGetMeData.fromJson(Map<String, dynamic> json) =>
      PayloadGetMeData(
        json["id"],
        json["first_name"],
        json["last_name"],
        json["username"],
        json["avatar"],
        json["email"],
        json["phone_number"],
        json["is_online"],
        json["role"],
        json["createdAt"],
        json["updatedAt"]
      );
}
