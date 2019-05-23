import 'dart:convert';

import 'package:check_list_front_end/domain/dto/token_dto.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/domain/dto/user_registration_request_dto.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'json_service.dart';
import 'network_service.dart';

class UserService {
  NetworkService networkService = NetworkService();
  JsonService jsonService = JsonService();

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAccessToken);
  }

  Future<String> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rtVal = prefs.getString(kRefreshToken);

    TokenDTO tokenDTO =
        jsonService.decodeToken(await networkService.refreshToken(rtVal));

    await prefs.setString(kAccessToken, tokenDTO.accessToken);
    await prefs.setString(kRefreshToken, tokenDTO.refreshToken);
    return getToken();
  }

  Future<TokenDTO> attemptLogin(UserLoginRequestDTO userCredentials) async {
    TokenDTO tokenDTO = jsonService.decodeToken(
        await networkService.requestLogin(jsonEncode(userCredentials)));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kAccessToken, tokenDTO.accessToken);
    prefs.setString(kRefreshToken, tokenDTO.refreshToken);

    return tokenDTO;
  }

  Future registerUser(UserRegistrationDTO user) async {
    await networkService.requestNewAccount(jsonEncode(user));
    return;
  }
}
