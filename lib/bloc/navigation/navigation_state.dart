import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  NavigationState([List props = const []]) : super(props);
}

class NavigationStateMain extends NavigationState {}

class NavigationStateLogin extends NavigationState {}

class NavigationStateRegister extends NavigationState {}

class NavigationStateSplash extends NavigationState {
  final UserLoginRequestDTO userLoginRequestDTO;

  NavigationStateSplash(this.userLoginRequestDTO);
}
