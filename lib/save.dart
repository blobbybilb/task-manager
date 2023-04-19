// always tasks, reminders, later, scratchpad, ideas, longterm
import 'dart:io';

final String dataDir = "${Platform.environment['HOME']}/.config/blobtask/";

String? save(
  String tasks,
  String reminders,
  String later,
  String scratchpad,
  String ideas,
  String longterm,
) {
  try {
    final File tasksFile = File("${dataDir}tasks.txt");
    final File remindersFile = File("${dataDir}reminders.txt");
    final File laterFile = File("${dataDir}later.txt");
    final File scratchpadFile = File("${dataDir}scratchpad.txt");
    final File ideasFile = File("${dataDir}ideas.txt");
    final File longtermFile = File("${dataDir}longterm.txt");

    tasksFile.writeAsStringSync(tasks);
    remindersFile.writeAsStringSync(reminders);
    laterFile.writeAsStringSync(later);
    scratchpadFile.writeAsStringSync(scratchpad);
    ideasFile.writeAsStringSync(ideas);
    longtermFile.writeAsStringSync(longterm);
  } catch (e) {
    return e.toString();
  }
  return null;
}

List<String> load() {
  final List<File> files = [
    File("${dataDir}tasks.txt"),
    File("${dataDir}reminders.txt"),
    File("${dataDir}later.txt"),
    File("${dataDir}scratchpad.txt"),
    File("${dataDir}ideas.txt"),
    File("${dataDir}longterm.txt"),
  ];

  for (final file in files) {
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync("");
    }
  }

  return files.map((e) => e.readAsStringSync()).toList();
}
