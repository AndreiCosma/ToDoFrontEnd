import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/domain/dto/user_registration_request_dto.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/register_form.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  NavigationBloc _navigationBloc;
  UserService _userService = UserService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 48),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 34,
                          letterSpacing: 0.15,
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      )
                    ],
                  ),
                  RegisterFormWidget(
                    usernameController: usernameController,
                    passwordController: passwordController,
                    passwordConfirmationController:
                        passwordConfirmationController,
                    emailController: emailController,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 32.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Create',
                              style: TextStyle(
                                fontSize: 24,
                                letterSpacing: 0.0,
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              onPressed: () {
                                print('PRESSED ----CREATE------>');
                                _userService.registerUser(UserRegistrationDTO(
                                  email: emailController.text,
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  passwordConfirmation:
                                      passwordConfirmationController.text,
                                  clientSecret: kClientSecretVal,
                                  clientName: kClientNameVal,
                                ));

                                _navigationBloc.dispatchNavigationEventLogin();
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                size: 36,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 24,
                                letterSpacing: 0.0,
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              onPressed: () {
                                print('PRESSED ---------->');
                                _navigationBloc.dispatchNavigationEventLogin();
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                size: 36,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
