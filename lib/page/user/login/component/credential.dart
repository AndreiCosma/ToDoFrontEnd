import 'package:flutter/material.dart';

class CredentialWidget extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback loginCallback;

  const CredentialWidget(
      {Key key,
      this.usernameController,
      this.passwordController,
      this.loginCallback})
      : super(key: key);
  @override
  _CredentialWidgetState createState() => _CredentialWidgetState(
      this.usernameController, this.passwordController, this.loginCallback);
}

class _CredentialWidgetState extends State<CredentialWidget> {
  bool isObscured = true;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback loginCallback;
  _CredentialWidgetState(
      this.usernameController, this.passwordController, this.loginCallback);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).cardColor,
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                ),
                prefixIcon: Icon(Icons.person),
              ),
              autovalidate: true,
              validator: (value) {},
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: isObscured,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).cardColor,
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                ),
                prefixIcon:
                    Icon(isObscured ? Icons.lock_outline : Icons.lock_open),
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 32.0),
            child: Text(
              'Forgot your password?',
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 0.0,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: loginCallback,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 36,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
