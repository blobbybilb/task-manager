import 'package:blobtask/archive.dart';

import 'save.dart';

List<String> sync() {
  final localData = load();
  localData.add(getArchive());
  final remoteData = [
    '<tasks>',
    '<reminders>',
    '<later>',
    '<scratchpad>',
    '<ideas>',
    '<longterm>',
    '<archive>'
  ];
  const fields = [
    'tasks',
    'reminders',
    'later',
    'scratchpad',
    'ideas',
    'longterm'
  ];

  // Step 2: Join each string with its counterpart
  List<String> finalData =
      List.generate(localData.length, (i) => '${fields[i]}\n${remoteData[i]}');

  // Step 3: Deduplicate items in each string
  for (int i = 0; i < finalData.length; i++) {
    List<String> items = finalData[i].split('⸻');
    Set<String> uniqueItems = Set<String>.from(items);
    finalData[i] = uniqueItems.join('⸻');
  }

  // Step 4: Remove items in field strings that are also in the archive
  String archive = finalData.last;
  for (int i = 0; i < 6; i++) {
    List<String> items = finalData[i].split('⸻');
    items.removeWhere((item) => archive.contains('\${fields[i]}\n--\n$item'));
    finalData[i] = items.join('⸻');
  }

  // Step 5: Return finalData
  return finalData;
}
