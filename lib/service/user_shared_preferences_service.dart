import 'package:check_list_front_end/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferencesService {
  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAccessToken);
    return token != null && token.isNotEmpty;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAccessToken);
  }

  Future persistToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAccessToken, token);
  }

  Future deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(kAccessToken);
  }

  Future<bool> hasRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kRefreshToken);
    return token != null && token.isNotEmpty;
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kRefreshToken);
  }

  Future persistRefreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kRefreshToken, token);
  }

  Future deleteRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(kRefreshToken);
  }
}
