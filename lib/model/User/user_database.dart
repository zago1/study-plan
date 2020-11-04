import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:study_plan/model/User/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabaseHelper {
  static UserDatabaseHelper user = UserDatabaseHelper._createInstance();
  static Database _database;

  String userTable = "users";
  String colId = "id";
  String colEmail = "email";
  String colName = "name";
  String colPassword = "password";

  UserDatabaseHelper._createInstance();

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "users.db";

    var usersDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return usersDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $userTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colEmail varchar(50), $colName text, $colPassword varchar(8))");
  }

  insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  getUser(String email, String password) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "SELECT * FROM $userTable WHERE $colEmail = '$email' AND $colPassword = '$password'");
    return result;
  }

  getUserByEmail(String email) async {
    Database db = await this.database;
    var result = await db
        .rawQuery("SELECT * FROM $userTable WHERE $colEmail = '$email'");
    return result;
  }

  updateUser(User user) async {
    Database db = await this.database;
    var result = await db.update(userTable, user.toMap(),
        where: "$colId = ?", whereArgs: [user.id]);
    return result;
  }

  deleteUser(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete("DELETE FROM $userTable WHERE $colId = $id");
    return result;
  }
}
