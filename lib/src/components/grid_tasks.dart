import 'package:flutter/material.dart';

import '../models/tasks.dart';
import 'create_tasks_button.dart';
import 'create_tasks_modal_content.dart';
import 'spacing.dart';

class GridTasks extends StatelessWidget {
  final List<Tasks> tasks;
  final Tasks? selectedTask;
  final ValueChanged<String> onCreatedTask;
  final ValueChanged<Tasks> onSelectedTask;

  const GridTasks({
    super.key,
    this.selectedTask,
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
        child: CreateTasksButton(onPressed: () => _onCreatedTask(context)),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CreateTasksButton(onPressed: () => _onCreatedTask(context)),
        const Spacing.horizontal(8),
        Flexible(
          child: Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(maxHeight: 112),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, index) => const Spacing.horizontal(8),
              itemBuilder: (_, index) => CreateTasksButton(
                data: tasks[index].title,
                selected: tasks[index] == selectedTask,
                onPressed: () => onSelectedTask(tasks[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
