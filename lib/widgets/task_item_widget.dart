import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';
import 'package:provider/provider.dart';
import '../utils/app_style.dart';
import 'edit_task_dialog.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final TaskItem taskItem;

  const TaskItemWidget({super.key, required this.task, required this.taskItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskItem.description,
        style: taskItem.isCompleted
            ? AppStyle.itemTextStyle
                .copyWith(decoration: TextDecoration.lineThrough)
            : AppStyle.itemTextStyle,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: taskItem.isCompleted,
            activeColor: AppStyle.primaryColor,
            onChanged: (bool? value) {
              context.read<TaskController>().toggleTaskCompletion(taskItem);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: AppStyle.primaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditTaskDialog(taskItem: taskItem),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: AppStyle.primaryColor,
            ),
            onPressed: () {
              context.read<TaskController>().deleteTaskItem(task, taskItem);
            },
          ),
        ],
      ),
    );
  }
}
