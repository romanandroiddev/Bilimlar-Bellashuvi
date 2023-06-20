class LoginResponseData {
  LoginResponseData({this.statusCode, this.success, this.payload});

  final int? statusCode;
  final bool? success;

  final PayloadLoginData? payload;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      LoginResponseData(
          statusCode: json["statusCode"],
          success: json["success"],
          payload: PayloadLoginData.fromJson(json["payload"]));
}

class PayloadLoginData {
  PayloadLoginData(
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
      this.updatedAt,
      this.token);

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
  String token;

  factory PayloadLoginData.fromJson(Map<String, dynamic> json) =>
      PayloadLoginData(
        json["id"],
        json["first_name"],
        json["last_name"],
        json["username"],
        json["avatar"],
        json["email"],
        json["phoneNumber"],
        json["is_online"],
        json["role"],
        json["createdAt"],
        json["updatedAt"],
        json["token"],
      );
}
