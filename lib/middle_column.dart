import 'package:blobtask/archive.dart';
import 'package:flutter/material.dart';

class MiddleColumn extends StatelessWidget {
  final TextEditingController remindersController;
  final TextEditingController laterController;

  const MiddleColumn({
    Key? key,
    required this.remindersController,
    required this.laterController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Reminders',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: remindersController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Reminders go here...',
                  ),
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Later',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: laterController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Keep things for later here...',
                  ),
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text("Settings"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Archived Items'),
                                    content:
                                        SelectableText(getArchiveFormatted()),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("View Archive"),
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Help'),
                                    content: const Text(
                                        """To format and save: Cmd + S.\nTo archive (mark as done): Cmd + D."""),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Help"),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // IgnorePointer(
                  //   child: IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //         Icons.archive_outlined,
                  //         color: Colors.blue,
                  //       )),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
