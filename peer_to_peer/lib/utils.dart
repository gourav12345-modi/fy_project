import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<String> getAccessToken() async {
    // Retrieve the access token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }
}
