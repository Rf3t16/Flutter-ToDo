import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(DateTime time, List<TaskItem> items) {
    Task? existingTask = tasks.firstWhere((task) => task.time == time, orElse: () => Task(time: time, items: []));
    if (existingTask.items.isEmpty) {
      tasks.add(Task(time: time, items: items));
    } else {
      existingTask.items.addAll(items);
    }
    notifyListeners();
  }

  void deleteTaskItem(Task task, TaskItem item) {
    task.items.remove(item);
    if (task.items.isEmpty) {
      tasks.remove(task);
    }
    notifyListeners();
  }

  void updateTaskItem(TaskItem item, String newDescription) {
    item.description = newDescription;
    notifyListeners();
  }

  void toggleTaskCompletion(TaskItem item) {
    item.isCompleted = !item.isCompleted;
    notifyListeners();
  }

  void toggleTaskExpansion(Task task) {
    task.isExpanded = !task.isExpanded;
    notifyListeners();
  }
}