class SendEmailData {
  SendEmailData(this.email);

  final String email;

  Map<String, dynamic> toJson() =>
      {
        "email": email,
      };
}


class SendEmailResponseData {

  SendEmailResponseData({this.statusCode, this.success, this.payload});
  final int? statusCode;
  final bool? success;

  final PayloadSendEmailData? payload;


  factory SendEmailResponseData.fromJson(Map<String, dynamic> json) => SendEmailResponseData(
    statusCode: json["statusCode"],
    success: json["success"],
    payload: PayloadSendEmailData.fromJson(json["payload"])
  );

}

class PayloadSendEmailData {
  PayloadSendEmailData(this.timer);
  int timer;


  factory PayloadSendEmailData.fromJson(Map<String, dynamic> json) => PayloadSendEmailData(
    json["timer"],
  );
}




