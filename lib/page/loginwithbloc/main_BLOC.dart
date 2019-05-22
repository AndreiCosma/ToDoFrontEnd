import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/bloc/authentication/authentication_bloc.dart';
import 'package:check_list_front_end/bloc/authentication/authentication_event.dart';
import 'package:check_list_front_end/bloc/authentication/authentication_state.dart';
import 'package:check_list_front_end/page/list/list_page.dart';
import 'package:check_list_front_end/page/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_BLOC_page.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

//void main() {
//  BlocSupervisor().delegate = SimpleBlocDelegate();
//  runApp(App());
//}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc = AuthenticationBloc();

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc();
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized ||
                state is AuthenticationLoading) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return ListPage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginBLOCPage();
            }
          },
        ),
      ),
    );
  }
}
