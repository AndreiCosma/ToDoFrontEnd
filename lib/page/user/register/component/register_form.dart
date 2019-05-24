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
          ],
        ),
      );
}
