import 'dart:convert';
import 'dart:io';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/data/models/GetMeData.dart';
import 'package:bilimlar_bellashuvi/data/models/LanguageData.dart';
import 'package:bilimlar_bellashuvi/data/models/LoginResponseData.dart';
import 'package:bilimlar_bellashuvi/data/models/SetPasswordData.dart';
import 'package:http/http.dart' as http;

import 'package:bilimlar_bellashuvi/data/models/SendEmailData.dart';

class ApiService {
  static const baseURL = "http://192.168.0.194:8080";

  Future<SendEmailResponseData> sendCodeToEmail(
      String firstName, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    final url = Uri.parse("$baseURL/auth/register/email");
    final response = await http.post(url,
        body: jsonEncode(
            {"first_name": firstName, "email": email, "password": password}),
        headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return SendEmailResponseData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<SendEmailResponseData> sendCodeToPhone(
      String firstName, String phone, String password) async {
    var headers = {'Content-Type': 'application/json'};
    final url = Uri.parse("$baseURL/auth/register/phone");
    final response = await http.post(url,
        body: jsonEncode({
          "first_name": firstName,
          "phone_number": phone,
          "password": password
        }),
        headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return SendEmailResponseData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<bool> update(String value, String paramName) async {
    String token = await SharedPreferencesHelper.getToken();

    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    final url = Uri.parse("$baseURL/user/profile");
    final response = await http.patch(url,
        body: jsonEncode({paramName: value}), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<bool> updateFullName(String name, String lastName) async {
    String token = await SharedPreferencesHelper.getToken();

    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    final url = Uri.parse("$baseURL/user/profile");
    final response = await http.patch(url,
        body: jsonEncode({'first_name': name, 'last_name': lastName}),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<LoginResponseData> login(String? email, String? password) async {
    var headers = {'Content-Type': 'application/json'};
    final url = Uri.parse("$baseURL/auth/login");
    final response = await http.post(url,
        body: jsonEncode({"email": email, "password": password}),
        headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return LoginResponseData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<LoginResponseData> loginWithPhoneNumber(
      String phone, String password) async {
    var headers = {'Content-Type': 'application/json'};
    final url = Uri.parse("$baseURL/auth/login");
    final response = await http.post(url,
        body: jsonEncode({"phone_number": phone, "password": password}),
        headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return LoginResponseData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<GetMeData> getMe() async {
    String token = await SharedPreferencesHelper.getToken();

    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    final url = Uri.parse("$baseURL/auth/me");
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return GetMeData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<LanguageData> getLanguages() async {
    var headers = {'Content-Type': 'application/json'};
    final url = Uri.parse("$baseURL/lang");
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return LanguageData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<SendEmailResponseData> resetCode(
      String paramName, String value) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseURL/auth/password/reset");
    final response = await http.post(url,
        headers: headers, body: jsonEncode({paramName: value}));

    if (response.statusCode == 200) {
      return SendEmailResponseData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<SetPasswordData> setNewPassword(String password) async {
    String token = await SharedPreferencesHelper.getToken();
    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    final url = Uri.parse("$baseURL/user/profile");
    final response = await http.patch(url,
        headers: headers, body: jsonEncode({"password": password}));

    if (response.statusCode == 200) {
      return SetPasswordData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<LoginResponseData> verifyPhoneNumber(String code, String phone) async {
    var headers = {'Content-Type': 'application/json'};
    final url = Uri.parse(
        "$baseURL/auth/verify-phone?verificationCode=$code&phone_number=$phone");
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return LoginResponseData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Future.error(jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to get data');
    }
  }
}
