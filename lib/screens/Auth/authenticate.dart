import 'package:flutter/material.dart';
import 'package:study_plan/screens/Login.dart';
import 'package:study_plan/screens/NewUser.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            title: Text("Study Plan"),
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Row(
                  children: [Text("Efetuar Login")],
                )),
                Tab(
                    icon: Row(
                  children: [Text("Novo Registro")],
                )),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(children: [
            LoginWidget(),
            NewUserWidget(),
          ])),
    );
  }
}
