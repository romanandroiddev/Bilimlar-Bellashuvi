import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{
  static const String _kIsSignedIn = "isSignedIn";
  static const String _kFirstName = "first_name";
  static const String _kLastName = "last_name";
  static const String _kLanguage = "language";
  static const String _kUserName = "username";
  static const String _kAvatar = "avatar";
  static const String _kEmailAddress = "umail_address";
  static const String _kPhoneNumber = "phone_number";
  static const String _kToken = "token";
  static const String _kRole = "role";



  static Future<bool> getIsSignedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsSignedIn) ?? false;
  }

  static Future<bool> setIsSignedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kIsSignedIn, value);
  }

  static Future<bool> setName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kFirstName, value);
  }

  static Future<bool> setLastName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kFirstName, value);
  }
  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kLanguage, value);
  }
  static Future<bool> setUserName(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kUserName, value??'');
  }

  static Future<bool> setToken(String value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kToken, value);
  }

  static Future<bool> setEmailAddress(String? value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kEmailAddress, value??'');
  }

  static Future<bool> setPhoneNumber(String? value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kPhoneNumber, value??'');
  }

  static Future<bool> setAvatar(String? value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kAvatar, value??'');
  }


  static Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kFirstName)??'';

  }

  static Future<String> getLastName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLastName)??'';

  }
  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserName)??'';
  }

  static Future<String> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kToken)??'';
  }

  static Future<String> getEmailAddress() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kEmailAddress)??'';
  }

  static Future<String> getAvatar() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAvatar)??'';
  }


  static void clearSharedPreferences() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}