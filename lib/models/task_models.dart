import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String titulo;
  Timestamp date;
  bool done;

  Task({this.id, this.titulo, this.date, this.done = false});

  Task.fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    this.titulo = map["titulo"];
    this.date = map["date"];
    this.done = map["done"];
  }
}
