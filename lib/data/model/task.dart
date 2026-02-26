import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String taskTitle;
  final String taskDescription;
  final String time;
  final String date;
  final int taskPriority;
  final int isCompleted;

  const Task({
    this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.time,
    required this.date,
    required this.taskPriority,
    required this.isCompleted
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "taskTitle": taskTitle,
      "taskDescription": taskDescription,
      "time": time,
      "date": date,
      "taskPriority": taskPriority,
      "isCompleted": isCompleted
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      taskTitle: map["taskTitle"],
      taskDescription: map["taskDescription"],
      time: map["time"],
      date: map["date"],
      // 1=low, 2=medium, 3=high
      taskPriority: map["taskPriority"],
      // 1 = complete, 0=incomplete
      isCompleted: map["isCompleted"]
    );
  }

  @override
  List<Object?> get props {
    return [taskTitle, taskDescription, time, date, taskPriority];
  }

  Task copyWith({
    int? id,
    String? taskTitle,
    String? taskDescription,
    String? time,
    String? date,
    int? taskPriority,
    int? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      time: time ?? this.time,
      date: date ?? this.date,
      taskPriority: taskPriority ?? this.taskPriority,
      isCompleted: isCompleted ?? this.isCompleted
    );
  }
}
