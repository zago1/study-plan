import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_plan/bloc/database_bloc.dart';
import 'package:study_plan/bloc/database_state.dart';
import 'package:study_plan/models/task_models.dart';
import 'package:study_plan/scoped_models/global_model.dart';
import 'book_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SelectedTask>(
        builder: (BuildContext _context, Widget child, SelectedTask model) {
      model.selectedTask = Task();
      return BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          if (state is TaskDatabaseState) {
            List<Task> list = state.tasks;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return TaskTile(task: list[index]);
                });
          } else {
            return null;
          }
        },
      );
    });
  }
}
