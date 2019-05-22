import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/bloc/authentication/authentication_event.dart';
import 'package:check_list_front_end/bloc/authentication/authentication_state.dart';
import 'package:check_list_front_end/service/user_shared_preferences_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserSharedPreferencesService _userSharedPreferencesService =
      UserSharedPreferencesService();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await _userSharedPreferencesService.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await _userSharedPreferencesService.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await _userSharedPreferencesService.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
