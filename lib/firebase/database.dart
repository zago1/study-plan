import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_plan/models/task_models.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference taskCollections =
      FirebaseFirestore.instance.collection("tasks");

  addTask(String titulo, Timestamp date, bool done) async {
    return await taskCollections
        .doc(uid)
        .collection("my_tasks")
        .add({"titulo": titulo, "date": date, "done": done});
  }

  removeTask(String taskId) async {
    return await taskCollections
        .doc(uid)
        .collection("my_tasks")
        .doc(taskId)
        .delete();
  }

  updateTask(String taskId, String titulo, Timestamp date, bool done) async {
    return await taskCollections
        .doc(uid)
        .collection("my_tasks")
        .doc(taskId)
        .update({"titulo": titulo, "date": date, "done": done});
  }

  Stream<List<Task>> get tasks {
    return taskCollections
        .doc(uid)
        .collection("my_tasks")
        .snapshots()
        .map(_taskListFromSnapshot);
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    List<Task> tasks = List();
    for (var doc in snapshot.docs) {
      tasks.add(Task.fromMap(doc.id, doc.data()));
    }
    return tasks;
  }
}
