import 'package:flutter/material.dart';

class UserFormItemTemplate extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final bool isObscured;

  const UserFormItemTemplate(
      {Key key,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.isObscured})
      : super(key: key);

  @override
  _UserFormItemTemplateState createState() => _UserFormItemTemplateState(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isObscured: isObscured,
      );
}

class _UserFormItemTemplateState extends State<UserFormItemTemplate> {
  final String hintText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  bool isObscured;

  _UserFormItemTemplateState(
      {this.hintText, this.prefixIcon, this.suffixIcon, this.isObscured});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
        child: TextFormField(
          obscureText: isObscured,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isObscured = !isObscured;
                });
              },
              child: suffixIcon,
            ),
          ),
        ),
      );
}
