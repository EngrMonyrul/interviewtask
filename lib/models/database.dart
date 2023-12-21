import 'package:interviewtask/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  /*-------------------> Declaring Database <--------------------*/
  late Database _database;

  /*-------------------> Initializer Database with Constructor <--------------------*/
  DatabaseHandler() {
    createDatabase();
  }

  /*-------------------> Create and Open Database <--------------------*/
  createDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'myTask.db');
    _database = await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  /*-------------------> Creating Database Fields or Table <--------------------*/
  void _createDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        status INTEGER
      )
    ''');
  }

  /*-------------------> Inserting Database <--------------------*/
  createTask({required Task task}) async {
    return await _database.insert('tasks', task.toJson());
  }

  /*-------------------> Fetching Database <--------------------*/
  fetchTasks() async {
    final List<Map<String, dynamic>> dataMaps = await _database.query('tasks');
    return List.generate(dataMaps.length, (index) {
      return Task(
          id: dataMaps[index]['id'],
          title: dataMaps[index]['title'],
          description: dataMaps[index]['description'],
          status: dataMaps[index]['status']);
    });
  }

  /*-------------------> Update Database <--------------------*/
  updateTask({required int id, required Task task}) async {
    return await _database.update('tasks', task.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  /*-------------------> Delete Database <--------------------*/
  deleteTask({required int id}) async {
    return await _database.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
