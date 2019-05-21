import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'component/brand_component.dart';

class SplashPage extends StatelessWidget {
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
}
