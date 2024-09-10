import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_d15_flutter/utils/app_style.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController _timeController = TextEditingController();
  final List<TextEditingController> _taskControllers = [];
  DateTime? selectedTime;

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: AppStyle.primaryColor,
            timePickerTheme: const TimePickerThemeData(
              dialHandColor: AppStyle.primaryColor,
              hourMinuteTextColor: AppStyle.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = DateTime(2024, 1, 1, picked.hour, picked.minute);
        _timeController.text = picked.format(context);
      });
    }
  }

  void _addTaskItem() {
    setState(() {
      _taskControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _timeController,
                onTap: _pickTime,
                readOnly: true,
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.access_time,
                    color: AppStyle.primaryColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: AppStyle.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ..._taskControllers.map((controller) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Task Item',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: AppStyle.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: _addTaskItem,
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppStyle.primaryColor,
                  iconSize: 28.0,
                  tooltip: 'Add Task Item',
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedTime != null && _taskControllers.isNotEmpty) {
                      List<TaskItem> items = _taskControllers
                          .map((controller) =>
                              TaskItem(description: controller.text))
                          .toList();
                      context
                          .read<TaskController>()
                          .addTask(selectedTime!, items);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: AppStyle.primaryColor,
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
