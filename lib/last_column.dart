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
                child: TextField(
                  controller: scratchpadController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Jot down your thoughts here...',
                  ),
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: LastColumnTabs(
                ideasController: ideasController,
                longtermController: longtermController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LastColumnTabs extends StatelessWidget {
  final TextEditingController ideasController;
  final TextEditingController longtermController;

  // constructor
  const LastColumnTabs({
    Key? key,
    required this.ideasController,
    required this.longtermController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'Ideas',
              ),
              Tab(
                text: 'Long-term',
              ),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight:
                  FontWeight.bold, // Sets the selected tab's text to bold
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey,
              fontWeight:
                  FontWeight.normal, // Sets the unselected tabs' text to normal
            ),
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
                  child: TextField(
                    controller: ideasController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Save your ideas here...',
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
                  child: TextField(
                    controller: longtermController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Your long-term goals go here...',
                    ),
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
