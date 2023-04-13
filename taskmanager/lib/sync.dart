import 'package:flutter/material.dart';

class SyncEngine {
  final TextEditingController tasksController;
  final TextEditingController remindersController;
  final TextEditingController laterController;
  final TextEditingController scratchpadController;
  final TextEditingController ideasController;
  final TextEditingController longtermController;

  static final SyncEngine _singleton = SyncEngine._internal(
    tasksController: TextEditingController(),
    remindersController: TextEditingController(),
    laterController: TextEditingController(),
    scratchpadController: TextEditingController(),
    ideasController: TextEditingController(),
    longtermController: TextEditingController(),
  );

  factory SyncEngine() => _singleton;

  SyncEngine._internal({
    required this.tasksController,
    required this.remindersController,
    required this.laterController,
    required this.scratchpadController,
    required this.ideasController,
    required this.longtermController,
  });

  static SyncEngine get() {
    return _singleton;
  }

  String? runSync() {
    prepare();
    return null;
  }

  String? prepare() {
    return null;
  }

  String? prepareTasksField() {
    tasksController.addListener(() {
      print(tasksController.text);
    });

    print(tasksController.text);
    final tasksText = tasksController.text;
    final tasksList =
        tasksText.split("\n\n\n").map((task) => task.trim()).toList();
    final preparedTasksText = tasksList.join("\n⸻\n");
    tasksController.text = preparedTasksText;
    print(preparedTasksText);
    print(tasksController.text);
    return null;
  }
}
