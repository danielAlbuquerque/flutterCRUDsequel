import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableUser = "userTable";
  final String columndId = "id";
  final String columnUserName = "username";
  final String columnPassword = "password";   

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableUser($columndId INTEGER PRIMARY KEY, $columnUserName TEXT, $columnPassword TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableUser, user.toMap());
    return res;
  }

  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    var sql = "SELECT COUNT(*) FROM $tableUser";
    var list = await dbClient.rawQuery(sql);
    return Sqflite.firstIntValue(list);
  }

  Future<User> getUserById(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser where $columndId = $id");

    if(result.length == 0) return null;

    return new User.fromMap(result.first);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableUser, where: "$columndId = ?", whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(), where: "$columndId = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}