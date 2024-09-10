import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/task_controller.dart';
// import 'utils/app_style.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskController(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do App',
        home: HomeView(),
      ),
    );
  }
}
