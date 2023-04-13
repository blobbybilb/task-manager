import 'package:flutter/material.dart';

class LastColumn extends StatelessWidget {
  // takes parameter controller

  final TextEditingController scratchpadController;
  final TextEditingController ideasController;
  final TextEditingController longtermController;

  // constructor
  const LastColumn({
    Key? key,
    required this.scratchpadController,
    required this.ideasController,
    required this.longtermController,
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
              'Scratchpad',
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
                    hintText: 'Enter notes...',
                  ),
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(
                          text: 'Ideas',
                        ),
                        Tab(
                          text: 'Long term',
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: const TextField(
                              decoration: InputDecoration.collapsed(
                                hintText: 'Enter your ideas...',
                              ),
                              maxLines: null,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: const TextField(
                              decoration: InputDecoration.collapsed(
                                hintText: 'Enter your long term tasks...',
                              ),
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
