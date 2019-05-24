import 'package:check_list_front_end/util/constants.dart';

class UserLoginRequestDTO {
  final String username;
  final String password;
  final String clientName;
  final String clientSecret;
  final String deviceUUID;

  UserLoginRequestDTO(
      {this.username,
      this.password,
      this.clientName,
      this.clientSecret,
      this.deviceUUID});

  Map<String, dynamic> toJson() => {
        kUsername: this.username,
        kUserPassword: this.password,
        kClientName: this.clientName,
        kClientSecret: this.clientSecret,
        kDeviceUUID: this.deviceUUID
      };

  @override
  String toString() {
    return 'UserLoginRequestDTO{username: $username, password: $password, clientName: $clientName, clientSecret: $clientSecret, deviceUUID: $deviceUUID}';
  }
}
