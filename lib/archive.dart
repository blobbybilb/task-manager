import 'dart:io';

final String dataDir = "${Platform.environment['HOME']}/.config/blobtask/";

void addToArchive(String text, String field) {
  text = text.trim();

  final file = File('${dataDir}archive.txt');
  final data = '\n⸻\n$field\n--\n$text';

  file.writeAsStringSync(data, mode: FileMode.append);
}

String getArchive() {
  final file = File('$dataDir/archive.txt');

  if (!file.existsSync()) {
    return '';
  }

  return file.readAsStringSync();
}

bool isInArchive(String text, String field) {
  final archive = getArchive();
  final pattern = RegExp('\n⸻\n$field\n--\n$text\n');

  return pattern.hasMatch(archive);
}

void removeFromArchive(String text, String field) {
  final archive = getArchive();
  final pattern = RegExp('\n⸻\n$field\n--\n$text\n');

  final modifiedArchive = archive.replaceAll(pattern, '');
  final file = File('$dataDir/archive.txt');

  file.writeAsStringSync(modifiedArchive);
}

String getArchiveFormatted() {
  final archive = getArchive();
  final archiveList = archive.split('\n⸻\n');
  archiveList.removeWhere((element) => element.isEmpty);

  final archiveMap = <String, List<String>>{};
  for (final item in archiveList) {
    final fieldEndIndex = item.indexOf('\n');
    final field = item.substring(0, fieldEndIndex);
    final text = item.substring(fieldEndIndex + 3).trim();

    if (!archiveMap.containsKey(field)) {
      archiveMap[field] = [];
    }
    archiveMap[field]!.add(text);
  }

  final buffer = StringBuffer();
  for (final entry in archiveMap.entries) {
    buffer.writeln(entry.key.toUpperCase());
    buffer.writeln('⸻');

    for (final item in entry.value) {
      buffer.writeln(item);
      buffer.writeln('⸻');
    }

    buffer.writeln('\n\n');
  }

  return buffer.toString();
}
