import 'dart:convert';

import 'package:check_list_front_end/domain/dto/token_dto.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/domain/dto/user_registration_request_dto.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_service.dart';

class UserService {
  NetworkService networkService = NetworkService.getInstance();

  static UserService _instance;

  UserService._();

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAccessToken);
  }

  Future<String> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rtVal = prefs.getString(kRefreshToken);
    print('Token: $rtVal');
    TokenDTO tokenDTO =
        TokenDTO.fromJson(jsonDecode(await networkService.refreshToken(rtVal)));

    await prefs.setString(kAccessToken, tokenDTO.accessToken);
    await prefs.setString(kRefreshToken, tokenDTO.refreshToken);
    return getToken();
  }

  Future<TokenDTO> attemptLogin(UserLoginRequestDTO userCredentials) async {
    TokenDTO tokenDTO = TokenDTO.fromJson(jsonDecode(
        await networkService.requestLogin(userCredentials.toJson())));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAccessToken, tokenDTO.accessToken);
    await prefs.setString(kRefreshToken, tokenDTO.refreshToken);

    return tokenDTO;
  }

  Future registerUser(UserRegistrationDTO user) async {
    await networkService.requestNewAccount(jsonEncode(user));
    return;
  }

  static UserService getInstance() {
    if (_instance == null) {
      _instance = UserService._();
    }
    return _instance;
  }
}
