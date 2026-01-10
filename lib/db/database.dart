import 'package:path/path.dart' as package_path;
import 'package:sqflite/sqflite.dart';
import 'package:todo_locale_app/provider/task/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = package_path.join(databasesPath, 'task.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS "Tasks" (
    	"id" INTEGER,
    	"title"	TEXT,
    	"description" TEXT,
    )
    ''');
  }

  Future<void> insertUser(Task task) async {
    Database db = await instance.db;
    await db.insert('Tasks', {
      'id': 3,
      'title': "title",
      'description': 'description',
    });
  }

  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database db = await instance.db;
    return await db.query('Tasks');
  }

  Future<int> updateUser(Task task) async {
    Database db = await instance.db;
    return await db.update(
      'Tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.db;
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> initializeTasks() async {
    await insertUser(
      Task(id: 1, title: "Первая задача", description: "Открыть приложение"),
    );
  }
}
