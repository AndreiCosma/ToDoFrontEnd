import 'package:check_list_front_end/util/constants.dart';

class UserRegistrationDTO {
  final String email;
  final String username;
  final String password;
  final String passwordConfirmation;
  final String clientName;
  final String clientSecret;

  UserRegistrationDTO(
      {this.email,
      this.username,
      this.password,
      this.passwordConfirmation,
      this.clientName,
      this.clientSecret});

  Map<String, dynamic> toJson() => {
        kUserEmail: this.email,
        kUserRegUsername: this.username,
        kUserPassword: this.password,
        kUserPasswordConfirmation: this.passwordConfirmation,
        kClientName: this.clientName,
        kClientSecret: this.clientSecret
      };
}
