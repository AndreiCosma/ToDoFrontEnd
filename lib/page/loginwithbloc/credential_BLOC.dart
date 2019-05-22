import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';

class CredentialBLOCWidget extends StatefulWidget {
  @override
  _CredentialBLOCWidgetState createState() => _CredentialBLOCWidgetState();
}

class _CredentialBLOCWidgetState extends State<CredentialBLOCWidget> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                child: TextFormField(
                  decoration: kFormNameItemDecoration,
                  autovalidate: true,
                  validator: (value) {},
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                child: TextFormField(
                  obscureText: isObscured,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black54,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      child: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 32.0),
              child: Text(
                'Forgot your password?',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );
}
