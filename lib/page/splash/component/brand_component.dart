import 'package:flutter/material.dart';
import 'package:check_list_front_end/util/constants.dart';

class BrandWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white70,
                  width: 4.0,
                ),
              ),
              child: Text(
                'To-Do',
                style: kBrandingTextStyle,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'EASIER THAN EVER',
              style: kBrandingMessageTextStyle,
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: 64.0,
              height: 3.0,
              child: Container(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      );
}
