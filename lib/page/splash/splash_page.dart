import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'component/brand_component.dart';

class SplashPage extends StatefulWidget {
  final UserLoginRequestDTO userLoginRequestDTO;
  const SplashPage({Key key, this.userLoginRequestDTO}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPage(userLoginRequestDTO);
}

class _SplashPage extends State<SplashPage> {
  NavigationBloc _navigationBloc;
  UserService _userService = UserService();
  final UserLoginRequestDTO userLoginRequestDTO;

  _SplashPage(this.userLoginRequestDTO);

  @override
  void initState() {
    super.initState();
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    attemptLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            fit: BoxFit.cover,
//            image: AssetImage('images/splash_screen.jpg'),
//          ),
//        ),
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
                  color: Theme.of(context).accentColor,
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
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.15,
                      textBaseline: TextBaseline.alphabetic,
                      fontWeight: FontWeight.normal),
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
      await _userService.attemptLogin(userLoginRequestDTO);
      await new Future.delayed(const Duration(seconds: 2));
      _navigationBloc.dispatchNavigationEventMain();
    } catch (e) {
      print(e);
      _navigationBloc.dispatchNavigationEventLogin();
      //navigate state to login
    }
  }
}
