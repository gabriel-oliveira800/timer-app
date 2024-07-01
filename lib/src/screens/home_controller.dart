import 'package:flutter/material.dart';

import '../models/task_time_state.dart';
import '../services/persistence_service.dart';
import '../models/tasks.dart';

typedef OnNavigateToTaskTimeState = void Function(TaskTimeState data);

class HomeController with ChangeNotifier {
  final service = PersistenceService();

  Tasks? selectedTask;
  final tasks = <Tasks>[];
  bool isLoading = false;
  Duration selectedDuration = const Duration(minutes: 5);

  bool isEnableStartButton() => tasks.isNotEmpty && selectedTask != null;

  void onInit(OnNavigateToTaskTimeState onListen) async {
    toggleLoading();

    final currentSate = await service.getTaskTimeState();
    if (currentSate != null) {
      toggleLoading();
      return onListen(currentSate);
    }

    final result = await service.getAllTasks();
    if (result.isEmpty) return toggleLoading();

    tasks.addAll(result);
    selectedTask = tasks.first;

    notifyListeners();
    toggleLoading();
  }

  void onSelectedDuration(Duration duration) {
    selectedDuration = duration;
    notifyListeners();
  }

  void onAddNewTask(String name) async {
    final newTasks = Tasks(name);

    tasks.add(newTasks);
    notifyListeners();
    await service.saveTasks(newTasks);
  }

  void onSelectedTask(Tasks task) async {
    selectedTask = task;
    notifyListeners();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<TaskTimeState> onTaskTimeState() async {
    toggleLoading();

    final data = TaskTimeState(duration: selectedDuration, task: selectedTask!);
    await service.saveTaskTimeState(data);

    toggleLoading();
    return data;
  }

  void onDeletedTask(Tasks task) async {
    tasks.remove(task);
    notifyListeners();
    await service.deleteTask(task);
  }
}
