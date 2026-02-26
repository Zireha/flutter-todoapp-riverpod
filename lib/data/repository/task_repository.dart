import 'package:todoapp_riverpod/data/model/task.dart';

abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<void> updateTask(int id, Task task);
  Future<void> deleteTask(int id);
  Future<List<Task>> getAllTask();
  Future<List<Task>> getTaskByPriority(int id);
}
