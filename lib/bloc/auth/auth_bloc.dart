import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthStateInitial();
  SharedPreferences _prefs;
  UserService _userService = UserService.getInstance();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    //Check Internet State
    if (await (Connectivity().checkConnectivity()) != ConnectivityResult.none) {
      //Device is connected to the internet
      try {
        _prefs = await SharedPreferences.getInstance();

        if (event is AuthEventAuthenticate) {
          yield* _mapAuthenticateToState(event.userLoginRequestDTO);
        } else if (event is AuthEventCheckCached) {
          yield* _mapCheckCachedToState();
        }
      } catch (e) {
        print(e);
        yield AuthStateUnexpectedError();
      }
    } else {
      // Device is not connected to the internet
      yield AuthStateNoInternet();
    }
  }

  Stream<AuthState> _mapAuthenticateToState(
      UserLoginRequestDTO userLoginRequestDTO) async* {
    await _userService.attemptLogin(userLoginRequestDTO);
    yield AuthStateAuthenticated();
  }

  Stream<AuthState> _mapCheckCachedToState() async* {
    //Retrieve the token and refresh token from shared preferences if they exist
    String accessToken = _prefs.getString(kAccessToken);
    String refreshToken = _prefs.getString(kRefreshToken);
    if (accessToken != null && refreshToken != null) {
      //refresh token for safety
      await _userService.refreshToken();

      //Continue to main screen.
      yield AuthStateAuthenticated();
    } else {
      //if there is no token and refresh token saved show the log-in ui.
      yield AuthStateFormUiPresent();
    }
  }

  void dispatchEventAuthenticate(UserLoginRequestDTO userLoginRequestDTO) {
    dispatch(AuthEventAuthenticate(userLoginRequestDTO));
  }

  void dispatchEventCheckCached() {
    dispatch(AuthEventCheckCached());
  }
}
