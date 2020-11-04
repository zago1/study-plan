import 'package:flutter/material.dart';
import 'package:study_plan/components/TextInput.dart';
import 'package:study_plan/model/User/user_database.dart';
import 'package:study_plan/screens/NewUser.dart';

class LoginData {
  String username = "";
  String password = "";
}

class LoginWidget extends StatefulWidget {
  final LoginData loginData = new LoginData();

  @override
  State<StatefulWidget> createState() {
    return _LoginWidgetState(loginData);
  }
}

class _LoginWidgetState extends State<LoginWidget> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final LoginData loginData;

  _LoginWidgetState(this.loginData);

  _onPress() async {
    formKey.currentState.validate();
    formKey.currentState.save();
    if (loginData.username == "" ||
        loginData.password == "" ||
        loginData.password.length < 0) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Ops!"),
                content: Text("Preencha todos os campos corretamente!"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  )
                ],
                elevation: 1.0,
                backgroundColor: Colors.white);
          });
    } else {
      var userHelper = UserDatabaseHelper.user;
      var user =
          await userHelper.getUser(loginData.username, loginData.password);

      FocusScope.of(context).unfocus();
      print("email:");
      print(loginData.username);
      print("USER");
      print(user);
    }
  }

  _navigateToNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewUserWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Form(
                key: formKey,
                child: Column(
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
                    MyTextInput(
                      title: "Email",
                      onChange: (String inValue) {
                        setState(() {
                          loginData.username = inValue;
                        });
                      },
                      isPassword: false,
                    ),
                    MyTextInput(
                      title: "Senha",
                      onChange: (String inValue) {
                        setState(() {
                          loginData.password = inValue;
                        });
                      },
                      isPassword: true,
                    ),
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
                        child: Text("Entrar"),
                        color: Colors.grey[850],
                        textColor: Colors.white,
                        onPressed: _onPress,
                      ),
                    ),
                    Divider(
                      height: 8,
                      color: Colors.transparent,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 42,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: OutlineButton(
                        borderSide: const BorderSide(color: Colors.grey),
                        child: Text("Cadastro"),
                        textColor: Colors.grey[900],
                        onPressed: _navigateToNewUser,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
