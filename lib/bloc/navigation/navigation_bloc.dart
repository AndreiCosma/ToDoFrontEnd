import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NavigationStateLogin();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    print('NAVIGATION HIT -----------> CURRENT STATE:$currentState');
    if (event is NavigationEventMainPage) {
      print('NAVIGATION HIT ----------->NextState:MAIN>');
      yield NavigationStateMain();
    } else if (event is NavigationEventLogin) {
      print('NAVIGATION HIT ----------->NextState:LOGIN>');
      yield NavigationStateLogin();
    } else if (event is NavigationEventRegister) {
      print('NAVIGATION HIT ---------->NextState:REGISTER>');
      yield NavigationStateRegister();
    } else if (event is NavigationEventSplash) {
      print('NAVIGATION HIT ----------->NextState:SPLASH>');
      yield NavigationStateSplash(event.userLoginRequestDTO);
    }
  }

  void dispatchNavigationEventMain() {
    dispatch(NavigationEventMainPage());
  }

  void dispatchNavigationEventLogin() {
    dispatch(NavigationEventLogin());
  }

  void dispatchNavigationEventRegister() {
    dispatch(NavigationEventRegister());
  }

  void dispatchNavigationEventSplash(UserLoginRequestDTO userLoginRequestDto) {
    dispatch(NavigationEventSplash(userLoginRequestDto));
  }
}
