import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_plan/bloc/database_bloc.dart';
import 'package:study_plan/bloc/database_event.dart';
import 'package:study_plan/models/task_models.dart';
import 'package:study_plan/scoped_models/global_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({this.task}) : super();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SelectedTask>(
        builder: (BuildContext _context, Widget child, SelectedTask model) {
      return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: task.done ? Colors.green : Colors.red,
              ),
              title: Text(task.titulo),
              subtitle: Text(task.date.toDate().toIso8601String()),
              trailing: Wrap(spacing: 12, children: [
                GestureDetector(
                    child: Icon(Icons.edit),
                    onTap: () {
                      model.selectedTask = task;
                      DefaultTabController.of(context).animateTo(1);
                    }),
                GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      BlocProvider.of<DatabaseBloc>(context)
                          .add(DeleteDatabase(docId: task.id));
                    }),
              ]),
            ),
          ));
    });
  }
}
