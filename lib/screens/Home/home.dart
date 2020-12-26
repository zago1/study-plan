import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_plan/bloc/auth_bloc.dart';
import 'package:study_plan/bloc/auth_event.dart';
import 'package:study_plan/scoped_models/global_model.dart';
import 'package:study_plan/screens/Home/task_entry.dart';
import 'package:study_plan/screens/Home/task_list.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  final SelectedTask _model = SelectedTask();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SelectedTask>(
      model: _model,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Home Screen"),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(Logout());
                    },
                    icon: Icon(Icons.person),
                    label: Text("logout"))
              ],
              bottom: TabBar(tabs: [
                Tab(
                    icon: Row(
                  children: [Icon(Icons.announcement), Text("Lista de Livros")],
                )),
                Tab(
                    icon: Row(
                  children: [Icon(Icons.cake), Text("Adicionar Livro")],
                ))
              ]),
            ),
            body: TabBarView(children: [
              TaskList(),
              TaskEntry(),
            ])),
      ),
    );
  }
}
