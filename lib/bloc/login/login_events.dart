import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final UserLoginRequestDTO userLoginRequestDTO;

  LoginButtonPressed(this.userLoginRequestDTO);

  @override
  String toString() =>
      'LoginButtonPressed { username: ${userLoginRequestDTO.username}, password: ${userLoginRequestDTO.password} }';
}
