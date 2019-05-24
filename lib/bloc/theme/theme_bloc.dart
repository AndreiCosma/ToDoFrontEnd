import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/bloc/theme/theme_event.dart';
import 'package:check_list_front_end/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  // TODO: implement initialState
  ThemeState get initialState => null;

  @override
  Stream<ThemeState> mapEventToState(event) async* {
    if (event is ThemeEventLight) {
      yield ThemeStateLight();
    } else if (event is ThemeEventDark) {
      yield ThemeStateDark();
    }
  }

  void dispatchThemeEventDark() {
    dispatch(ThemeEventDark());
  }

  void dispatchThemeEventLight() {
    dispatch(ThemeEventLight());
  }
}
