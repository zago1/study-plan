import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  MyTextInput({Key key, this.title, this.onChange, this.isPassword});

  final String title;
  final void Function(String) onChange;
  final bool isPassword;

  _MyTextInput createState() => _MyTextInput(
      title: title, onChange: onChange, isPassword: isPassword || false);
}

class _MyTextInput extends State<MyTextInput> {
  _MyTextInput({Key key, this.title, this.onChange, this.isPassword});

  String title;
  void Function(String) onChange;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        primaryColor: Colors.grey[850],
      ),
      child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: this.title),
          cursorColor: Colors.grey[850],
          obscureText: this.isPassword,
          onChanged: (String inValue) {
            this.onChange(inValue);
          }),
    );
  }
}
