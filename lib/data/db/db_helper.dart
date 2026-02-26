import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_riverpod/data/model/task.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._();

  factory DbHelper() => _dbHelper;

  DbHelper._() {
    initDb();
  }

  static Database? _database;
  final String _tableName = "task";
  final String _dbName = "todo.db";

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE $_tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    taskTitle TEXT,
    taskDescription TEXT,
    time TEXT,
    date TEXT,
    taskPriority INTEGER,
    isCompleted INTEGER
    )
      """);
  }

  Future<Task> getTaskById(int id) async {
    final db = await initDb();
    final result = await db.query(_tableName, where: "id = ?", whereArgs: [id]);

    if (result.isEmpty) {
      throw Exception("Tugas nggak ketemu");
    }

    return result.map((result) => Task.fromMap(result)).first;
  }

  Future<List<Task>> getAllTask() async {
    final db = await initDb();
    final result = await db.query(_tableName, orderBy: "id");

    return result.map((result) => Task.fromMap(result)).toList();
  }

  Future<int> insertTask(Task task) async {
    final db = await initDb();
    return await db.insert(_tableName, task.toMap());
  }

  Future<List<Task>> getTasksByPriority(int priority) async {
    final db = await initDb();
    final result = await db.query(
      _tableName,
      where: "taskPriority = ?",
      whereArgs: [priority],
    );

    return result.map((result) => Task.fromMap(result)).toList();
  }

  Future<int> updateTask(int id, Task task) async {
    final db = await initDb();
    return await db.update(
      _tableName,
      task.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> removeTask(int id) async {
    final db = await initDb();
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  // nanti seed data disini
  Future<void> seeder() async {
    final dbClient = await db;

    final count = Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $_tableName"),
    );

    if (count != null && count > 0) return;
    final List<Task> dummies = [
      Task(
        taskTitle: "Meeting Project",
        taskDescription: "Diskusi fitur baru dengan tim mobile",
        time: "09:00",
        date: "24/02/2026",
        taskPriority: 3, // Tinggi
        isCompleted: 0
      ),
      Task(
        taskTitle: "Beli Bahan Makanan",
        taskDescription: "Susu, Roti, Telur, dan Buah",
        time: "16:30",
        date: "24/02/2026",
        taskPriority: 2, // Sedang
        isCompleted: 1
      ),
      Task(
        taskTitle: "Lari Pagi",
        taskDescription: "Jogging keliling kompleks 30 menit",
        time: "06:00",
        date: "25/02/2026",
        taskPriority: 1, // Rendah
        isCompleted: 1
      ),
      Task(
        taskTitle: "Bayar Tagihan",
        taskDescription: "Listrik dan Internet bulan ini",
        time: "19:00",
        date: "26/02/2026",
        taskPriority: 3, // Tinggi
        isCompleted: 0
      ),
    ];

    for (var task in dummies) {
      await insertTask(task);
    }
  }
}
