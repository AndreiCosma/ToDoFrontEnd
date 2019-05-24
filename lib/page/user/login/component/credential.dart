import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/domain/dto/user_login_request_dto.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CredentialWidget extends StatefulWidget {
  @override
  _CredentialWidgetState createState() => _CredentialWidgetState();
}

class _CredentialWidgetState extends State<CredentialWidget> {
  bool _isObscured = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  NavigationBloc _navigationBloc;

  @override
  void initState() {
    super.initState();
    _navigationBloc = BlocProvider.of<NavigationBloc>(this.context);
    _usernameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  VoidCallback _getButtonCallback() =>
      _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty
          ? () {
              _navigationBloc.dispatchNavigationEventSplash(UserLoginRequestDTO(
                username: _usernameController.text,
                password: _passwordController.text,
                clientName: kClientNameVal,
                clientSecret: kClientSecretVal,
                deviceUUID: Uuid().v4(),
              ));
            }
          : null;

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
              controller: _usernameController,
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
              autovalidate: true,
              controller: _passwordController,
              obscureText: _isObscured,
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
                    Icon(_isObscured ? Icons.lock_outline : Icons.lock_open),
                suffixIcon: InkWell(
                  onTap: () => setState(() => _isObscured = !_isObscured),
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
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: _getButtonCallback(),
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
