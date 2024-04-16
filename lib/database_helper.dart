import 'package:belajar_sq_flite/model/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  final String _tableName = 'task';

  Future<Database> _initializeDb() async {
    var db = openDatabase(join(await getDatabasesPath(), 'task_db.db'),
        onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY,
          taskName TEXT
        )''');
    }, version: 1);

    return db;
  }

  Future<void> insertTask(TaskModel taskModel) async {
    final Database db = await database;
    await db.insert(
      _tableName,
      taskModel.toMap(),
    );
  }

  Future<List<TaskModel>> getTask() async {
    final Database db = await database;
    final result = await db.query(_tableName);

    final taskModel = result.map((e) => TaskModel.fromMap(e)).toList();

    return taskModel;
  }

  Future<TaskModel> getTaskById(int id) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.map((e) => TaskModel.fromMap(e)).first;
  }

  Future<void> updateTask(TaskModel taskModel) async {
    final db = await database;
    await db.update(
      _tableName,
      taskModel.toMap(),
      where: 'id = ?',
      whereArgs: [taskModel.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
