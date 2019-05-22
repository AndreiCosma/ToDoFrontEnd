import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/page/splash/splash_page.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'component/credential.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    checkIfRefreshTokenIsValid();
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
                  child: CredentialWidget(),
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashPage(
                                      userLoginRequestDTO: UserLoginRequestDTO(
                                        username: 'AndreiCosma',
                                        password: 'P@rola12345',
                                        clientName: kClientNameVal,
                                        clientSecret: kClientSecretVal,
                                        deviceUUID: Uuid().v4(),
                                      ),
                                      hasToken: false,
                                    ),
                              ),
                            );
                          },
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

  void checkIfRefreshTokenIsValid() async {
    try {
      print(await _userService.refreshToken());
      Navigator.pushReplacement(
        this.context,
        MaterialPageRoute(
          builder: (context) => SplashPage(
                userLoginRequestDTO: UserLoginRequestDTO(),
                hasToken: true,
              ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
