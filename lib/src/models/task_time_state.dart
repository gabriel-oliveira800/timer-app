import 'tasks.dart';

class TaskTimeState {
  final Tasks task;
  final Duration duration;

  const TaskTimeState({
    required this.task,
    required this.duration,
  });

  factory TaskTimeState.fromMap(Map<String, dynamic> map) {
    return TaskTimeState(
      task: Tasks.fromMap(map['task']),
      duration: Duration(milliseconds: map['duration']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'task': task.toMap(), 'duration': duration.inMilliseconds};
  }

  @override
  String toString() => 'TaskTimeState(task: $task, duration: $duration)';
}
