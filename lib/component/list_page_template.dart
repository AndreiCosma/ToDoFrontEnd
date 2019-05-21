import 'package:flutter/material.dart';

class ListPageTemplate extends StatelessWidget {
  ListPageTemplate({this.listWidget, this.callback});

  final Widget listWidget;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: listWidget,
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: callback,
                child: Container(
                  child: Center(
                    child: Text('+ Add New'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
