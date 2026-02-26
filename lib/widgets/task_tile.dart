import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp_riverpod/config/fonts/my_fonts.dart';
import 'package:todoapp_riverpod/data/data.dart';
import 'package:todoapp_riverpod/providers/task/task_provider.dart';
import 'package:todoapp_riverpod/utils/utils.dart';
import 'package:todoapp_riverpod/widgets/bottom_sheet_nav.dart';
import 'package:todoapp_riverpod/widgets/my_checkbox.dart';

class TaskTile extends ConsumerWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = task.isCompleted == 1;
    final taskRepo = ref.read(taskRepositoryProvider);
    final taskId = task.id;

    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Hapus',
            borderRadius: BorderRadius.circular(12),
            onPressed: (context) async {
              if (taskId != null) {
                await taskRepo.deleteTask(taskId);
              }
              ref.invalidate(taskProvider);
            },
          ),
          SlidableAction(
            backgroundColor: Colors.blue.shade400,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(12),
            onPressed: (context) async {
              if (taskId != null) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => BottomSheetNav(isEditing: true, task: task),
                );
              }
              ref.invalidate(taskProvider);
            },
          ),
        ],
      ),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // label
            Container(
              width: 15,
              decoration: BoxDecoration(
                color: isChecked
                    ? Utils.labelColor(
                        priority: task.taskPriority,
                      ).withAlpha(175)
                    : Utils.labelColor(priority: task.taskPriority),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            // teks
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task.taskTitle,
                      style: MyFonts.secondaryDisplayMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isChecked == true
                            ? Colors.black38
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.taskDescription,
                      style: MyFonts.secondaryDisplaySmall.copyWith(
                        color: isChecked == true
                            ? Colors.black38
                            : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          task.date,
                          style: MyFonts.secondaryTitleMedium.copyWith(
                            color: isChecked == true
                                ? Colors.black38
                                : Colors.black,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          task.time,
                          style: MyFonts.secondaryTitleMedium.copyWith(
                            color: isChecked == true
                                ? Colors.black38
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // checkbox
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: MyCheckbox(
                isChecked: isChecked,
                onChanged: (val) async {
                  final taskRepo = ref.read(taskRepositoryProvider);
                  final taskId = task.id;

                  if (taskId != null) {
                    final updated = task.copyWith(
                      isCompleted: isChecked ? 0 : 1,
                    );
                    await taskRepo.updateTask(taskId, updated);
                    ref.invalidate(taskProvider);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
