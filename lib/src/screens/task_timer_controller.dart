import 'dart:async';

import 'package:flutter/material.dart';

import '../models/task_time_state.dart';
import '../services/persistence_service.dart';

class TaskTimerController extends ChangeNotifier {
  final service = PersistenceService();

  Timer? _timer;

  TaskTimeState? taskTimeState;
  Duration progress = Duration.zero;

  bool finished = false;
  bool isLoading = false;

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  String getTask() => taskTimeState?.task.title ?? '';
  Duration? getDuration() => taskTimeState?.duration;

  void onInit(TaskTimeState? value) {
    taskTimeState = value;
    progress = taskTimeState?.duration ?? Duration.zero;
    notifyListeners();

    if (taskTimeState != null) _handlerTimer();
  }

  double getProgress() {
    final total = taskTimeState?.duration.inSeconds ?? 0;
    final current = progress.inSeconds / total;

    return current.isNaN || current.isInfinite ? 0 : current;
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _handlerTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      progress = (progress - const Duration(seconds: 1));
      if (progress < Duration.zero) {
        finished = true;
        notifyListeners();
        progress = Duration.zero;
        return _cancelTimer();
      }

      notifyListeners();
    });
  }

  Duration? lastProgressAfterPause;

  void onPause() {
    if (lastProgressAfterPause == null) {
      lastProgressAfterPause = progress;
      notifyListeners();
      return _cancelTimer();
    }

    progress = lastProgressAfterPause!;
    lastProgressAfterPause = null;

    notifyListeners();
    _handlerTimer();
  }

  Future<void> onStop() async {
    _cancelTimer();

    lastProgressAfterPause = null;
    progress = Duration.zero;
    notifyListeners();

    toggleLoading();
    await service.clearTaskTimeState();
    toggleLoading();
  }
}
