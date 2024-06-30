import 'package:uuid/uuid.dart';

class Tasks {
  final String id;
  final String title;

  const Tasks._(this.id, this.title);

  factory Tasks(String value) => Tasks._(const Uuid().v4(), value);

  factory Tasks.fromMap(Map<String, dynamic> map) =>
      Tasks._(map['id']!, map['title']!);

  Map<String, String> toMap() => {'id': id, 'title': title};

  @override
  String toString() => 'Tasks(id: $id, title: $title)';
}
