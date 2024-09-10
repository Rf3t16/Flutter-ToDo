import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import 'package:provider/provider.dart';
import '../widgets/task_item_widget.dart';
import 'add_task_bottom_sheet.dart';
import 'package:intl/intl.dart';
import '../utils/app_style.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBarStyle('To-Do App'),
      backgroundColor: AppStyle.backgroundColor,
      body: Consumer<TaskController>(
        builder: (context, taskController, child) {
          if (taskController.tasks.isEmpty) {
            return const Center(
                child: Text(
              'No tasks added',
              style: AppStyle.bodyTextStyle,
            ));
          }
          return ListView(
            children: taskController.tasks.map((task) {
              int completedItems =
                  task.items.where((item) => item.isCompleted).length;

              String formattedTime = DateFormat.jm().format(task.time);

              return Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 8, right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: ExpansionPanelList(
                    elevation: 2,
                    expansionCallback: (int index, bool isExpanded) {
                      context.read<TaskController>().toggleTaskExpansion(task);
                    },
                    // children: [
                    //   ExpansionPanel(
                    //     backgroundColor: const Color(0xFFD2D7D3),
                    //     headerBuilder: (BuildContext context, bool isExpanded) {
                    //       return ListTile(
                    //         title: Text(
                    //           formattedTime,
                    //           style: AppStyle.titleTextStyle,
                    //         ),
                    //         subtitle: Text(
                    //           '$completedItems/${task.items.length} Task Completed',
                    //           style: AppStyle.bodyTextStyle,
                    //         ),
                    //       );
                    //     },
                    //     body: Column(
                    //       children: task.items
                    //           .map((item) => Column(
                    //                 children: [
                    //                   TaskItemWidget(
                    //                       task: task, taskItem: item),
                    //                   Container(
                    //                     height: 1,
                    //                     color: AppStyle.primaryColor,
                    //                   )
                    //                 ],
                    //               ))
                    //           .toList(),
                    //     ),
                    //     isExpanded: task.isExpanded,
                    //   )
                    // ],
                    children: [
                      ExpansionPanel(
                        backgroundColor: const Color(0xFFD2D7D3),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              formattedTime,
                              style: AppStyle.titleTextStyle,
                            ),
                            subtitle: Text(
                              '$completedItems/${task.items.length} Task Completed',
                              style: AppStyle.bodyTextStyle,
                            ),
                          );
                        },
                        body: Column(
                          children: task.items
                              .map((item) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6.0,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: TaskItemWidget(
                                        task: task,
                                        taskItem: item,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        isExpanded: task.isExpanded,
                      )
                    ],
                  ),
                ),
              );
              // );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => const AddTaskBottomSheet(),
        ),
        backgroundColor: AppStyle.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
