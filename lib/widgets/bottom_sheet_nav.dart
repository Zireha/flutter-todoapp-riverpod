import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp_riverpod/config/theme/theme.dart';
import 'package:todoapp_riverpod/data/model/task.dart';
import 'package:todoapp_riverpod/data/repository/repository.dart';
import 'package:todoapp_riverpod/enums/priorities.dart';
import 'package:todoapp_riverpod/providers/task/task_provider.dart';
import 'package:todoapp_riverpod/widgets/form_sheet.dart';

class BottomSheetNav extends ConsumerStatefulWidget {
  final bool isEditing;
  final Task? task;
  const BottomSheetNav({super.key, required this.isEditing, this.task});

  @override
  ConsumerState<BottomSheetNav> createState() => _BottomSheetNavState();
}

class _BottomSheetNavState extends ConsumerState<BottomSheetNav> {
  final textTitleController = TextEditingController();
  final textDetailController = TextEditingController();
  final textDateController = TextEditingController();
  final textTimeController = TextEditingController();
  Priorities? selectedPriority;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.task != null) {
      final task = widget.task!;
      textTitleController.text = task.taskTitle;
      textDetailController.text = task.taskDescription;
      textDateController.text = task.date;
      textTimeController.text = task.time;
    }
  }

  @override
  void dispose() {
    textTitleController.dispose();
    textDetailController.dispose();
    textDateController.dispose();
    textTimeController.dispose();
    super.dispose();
  }

  int getPriority(String priority) {
    if (priority == "rendah") {
      return 1;
    } else if (priority == "sedang") {
      return 2;
    } else if (priority == "tinggi") {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final taskRepo = ref.watch(taskRepositoryProvider);

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.background,
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: FormSheet(
          textTitleController: textTitleController,
          textDetailController: textDetailController,
          textDateController: textDateController,
          textTimeController: textTimeController,
          title: widget.isEditing ? "Edit Tugas" : "Buat Tugas",
          buttonText: widget.isEditing ? "Simpan Perubahan" : "Tambahkan Tugas",
          onPriorityChanged: (priority) {
            setState(() {
              selectedPriority = priority;
            });
          },
          selectedPriority: selectedPriority,
          onTap: () async {
            if (widget.isEditing) {
              final taskToUpdate = widget.task!.copyWith(
                taskTitle: textTitleController.text,
                taskDescription: textDetailController.text,
                date: textDateController.text,
                time: textTimeController.text,
              );
              await taskRepo.updateTask(widget.task!.id!, taskToUpdate);
            } else {
              taskRepo.addTask(
                Task(
                  taskTitle: textTitleController.text,
                  taskDescription: textDetailController.text,
                  time: textTimeController.text,
                  date: textDateController.text,
                  taskPriority: selectedPriority!.index,
                  isCompleted: 0,
                ),
              );
            }
            ref.invalidate(taskProvider);
            if (mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
