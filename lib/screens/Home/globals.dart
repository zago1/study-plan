import 'package:study_plan/models/task_models.dart';

class SelectedTask {
  static SelectedTask _instance;

  factory SelectedTask({Task task}) {
    _instance ??= SelectedTask._internalConstructor(task);
    return _instance;
  }

  SelectedTask._internalConstructor(this.selectedTask);

  Task selectedTask;
}
