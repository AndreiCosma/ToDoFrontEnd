import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';

class CredentialWidget extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const CredentialWidget(
      {Key key, this.usernameController, this.passwordController})
      : super(key: key);
  @override
  _CredentialWidgetState createState() =>
      _CredentialWidgetState(this.usernameController, this.passwordController);
}

class _CredentialWidgetState extends State<CredentialWidget> {
  bool isObscured = true;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  _CredentialWidgetState(this.usernameController, this.passwordController);

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
                  controller: usernameController,
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
                  controller: passwordController,
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
