// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';
import 'package:provider/provider.dart';

import '../utils/app_style.dart';

class EditTaskDialog extends StatefulWidget {
  final TaskItem taskItem;

  const EditTaskDialog({super.key, required this.taskItem});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.taskItem.description);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Task Item'),
      content: TextField(controller: _controller),
      actions: [
        ElevatedButton(
            onPressed: () {
              context
                  .read<TaskController>()
                  .updateTaskItem(widget.taskItem, _controller.text);
              Navigator.pop(context);
            },
            // style:const ButtonStyle(iconColor: AppStyle.primaryColor),
            child: const Text(
              'Save',
              style: TextStyle(color: AppStyle.primaryColor),
            )),
      ],
    );
  }
}
