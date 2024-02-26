import 'package:companyspring/database/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _database = DatabaseService._internal();
  late Future<Database> database;

  factory DatabaseService() => _database;

  DatabaseService._internal() {
    database = databaseConfig();
  }

  Future<Database> databaseConfig() async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'companyspring.db'),
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE COMPANYSPRING_USER_MST(idx INTEGER PRIMARY KEY, user_id TEXT, password TEXT, nickname TEXT)',
          );
          await db.execute(
            'CREATE TABLE COMPANYSPRING_ROOM_MST(room_id INTEGER PRIMARY KEY, room_name TEXT)',
          );
        },
        version: 1,
      );
      return db;
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future<bool> insertUser(User user) async {
    final Database db = await database;
    try {
      db.insert(
        'COMPANYSPRING_USER_MST',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<User>> selectUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> data = await db.query('COMPANYSPRING_USER_MST');

    return List.generate(data.length, (i) {
      return User(
        idx: data[i]['idx'],
        userId: data[i]['user_id'],
        password: data[i]['password'],
        nickname: data[i]['nickname'],
      );
    });
  }

    Future<bool> selectDupUser(String userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> data =
        await db.query('COMPANYSPRING_USER_MST', where: "user_id = ?", whereArgs: [userId]);
        
        if(data.isEmpty) {
          return true;
        }else {
          return false;
        }
  }

    Future<bool> selectDupNickname(String nickname) async {
    final Database db = await database;
    final List<Map<String, dynamic>> data =
        await db.query('COMPANYSPRING_USER_MST', where: "nickname = ?", whereArgs: [nickname]);
        
        if(data.isEmpty) {
          return true;
        }else {
          return false;
        }
  }

  Future<User> selectUser(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> data =
        await db.query('COMPANYSPRING_USER_MST', where: "user_id = ?", whereArgs: [id]);

    return User(
      idx: data[0]['idx'], userId: data[0]['user_id'], password: data[0]['password'], nickname: data[0]['nickname']);
  }

  Future<bool> updateUser(User user) async {
    final Database db = await database;
    try {
      db.update(
        'COMPANYSPRING_USER_MST',
        user.toMap(),
        where: "user_id = ?",
        whereArgs: [user.userId],
        );
        return true;
    } catch (err) {
        return false;      
    }
  }

  Future<bool> deleteUser(int id) async {
    final Database db = await database;

    try {
      db.delete(
        'COMPANYSPRING_USER_MST',
        where: "user_id = ?",
        whereArgs: [id],
        );
        return true;
    } catch (err) {
        return false;
    }
  }

}
