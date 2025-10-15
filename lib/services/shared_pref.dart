import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static String userIdKey = 'USER_ID_KEY';
  static String userEmailKey = 'USER_EMAIL_KEY';
  static String userNameKey = 'USER_NAME_KEY';
  static String userAvatarKey = 'USER_AVATAR_KEY';

  // Save data to shared preferences
  static Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, userId);
  }

  static Future<bool> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, email);
  }

  static Future<bool> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, name);
  }

  static Future<bool> saveUserAvatar(String avatarUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userAvatarKey, avatarUrl);
  }

  // Retrieve data from shared preferences
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<String?> getUserAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userAvatarKey);
  }
}
