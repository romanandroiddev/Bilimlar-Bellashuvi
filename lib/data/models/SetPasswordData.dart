class SetPasswordData{
  final int? statusCode;
  final bool? success;
  SetPasswordData({this.statusCode, this.success});



  factory SetPasswordData.fromJson(Map<String, dynamic> json) => SetPasswordData(
      statusCode: json["statusCode"],
      success: json["success"],
  );
}