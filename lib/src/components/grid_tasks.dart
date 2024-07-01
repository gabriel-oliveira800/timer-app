import 'package:flutter/material.dart';

import 'create_tasks_modal_content.dart';

import '../models/tasks.dart';
import 'rounded_button.dart';
import 'spacing.dart';

class GridTasks extends StatelessWidget {
  final List<Tasks> tasks;
  final Tasks? selectedTask;

  final ValueChanged<Tasks> onDelete;
  final ValueChanged<String> onCreatedTask;
  final ValueChanged<Tasks> onSelectedTask;

  const GridTasks({
    super.key,
    this.selectedTask,
    required this.onDelete,
    required this.onCreatedTask,
    required this.onSelectedTask,
    this.tasks = const <Tasks>[],
  });

  void _onCreatedTask(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (_) => CreateTasksModalContent(
        onCreatedTask: onCreatedTask,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Align(
        alignment: Alignment.center,
        child: RoundedButton(onPressed: () => _onCreatedTask(context)),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedButton(onPressed: () => _onCreatedTask(context)),
        const Spacing.horizontal(8),
        Flexible(
          child: Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(maxHeight: 112),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => RoundedButton(
                text: tasks[index].title,
                selected: tasks[index] == selectedTask,
                onLongPress: () => onDelete(tasks[index]),
                onPressed: () => onSelectedTask(tasks[index]),
              ),
              separatorBuilder: (_, index) => const Spacing.horizontal(8),
            ),
          ),
        ),
      ],
    );
  }
}
