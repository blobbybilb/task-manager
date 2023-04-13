import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'first_column.dart';
import 'middle_column.dart';
import 'last_column.dart';

import 'sync.dart';

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
  final SyncEngine syncEngine = SyncEngine();

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

  void prepareTasksField() {
    final tasksText = tasksController.text.trim();
    final regex = RegExp(r'\n{2,}'); // Matches 2 or more newlines
    final tasksList =
        tasksText.split(regex).map((task) => task.trim()).toList();
    final preparedTasksText = tasksList.join("\n⸻\n");
    tasksController.text = preparedTasksText;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.logicalKey == LogicalKeyboardKey.keyS &&
            event.isMetaPressed) {
          prepareTasksField();
          // Add your action here
        }
      },
      child: Scaffold(
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
