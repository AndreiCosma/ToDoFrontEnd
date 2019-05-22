import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/bloc/authentication/authentication_bloc.dart';
import 'package:check_list_front_end/bloc/authentication/authentication_event.dart';
import 'package:check_list_front_end/domain/dto/token_dto.dart';
import 'package:check_list_front_end/service/user_service.dart';

import 'login_events.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService _userService = UserService();
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    this.authenticationBloc,
  }) : assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final TokenDTO token =
            await _userService.attemptLogin(event.userLoginRequestDTO);

        authenticationBloc.dispatch(LoggedIn(
            token: token.accessToken, refreshToken: token.refreshToken));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
