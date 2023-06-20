class ErrorBody{
  final int statusCode;
  final String message;

  ErrorBody(this.statusCode, this.message);


  factory ErrorBody.fromJson(Map<String, dynamic> json) =>
      ErrorBody(
        json["statusCode"],
        json["message"],
      );
}