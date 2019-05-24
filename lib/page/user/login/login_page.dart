import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'component/credential.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  NavigationBloc _navigationBloc;

  UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    checkIfRefreshTokenIsValid();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
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
                  CredentialWidget(
                    usernameController: usernameController,
                    passwordController: passwordController,
                    loginCallback: () {
                      _navigationBloc
                          .dispatchNavigationEventSplash(UserLoginRequestDTO(
                        username: usernameController.text,
                        password: passwordController.text,
                        clientName: kClientNameVal,
                        clientSecret: kClientSecretVal,
                        deviceUUID: Uuid().v4(),
                      ));
                    },
                  ),
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
                          _navigationBloc.dispatchNavigationEventRegister();
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
