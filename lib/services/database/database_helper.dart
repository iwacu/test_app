// ignore_for_file: unused_element

import 'dart:io';

import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/respopnse.dart';
import 'package:momnotebook/models/timer.dart';
import 'package:momnotebook/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documensDirectory = await getApplicationDocumentsDirectory();
    String path = join(documensDirectory.path, 'momnotebook.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE baby(
        id INTEGER PRIMARY KEY,
        name TEXT,
        sex TEXT,
        birthDay TEXT,
        premature INTEGER,
        relationship TEXT 
      )
    ''');
    await db.execute('''
      CREATE TABLE timer(
        id INTEGER PRIMARY KEY,
        task INTEGER,
        h INTEGER,
        m INTEGER,
        s INTEGER
         
      )
    ''');
  }

  // read user tbl
  Future<Response<User>> getUser() async {
    Database db = await instance.database;
    var res = await db.query("user", where: "id = ?", whereArgs: [1]);
    print('chchchchchchchcchhc $res');
    return Response(
        object: res.isNotEmpty ? User.fromMap(res.first) : null,
        message: 'success',
        error: false);
  }

  // read timer tbl
  Future<Response<Timerr>> getTimerr(int id) async {
    Database db = await instance.database;
    var res = await db.query("timer", where: "id = ?", whereArgs: [id]);
    print('chchchchchchchcchhc $res');
    return Response(
        object: res.isNotEmpty ? Timerr.fromMap(res.first) : null,
        message: 'success',
        error: false);
  }

  // insert into user tbl
  Future<int> addUser(User user) async {
    Database db = await instance.database;
    return await db.insert('user', user.toMap());
  }

  // delete record
  Future<int> deleteRecord(int id) async {
    Database db = await instance.database;
    // await db.execute("delete from " + "timer");
    return await db.delete("timer", where: "id = ?", whereArgs: [id]);
  }

  // insert into timer tbl
  Future<int> addTimer(Timerr timerr) async {
    Database db = await instance.database;
    return await db.insert('timer', timerr.toMap());
  }

  // insert into baby tbl
  Future<int> addBaby(Baby baby) async {
    Database db = await instance.database;
    return await db.insert('baby', baby.toMap());
  }

  // drop table
  drop() async {
    Database db = await instance.database;
    await db.execute("DROP TABLE IF EXISTS user");
    await db.execute("DROP TABLE IF EXISTS baby");
    print('dropeddddddd');
  }
}
