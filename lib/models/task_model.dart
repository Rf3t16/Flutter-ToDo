class TaskItem {
  String description;
  bool isCompleted;

  TaskItem({required this.description, this.isCompleted = false});
}

class Task {
  DateTime time;
  List<TaskItem> items;
  bool isExpanded;

  Task({required this.time, required this.items, this.isExpanded = false});
}
