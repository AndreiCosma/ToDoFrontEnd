import 'package:check_list_front_end/page/list/list_page.dart';
import 'package:check_list_front_end/page/splash/splash_page.dart';
import 'package:check_list_front_end/page/user/login/login_page.dart';
import 'package:check_list_front_end/page/user/register/register_page.dart';
import 'package:check_list_front_end/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) => BlocProvider<NavigationBloc>(
        bloc: _navigationBloc,
        child: MultiProvider(
          child: MainTest(),
          providers: <SingleChildCloneableWidget>[
            ChangeNotifierProvider<ThemeInfoNotifier>(
              builder: (_) => ThemeInfoNotifier(),
            )
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _navigationBloc.dispose();
  }
}

class MainTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeInfoNotifier>(context).getTheme,
      home: BlocBuilder<NavigationEvent, NavigationState>(
        bloc: BlocProvider.of<NavigationBloc>(context),
        builder: (BuildContext context, NavigationState state) {
          if (state is NavigationStateMain) {
            return ListPage();
          } else if (state is NavigationStateLogin) {
            return LoginPage();
          } else if (state is NavigationStateRegister) {
            return RegisterPage();
          } else if (state is NavigationStateSplash) {
            print(state.userLoginRequestDTO.toString());
            return SplashPage(userLoginRequestDTO: state.userLoginRequestDTO);
          }
          return Container();
        },
      ),
    );
  }
}
