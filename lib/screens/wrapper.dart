import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_plan/bloc/auth_bloc.dart';
import 'package:study_plan/bloc/auth_state.dart';
import 'package:study_plan/bloc/database_bloc.dart';
import 'package:study_plan/screens/Home/home.dart';

import 'Auth/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, AuthState state) {
        if (state is Authenticated) {
          return BlocProvider<DatabaseBloc>(
              create: (context) {
                return DatabaseBloc(state.user.uid);
              },
              child: Home());
        } else {
          return Authenticate();
        }
      },
      listener: (context, AuthState state) {
        if (state is AuthError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Erro no Servidor"),
                  content: Text(state.message),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      },
    );
  }
}
