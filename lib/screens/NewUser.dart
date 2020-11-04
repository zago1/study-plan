import 'package:flutter/material.dart';
import 'package:study_plan/components/TextInput.dart';
import 'package:study_plan/model/User/user.dart';
import 'package:study_plan/model/User/user_database.dart';

class NewUserWidget extends StatefulWidget {
  final User userData = new User("", "", "");

  @override
  State<StatefulWidget> createState() {
    return _NewUserWidgetState(userData);
  }
}

class _NewUserWidgetState extends State<NewUserWidget> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final User userData;

  _NewUserWidgetState(this.userData);

  _onPress() async {
    formKey.currentState.validate();
    formKey.currentState.save();
    if (userData.email == "" ||
        userData.password == "" ||
        userData.name == "") {
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
    } else if (userData.password.length < 8) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Ops!"),
                content: Text("A senha deve conter mais de 8 caracteres!"),
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
      List user = await userHelper.getUserByEmail(userData.email);

      print("user");
      print(user);

      if (user.length == 0) {
        var insertedUser = await userHelper.insertUser(userData);

        if (insertedUser > 0) {
          setState(() {
            userData.email = "";
            userData.name = "";
            userData.password = "";
          });
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Sucesso!"),
                    content: Text("Cadastro realizado com sucesso!"),
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
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Ops!"),
                    content: Text("Ocorreu um erro ao cadastrar o usuário!"),
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
        }
      } else {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text("Ops!"),
                  content: Text("O email inserido já foi cadastrado!"),
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro"),
          backgroundColor: Colors.grey[850],
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
                      "Cadastro",
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
                      title: "Nome",
                      onChange: (String inValue) {
                        setState(() {
                          userData.name = inValue;
                        });
                      },
                      isPassword: false,
                    ),
                    MyTextInput(
                      title: "Email",
                      onChange: (String inValue) {
                        setState(() {
                          userData.email = inValue;
                        });
                      },
                      isPassword: false,
                    ),
                    MyTextInput(
                      title: "Senha",
                      onChange: (String inValue) {
                        setState(() {
                          userData.password = inValue;
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
                        child: Text("Cadastrar"),
                        color: Colors.grey[850],
                        textColor: Colors.white,
                        onPressed: _onPress,
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
