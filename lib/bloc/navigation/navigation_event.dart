import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  NavigationEvent([List props = const []]) : super(props);
}

class NavigationEventLogin extends NavigationEvent {}

class NavigationEventRegister extends NavigationEvent {}

class NavigationEventMainPage extends NavigationEvent {}

class NavigationEventSplash extends NavigationEvent {
  final UserLoginRequestDTO userLoginRequestDTO;

  NavigationEventSplash(this.userLoginRequestDTO);
}
