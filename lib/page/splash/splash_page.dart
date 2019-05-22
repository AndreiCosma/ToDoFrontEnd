import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/page/list/list_page.dart';
import 'package:check_list_front_end/page/user/login/login_page.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'component/brand_component.dart';

class SplashPage extends StatefulWidget {
  final UserLoginRequestDTO userLoginRequestDTO;
  final bool hasToken;
  const SplashPage({Key key, this.userLoginRequestDTO, this.hasToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _SplashPage(userLoginRequestDTO, hasToken);
}

class _SplashPage extends State<SplashPage> {
  UserService _userService = UserService();
  final UserLoginRequestDTO userLoginRequestDTO;
  final bool hasToken;

  _SplashPage(this.userLoginRequestDTO, this.hasToken);

  @override
  void initState() {
    super.initState();
    print('SPLASH INIT HIT!>>>>>>>>>>>>>>>');
    attemptLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/splash_screen.jpg'),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: BrandWidget(),
            ),
            Positioned(
              bottom: 80.0,
              left: 16.0,
              right: 16.0,
              child: Center(
                child: SpinKitCubeGrid(
                  color: Colors.white70,
                ),
              ),
            ),
            Positioned(
              bottom: 32.0,
              right: 16.0,
              left: 16.0,
              child: Center(
                child: Text(
                  'LOADING',
                  style: kSecondaryTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void attemptLogin() async {
    try {
      if (hasToken == false) {
        await _userService.attemptLogin(userLoginRequestDTO);
      }
      await new Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListPage(),
        ),
      );
    } catch (e) {
      print(e);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }
}
