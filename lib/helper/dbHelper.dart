import 'package:election/model/namelist_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableTodo = 'election';
final String columnId = '_id';
final String columnName = 'name';
final String columnGroup = 'noOfGroup';

class ElectionProvider {
  Database db;

  Future open() async {
    String path = join(await getDatabasesPath(), "election.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE $tableTodo ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnName TEXT not NULL,
  $columnGroup INTEGER NULL)
''');
    });
  }

  Future<NamaListModel> insert(NamaListModel todo) async {
    open();
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<NamaListModel> getName(int id) async {
    open();
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnName, columnGroup],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return NamaListModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<NamaListModel>> getAllName() async {
    open();
    List<NamaListModel> lists = [];
    List<Map> maps = await db.query(
      tableTodo,
      columns: [columnId, columnName, columnGroup],
    );
    if (maps.length > 0) {
      lists = maps.map((e) => NamaListModel.fromMap(e)).toList();
    }
    return lists;
  }

  Future<int> delete(int id) async {
    open();
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(NamaListModel todo) async {
    open();
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
