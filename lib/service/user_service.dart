import 'dart:convert';

import 'package:check_list_front_end/domain/dto/token_dto.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'json_service.dart';
import 'network_service.dart';

class UserService {
  NetworkService networkService = NetworkService();
  JsonService jsonService = JsonService();

  static const String TOKEN = 'TOKEN';
  static const String REFRESH_TOKEN = 'REFRESH_TOKEN';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN);
  }

  Future<String> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rtVal = prefs.getString(REFRESH_TOKEN);

    TokenDTO tokenDTO =
        jsonService.decodeToken(await networkService.refreshToken(rtVal));

    await prefs.setString(TOKEN, tokenDTO.accessToken);
    await prefs.setString(REFRESH_TOKEN, tokenDTO.refreshToken);
    return getToken();
  }

  Future<TokenDTO> attemptLogin(UserLoginRequestDTO userCredentials) async {
    TokenDTO tokenDTO = jsonService.decodeToken(
        await networkService.requestLogin(jsonEncode(userCredentials)));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, tokenDTO.accessToken);
    prefs.setString(REFRESH_TOKEN, tokenDTO.refreshToken);

    return tokenDTO;
  }
}
