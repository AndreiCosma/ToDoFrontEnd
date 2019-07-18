import 'package:check_list_front_end/util/constants.dart';

class TokenDTO {
  final String accessToken;
  final String refreshToken;

  TokenDTO({this.accessToken, this.refreshToken});

  factory TokenDTO.fromJson(Map json) => TokenDTO(
      accessToken: json[kAccessToken], refreshToken: json[kRefreshToken]);
}
