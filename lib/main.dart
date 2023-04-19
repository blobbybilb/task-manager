// import 'dart:async';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:blobtask/archive.dart';
import 'package:blobtask/save.dart';
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

  DateTime? parseDateTime(String dateTimeString) {
    dateTimeString = dateTimeString.toLowerCase();

    // format 1: "1.Apr.2023 7:30 PM"
    RegExp exp1 = RegExp(r'^\d{1,2}\.\w{3}\.\d{4} \d{1,2}:\d{2} [ap]m$');
    if (exp1.hasMatch(dateTimeString)) {
      dateTimeString = dateTimeString.replaceAll('.', ' ');
      return DateTime.parse(dateTimeString);
    }

    // format 2: "today 7:30 pm", "yesterday 7:30 pm", "tomorrow 7:30 pm"
    RegExp exp2 = RegExp(r'^(today|yesterday|tomorrow) \d{1,2}:\d{2} [ap]m$');
    if (exp2.hasMatch(dateTimeString)) {
      String date = '';
      if (dateTimeString.contains('today')) {
        date = DateTime.now().toString().split(' ')[0];
      } else if (dateTimeString.contains('yesterday')) {
        date =
            DateTime.now().subtract(Duration(days: 1)).toString().split(' ')[0];
      } else if (dateTimeString.contains('tomorrow')) {
        date = DateTime.now().add(Duration(days: 1)).toString().split(' ')[0];
      }
      dateTimeString = date + ' ' + dateTimeString.split(' ')[1];
      return DateTime.parse(dateTimeString);
    }

    // format 3: "7:30 pm" (assume today)
    RegExp exp3 = RegExp(r'^\d{1,2}:\d{2} [ap]m$');
    if (exp3.hasMatch(dateTimeString)) {
      String date = DateTime.now().toString().split(' ')[0];
      dateTimeString = date + ' ' + dateTimeString;
      return DateTime.parse(dateTimeString);
    }

    return null;
  }

/*
  late Timer timer = Timer.periodic(const Duration(minutes: 1), (t) {
    prepareReminders();
    checkReminders(reminders);
    print(1);
  });
*/
  List<List<String>> reminders = [];
/*
  Future<void> checkReminders(List<List<dynamic>> reminders) async {
    FlutterLocalNotificationsPlugin notifications =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notifications.initialize(initializationSettings);

    for (List<dynamic> reminder in reminders) {
      String dateTimeString = reminder[1];
      DateTime? dateTime = parseDateTime(dateTimeString);
      if (dateTime != null &&
          dateTime.isBefore(DateTime.now().add(Duration(minutes: 1)))) {
        String title = 'Reminder';
        String body = reminder[0];
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'reminders',
          'Reminders',
          // 'Notification channel for reminders',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await notifications.show(0, title, body, platformChannelSpecifics);
      }
    }
  }
*/
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

    prepareReminders();
  }

  void prepareReminders() {
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
        .map((e) => e
            .trim()
            .split('@')
            .where((element) => element != '')
            .join('@')
            .trim())
        .where((e) => e != "")
        .join("\n⸻\n");
  }

  List<TextEditingController> getAllTextFields() => [
        tasksController,
        remindersController,
        laterController,
        scratchpadController,
        ideasController,
        longtermController
      ];

  List<String> getAllTextFieldsText() {
    return [
      tasksController,
      remindersController,
      laterController,
      scratchpadController,
      ideasController,
      longtermController
    ].map((e) => e.text).toList();
  }

  void archive() {
    // find which text field is active
    final List<TextEditingController> textFields = getAllTextFields();
    for (var textField in getAllTextFields()) {
      if (textField.selection.start != -1) {
        final int split = textField.text
            .substring(0, textField.selection.start)
            .split("⸻")
            .length;

        final String text = textField.text.split("⸻")[split - 1].trim();

        textField.text =
            textField.text.split("⸻").where((e) => e.trim() != text).join("⸻");

        addToArchive(
            text,
            textField == tasksController
                ? "tasks"
                : textField == remindersController
                    ? "reminders"
                    : textField == laterController
                        ? "later"
                        : textField == scratchpadController
                            ? "scratchpad"
                            : textField == ideasController
                                ? "ideas"
                                : textField == longtermController
                                    ? "longterm"
                                    : "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // timer =
    final List<String> loaded = load();
    final List<TextEditingController> controllers = [
      tasksController,
      remindersController,
      laterController,
      scratchpadController,
      ideasController,
      longtermController
    ];

    for (var i = 0; i < loaded.length; i++) {
      controllers[i].text = loaded[i];
    }

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.runtimeType == RawKeyUpEvent) {
          return;
        }

        if (event.logicalKey == LogicalKeyboardKey.keyS &&
            event.isMetaPressed &&
            !event.repeat) {
          prepare();
          final allTextFields = getAllTextFieldsText();
          save(
            allTextFields[0],
            allTextFields[1],
            allTextFields[2],
            allTextFields[3],
            allTextFields[4],
            allTextFields[5],
          );
        }

        if (event.logicalKey == LogicalKeyboardKey.keyD &&
            event.isMetaPressed &&
            !event.repeat) {
          archive();
          prepare();
          final allTextFields = getAllTextFieldsText();
          save(
            allTextFields[0],
            allTextFields[1],
            allTextFields[2],
            allTextFields[3],
            allTextFields[4],
            allTextFields[5],
          );
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
