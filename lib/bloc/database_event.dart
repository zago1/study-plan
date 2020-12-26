import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_plan/models/task_models.dart';

abstract class DatabaseEvent {}

class UpdateDatabase extends DatabaseEvent {
  String bookId;
  String titulo;
  Timestamp date;
  bool done;

  UpdateDatabase({this.bookId, this.titulo, this.date, this.done});
}

class AddDatabase extends DatabaseEvent {
  String titulo;
  Timestamp date;
  bool done;

  AddDatabase({this.titulo, this.date, this.done});
}

class DeleteDatabase extends DatabaseEvent {
  String docId;
  DeleteDatabase({this.docId});
}

class ReceivedNewList extends DatabaseEvent {
  List<Task> tasks;
  ReceivedNewList(this.tasks);
}
