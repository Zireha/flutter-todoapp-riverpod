import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todoapp_riverpod/data/model/task.dart';
import 'package:todoapp_riverpod/data/repository/task_repository_provider.dart';
import 'package:todoapp_riverpod/enums/priorities.dart';

final taskFilterProvider = StateProvider<Priorities>((ref) => Priorities.semua);

final taskProvider = FutureProvider<List<Task>>((ref) async {
  final repo = ref.read(taskRepositoryProvider);
  final filter = ref.watch(taskFilterProvider);

  switch (filter) {
    case Priorities.semua:
      return await repo.getAllTask();
    case Priorities.tinggi:
      return await repo.getTaskByPriority(3);
    case Priorities.sedang:
      return await repo.getTaskByPriority(2);
    case Priorities.rendah:
      return await repo.getTaskByPriority(1);
  }
});
