import 'package:flutter/material.dart';

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
                  width: 4.0,
                ),
              ),
              child: Text(
                'To-Do',
                style: TextStyle(
                    fontSize: 96,
                    letterSpacing: -1.5,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'EASIER THAN EVER',
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.15,
                  textBaseline: TextBaseline.alphabetic,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: 64.0,
              height: 3.0,
              child: Container(
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      );
}
