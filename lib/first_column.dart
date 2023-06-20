import 'package:flutter/material.dart';

class FirstColumn extends StatelessWidget {
  final TextEditingController tasksController;

  const FirstColumn({
    Key? key,
    required this.tasksController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Tasks',
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
                  controller: tasksController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enter your tasks here...',
                  ),
                  maxLines: null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
