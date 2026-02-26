import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp_riverpod/data/db/db_provider.dart';
import 'package:todoapp_riverpod/data/repository/task_repository.dart';
import 'package:todoapp_riverpod/data/repository/task_repository_impl.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dataHelper = ref.read(dbProvider);
  return TaskRepositoryImpl(dataHelper);
});
