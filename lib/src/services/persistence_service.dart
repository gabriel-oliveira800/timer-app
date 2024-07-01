import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_time_state.dart';
import '../models/tasks.dart';

class PersistenceService {
  const PersistenceService._();
  static const PersistenceService _instance = PersistenceService._();

  factory PersistenceService() => _instance;

  dynamic decodeTasks(String source) => json.decode(source);
  String encodeTasks(dynamic source) => json.encode(source);

  Future<List<Tasks>> getAllTasks() async {
    final pref = await SharedPreferences.getInstance();
    final result = pref.getStringList('tasks');

    if (result == null) return <Tasks>[];
    return result.map((it) => Tasks.fromMap(decodeTasks(it))).toList();
  }

  Future<void> saveTasks(Tasks tasks, [String key = 'tasks']) async {
    final pref = await SharedPreferences.getInstance();
    final currentTasks = await getAllTasks();

    await pref.setStringList(key, [
      ...currentTasks.map((it) => encodeTasks(it.toMap())),
      encodeTasks(tasks.toMap()),
    ]);
  }

  Future<TaskTimeState?> getTaskTimeState() async {
    final pref = await SharedPreferences.getInstance();
    final result = pref.getString('task_timer_state');

    if (result == null) return null;
    return TaskTimeState.fromMap(json.decode(result));
  }

  Future<void> saveTaskTimeState(TaskTimeState data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('task_timer_state', json.encode(data.toMap()));
  }

  Future<void> clearTaskTimeState() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('task_timer_state');
  }

  Future<void> deleteTask(Tasks task) async {
    final pref = await SharedPreferences.getInstance();
    final currentTasks = await getAllTasks();

    final newTasks = currentTasks.where((it) => it.id != task.id).toList();
    await pref.setStringList(
      'tasks',
      newTasks.map((it) => encodeTasks(it.toMap())).toList(),
    );
  }
}
