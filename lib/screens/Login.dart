import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_plan/bloc/auth_bloc.dart';
import 'package:study_plan/bloc/auth_event.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWidgetState();
  }
}

class _LoginWidgetState extends State<LoginWidget> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final LoginUser loginData = new LoginUser();

  _LoginWidgetState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    height: 48,
                    color: Colors.transparent,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value.length == 0) {
                          return "Por favor, preencha o campo Email!";
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        loginData.username = value;
                      },
                      decoration: InputDecoration(
                          hintText: "none@none.com", labelText: "Email")),
                  TextFormField(
                      validator: (value) {
                        if (value.length == 0) {
                          return "Por favor, preencha o campo Senha!";
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        loginData.password = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Senha", labelText: "Senha")),
                  Divider(
                    height: 16,
                    color: Colors.transparent,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 42,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: MaterialButton(
                        child: Text("Cadastro"),
                        color: Colors.grey[850],
                        textColor: Colors.white,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            BlocProvider.of<AuthBloc>(context).add(loginData);
                          }
                        }),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
