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
    print(path);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS "Status" (
    	"id"	INTEGER NOT NULL,
    	"name"	TEXT NOT NULL,
    	PRIMARY KEY("id" AUTOINCREMENT)
    );
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS "Tasks" (
    	"id"	INTEGER NOT NULL,
    	"title"	TEXT,
    	"description"	TEXT,
    	"status"	TEXT,
    	"status_id"	INTEGER,
    	PRIMARY KEY("id" AUTOINCREMENT),
    FOREIGN KEY("status_id") REFERENCES "Status"("id")
    );
    ''');
  }

  Future<void> deleteTask() async {
    Database db = await instance.db;
    await db.delete("Tasks", where: "id > ?", whereArgs: [0]);
  }

  Future<void> insertTask(Task task) async {
    Database db = await instance.db;

    await db.insert('Tasks', {
      'title': task.title,
      'description': task.description ?? "",
      'status': "opened",
    });
  }

  Future<List<Map<String, Object?>>> getCountOpenTasks() async {
    Database db = await instance.db;
    return await db.query(
      "Tasks",
      columns: ["count(*) as count"],
      where: "status = 'opened'",
    );
  }

  Future<List<Map<String, Object?>>> getFilteredTasks({
    required String status,
  }) async {
    Database db = await instance.db;
    return await db.query(
      "Tasks",
      columns: ["count(*) as count"],
      where: "status = '$status'",
    );
  }

  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database db = await instance.db;
    return await db.query('Tasks');
  }

  // Future<int> updateUser(Task task) async {
  //   Database db = await instance.db;
  //   return await db.update(
  //     'Tasks',
  //     task.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [task.id],
  //   );
  // }

  Future<void> initializeTasks() async {
    await insertTask(
      Task(title: "Первая задача", description: "Открыть приложение"),
    );
  }
}
