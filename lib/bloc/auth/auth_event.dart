import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AuthEventAuthenticate extends AuthEvent {
  final UserLoginRequestDTO userLoginRequestDTO;

  AuthEventAuthenticate(this.userLoginRequestDTO);
}

/*
 * Check if the cached token exists and is still valid.
 * If it's not valid, use the refresh token to try to get a new one.
 * If that fails too, yield @AuthStateFormUiPresent.
 */
class AuthEventCheckCached extends AuthEvent {}
