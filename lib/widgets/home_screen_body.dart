import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp_riverpod/config/theme/theme.dart';
import 'package:todoapp_riverpod/providers/task/task_provider.dart';
import 'package:todoapp_riverpod/widgets/error_notification.dart';
import 'package:todoapp_riverpod/widgets/task_tile.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return tasks.when(
      loading: () =>
          Center(child: CircularProgressIndicator(color: MyColors.foreground)),
      error: (error, _) => ErrorNotification(error: error.toString()),
      data: (taskList) {
        if (taskList.isEmpty) {
          return Column(
            children: [
              Text("santai dulu ga sih"),
            ],
          );
        }
        return Column(
          children: [
            ListView.separated(
              separatorBuilder: (_, _) => SizedBox(height: 12),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: taskList.length,
              itemBuilder: (ctx, index) {
                final task = taskList[index];

                return TaskTile(task: task);
              },
            ),
          ],
        );
      },
    );
  }
}
