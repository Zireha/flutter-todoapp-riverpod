import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp_riverpod/config/fonts/my_fonts.dart';
import 'package:todoapp_riverpod/enums/priorities.dart';
import 'package:todoapp_riverpod/providers/task/task_provider.dart';
import 'package:todoapp_riverpod/utils/utils.dart';

class PriorityPicker extends ConsumerWidget {
  const PriorityPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(taskFilterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 12,
        children: [
          ...Priorities.values.map((item) {
            final isSelected = selected == item;

            return GestureDetector(
              onTap: () {
                ref.read(taskFilterProvider.notifier).state = item;
              },

              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: isSelected ? 1.0 : 0.4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Utils.labelColor(priorityName: item.name),
                  ),
                  child: Text(
                    "${item.name[0].toUpperCase()}${item.name.substring(1)}",
                    style: MyFonts.secondaryDisplaySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
