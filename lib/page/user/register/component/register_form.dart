import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';

class RegisterFormWidget extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final TextEditingController emailController;

  RegisterFormWidget(
      {Key key,
      this.usernameController,
      this.passwordController,
      this.passwordConfirmationController,
      this.emailController})
      : super(key: key);

  @override
  _RegisterFormWidget createState() => _RegisterFormWidget(
      this.usernameController,
      this.passwordController,
      this.passwordConfirmationController,
      this.emailController);
}

class _RegisterFormWidget extends State<RegisterFormWidget> {
  bool isObscuredPassword = true;
  bool isObscurePasswordConfirmation = true;

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final TextEditingController emailController;

  _RegisterFormWidget(this.usernameController, this.passwordController,
      this.passwordConfirmationController, this.emailController);

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
                  obscureText: isObscuredPassword,
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
                          isObscuredPassword = !isObscuredPassword;
                        });
                      },
                      child: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                child: TextFormField(
                  controller: passwordConfirmationController,
                  obscureText: isObscurePasswordConfirmation,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black54,
                    hintText: 'Password confirmation',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    prefixIcon: Icon(Icons.lock),
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
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: kFormEmailItemDecoration,
                  autovalidate: true,
                  validator: (value) {},
                ),
              ),
            ),
          ],
        ),
      );
}
