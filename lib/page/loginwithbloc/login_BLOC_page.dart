import 'package:check_list_front_end/bloc/authentication/authentication_bloc.dart';
import 'package:check_list_front_end/bloc/login/login_bloc.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:check_list_front_end/service/user_shared_preferences_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'credential_BLOC.dart';

class LoginBLOCPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginBLOCPage();
}

class _LoginBLOCPage extends State<LoginBLOCPage> {
  UserService _userService = UserService();
  LoginBloc _loginBloc;
  UserSharedPreferencesService _userSharedPreferencesService =
      UserSharedPreferencesService();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomPadding: false,
        drawer: Drawer(),
        body: Container(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/login.png'),
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Hello',
                        style: kBrandingTextStyle,
                      ),
                      Text(
                        'Sign in to your account',
                        style: kBrandingMessageTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CredentialBLOCWidget(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 0.0,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {},
                          child: Icon(
                            Icons.arrow_forward,
                            size: 36,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      InkWell(
                        onTap: () {
                          print('create tap');
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
