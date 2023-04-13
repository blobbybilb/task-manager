import 'package:flutter/material.dart';

import 'first_column.dart';
import 'middle_column.dart';
import 'last_column.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<TaskManager> {
  final TextEditingController tasksController = TextEditingController();
  final TextEditingController remindersController = TextEditingController();
  final TextEditingController laterController = TextEditingController();
  final TextEditingController scratchpadController = TextEditingController();
  final TextEditingController ideasController = TextEditingController();
  final TextEditingController longtermController = TextEditingController();

  @override
  void dispose() {
    tasksController.dispose();
    remindersController.dispose();
    laterController.dispose();
    scratchpadController.dispose();
    ideasController.dispose();
    longtermController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          FirstColumn(
            tasksController: tasksController,
          ),
          MiddleColumn(
            remindersController: remindersController,
            laterController: laterController,
          ),
          LastColumn(
            scratchpadController: scratchpadController,
            ideasController: ideasController,
            longtermController: longtermController,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: TaskManager(),
    ),
  );
}
