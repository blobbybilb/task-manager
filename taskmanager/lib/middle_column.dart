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
                child: const TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your reminder here...',
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
                child: const TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter tasks for later...',
                  ),
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Placeholder(
                  //   fallbackWidth: 100,
                  // ),
                  // Placeholder(
                  //   fallbackWidth: 100,
                  // ),
                  // Placeholder(
                  //   fallbackWidth: 100,
                  // ),

                  // 3 buttons that print hello world when clicked
                  TextButton(
                    onPressed: () {},
                    child: const Text('Hello World'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Hello World'),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
