import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_provider/Model/DateModel.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDatabase();
      return _db!;
    }
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'mydata.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        email TEXT,
        password TEXT
      )
      ''');
  }

  Future<DataModel> register(DataModel dataModel) async {
    var dbClient = await db;
    await dbClient.insert('data', dataModel.toMap());
    return dataModel;
  }

  Future<List<DataModel>> getDataList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> getDateResult = await dbClient.query('data');
    return getDateResult.map((e) => DataModel.fromMap(e)).toList();
  }

  Future<void> deleteData(int id) async {
  var dbClient = await db;
  await dbClient.delete('data', where: 'id = ?', whereArgs: [id]);
}
  Future<bool> checkLogin(String username, String password) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'data',
      where: 'email = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }




  // Get data by Email
  Future<List<DataModel>> getDataByEmail(String email) async {
    var dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient.query(
      'data',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.map((e) => DataModel.fromMap(e)).toList();
  }


}