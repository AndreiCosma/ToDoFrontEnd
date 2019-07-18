import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/domain/dto/user_registration_request_dto.dart';
import 'package:check_list_front_end/service/user_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFormWidget extends StatefulWidget {
  @override
  _RegisterFormWidget createState() => _RegisterFormWidget();
}

class _RegisterFormWidget extends State<RegisterFormWidget> {
  bool isObscuredPassword = true;
  bool isObscurePasswordConfirmation = true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  NavigationBloc _navigationBloc;
  final UserService _userService = UserService.getInstance();

  @override
  void initState() {
    super.initState();
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
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
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: isObscuredPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                  ),
                  prefixIcon: Icon(isObscuredPassword
                      ? Icons.lock_outline
                      : Icons.lock_open),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscuredPassword = !isObscuredPassword;
                      });
                    },
                    child: Icon(Icons.remove_red_eye),
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              child: TextFormField(
                controller: passwordConfirmationController,
                obscureText: isObscurePasswordConfirmation,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  hintText: 'Password confirmation',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                  ),
                  prefixIcon: Icon(isObscurePasswordConfirmation
                      ? Icons.lock_outline
                      : Icons.lock_open),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscurePasswordConfirmation =
                            !isObscurePasswordConfirmation;
                      });
                    },
                    child: Icon(Icons.remove_red_eye),
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                autovalidate: true,
                validator: (value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Create',
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
                    onPressed: () {
                      print('PRESSED ----CREATE------>');
                      _userService.registerUser(UserRegistrationDTO(
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        passwordConfirmation:
                            passwordConfirmationController.text,
                        clientSecret: kClientSecretVal,
                        clientName: kClientNameVal,
                      ));

                      _navigationBloc.dispatchNavigationEventLogin();
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
