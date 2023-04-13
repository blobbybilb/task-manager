import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  var reminders = [];

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

  void prepare() {
    // initial separation
    for (final textController in [
      tasksController,
      remindersController,
      laterController,
      ideasController,
      longtermController
    ]) {
      final tasksList = textController.text
          .trim()
          .split({remindersController}.contains(textController)
              ? RegExp(r'\n{1,}')
              : RegExp(r'\n{2,}'))
          .map((task) => task.trim())
          .toList();
      var preparedTasksText = tasksList.join("\n⸻\n");

      while (preparedTasksText.contains("⸻\n⸻")) {
        preparedTasksText = preparedTasksText.replaceAll("⸻\n⸻", "⸻");
      }

      textController.text = preparedTasksText;
    }

    reminders = [];
    remindersController.text = remindersController.text
        .split("\n⸻\n")
        .map((e) => e.split("@")[0].trim() != ""
            ? "${e.split("@")[0].trim()}${((e.split("@").length >= 2) && ((e[1] != "") || (e[1] != " "))) ? " @ ${() {
                e.split("@")[1].trim() != ""
                    ? reminders
                        .add([e.split("@")[0].trim(), e.split("@")[1].trim()])
                    : null;
                return e.split("@")[1].trim();
              }()}" : ""}"
            : "")
        .where((e) => e != "")
        .join("\n⸻\n");

    print(reminders);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.logicalKey == LogicalKeyboardKey.keyS &&
            event.isMetaPressed) {
          prepare();
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
