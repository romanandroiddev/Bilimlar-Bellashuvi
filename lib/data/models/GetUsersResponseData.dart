class GetUsersResponseData {
  GetUsersResponseData({this.statusCode, this.success, this.payload});

  final int? statusCode;
  final bool? success;

  final PayloadUserData? payload;

  factory GetUsersResponseData.fromJson(Map<String, dynamic> json) =>
      GetUsersResponseData(
          statusCode: json["statusCode"],
          success: json["success"],
          payload: PayloadUserData.fromJson(json["payload"]));
}

class PayloadUserData {
  PayloadUserData(this.data, this.count);

  List<OpponentUserData> data;
  int count;

  factory PayloadUserData.fromJson(Map<String, dynamic> json) =>
      PayloadUserData(
        List<dynamic>.from(json['data'])
            .map((i) => OpponentUserData.fromJson(i))
            .toList(),
        json["count"],
      );
}

class OpponentUserData {
  OpponentUserData(
      this.id, this.firstName, this.username, this.avatar, this.isOnline);

  int id;
  String firstName;
  String? username;
  String? avatar;
  bool isOnline;

  factory OpponentUserData.fromJson(Map<String, dynamic> json) =>
      OpponentUserData(
        json["id"],
        json["first_name"],
        json["username"],
        json["avatar"],
        json["is_online"],
      );
}
