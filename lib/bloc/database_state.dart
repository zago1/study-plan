import 'package:study_plan/models/task_models.dart';

abstract class DatabaseState {}

class UnAuthenticatedDatabaseState extends DatabaseState {}

class TaskDatabaseState extends DatabaseState {
  List<Task> tasks;
  TaskDatabaseState(this.tasks);
}
