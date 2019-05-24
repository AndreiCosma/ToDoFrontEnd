import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:flutter/material.dart';

import 'component/credential.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  NavigationBloc _navigationBloc;

  UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    checkIfRefreshTokenIsValid();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Hello',
                              style: TextStyle(
                                fontSize: 96,
                                letterSpacing: -1.5,
                                textBaseline: TextBaseline.alphabetic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Sign in to your account',
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 0.15,
                                textBaseline: TextBaseline.alphabetic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        CredentialWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Don\'t have an account?',
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            InkWell(
                              onTap: () {
                                _navigationBloc
                                    .dispatchNavigationEventRegister();
                              },
                              child: Text(
                                'Create',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  void checkIfRefreshTokenIsValid() async {
    try {
      await _userService.refreshToken();
      _navigationBloc.dispatchNavigationEventMain();
    } catch (e) {
      print(e);
    }
  }
}
