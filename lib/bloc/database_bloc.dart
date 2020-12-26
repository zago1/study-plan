import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:study_plan/bloc/database_event.dart';
import 'package:study_plan/bloc/database_state.dart';
import 'package:study_plan/firebase/database.dart';
import 'package:study_plan/models/task_models.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseService _databaseService;
  StreamSubscription _databaseSubscription;

  DatabaseBloc(String uid) : super(UnAuthenticatedDatabaseState()) {
    _databaseService = DatabaseService(uid: uid);
    _databaseSubscription = _databaseService.tasks.listen((List<Task> event) {
      add(ReceivedNewList(event));
    });
  }

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    if (event is AddDatabase) {
      _databaseService.addTask(event.titulo, event.date, event.done);
    } else if (event is DeleteDatabase) {
      _databaseService.removeTask(event.docId);
    } else if (event is UpdateDatabase) {
      _databaseService.updateTask(
          event.bookId, event.titulo, event.date, event.done);
    } else if (event is ReceivedNewList) {
      yield TaskDatabaseState(event.tasks);
    }
  }

  @override
  Future<void> close() {
    _databaseSubscription.cancel();
    return super.close();
  }
}
