import 'package:check_list_front_end/page/list/list_page.dart';
import 'package:check_list_front_end/page/splash/splash_page.dart';
import 'package:check_list_front_end/page/user/login/login_page.dart';
import 'package:check_list_front_end/page/user/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation/navigation_bloc.dart';
import 'bloc/navigation/navigation_event.dart';
import 'bloc/navigation/navigation_state.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final NavigationBloc _navigationBloc = NavigationBloc();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => BlocProvider<NavigationBloc>(
        bloc: _navigationBloc,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: BlocBuilder<NavigationEvent, NavigationState>(
            bloc: _navigationBloc,
            builder: (BuildContext context, NavigationState state) {
              if (state is NavigationStateMain) {
                return ListPage();
              } else if (state is NavigationStateLogin) {
                return LoginPage();
              } else if (state is NavigationStateRegister) {
                return RegisterPage();
              } else if (state is NavigationStateSplash) {
                return SplashPage(
                    userLoginRequestDTO: state.userLoginRequestDTO);
              }
            },
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _navigationBloc.dispose();
  }
}
