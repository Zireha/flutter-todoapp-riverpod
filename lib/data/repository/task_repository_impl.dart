import 'package:todoapp_riverpod/data/db/db.dart';
import 'package:todoapp_riverpod/data/model/task.dart';
import 'package:todoapp_riverpod/data/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final DbHelper _dbHelper;
  TaskRepositoryImpl(this._dbHelper);

  @override
  Future<void> addTask(Task task) async {
    try {
      await _dbHelper.insertTask(task);
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    try {
      await _dbHelper.removeTask(id);
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<void> updateTask(int id, Task task) async {
    try {
      await _dbHelper.updateTask(id, task);
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<List<Task>> getAllTask() async {
    try {
      return await _dbHelper.getAllTask();
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<List<Task>> getTaskByPriority(int priority) async {
    try {
      return await _dbHelper.getTasksByPriority(priority);
    } catch (e) {
      throw "$e";
    }
  }
}
