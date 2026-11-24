import 'package:flutter/material.dart';

void main() {
  runApp(const StudyPlannerApp());
}

class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Study Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StudyPlannerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() => _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {
  // Using var to avoid any copy-paste bracket issues
  var goals = [
    {'subject': 'Web Technology', 'hours': 4, 'done': false},
    {'subject': 'Internet of Things (IoT)', 'hours': 3, 'done': false},
    {'subject': 'Data Structures', 'hours': 5, 'done': true},
  ];

  void _toggleGoalStatus(int index) {
    setState(() {
      goals[index]['done'] = !(goals[index]['done'] as bool);
    });
  }

  void _deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  void _addSampleGoal() {
    setState(() {
      goals.add({
        'subject': 'Mobile App Development',
        'hours': 2,
        'done': false,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Study Planner'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Study Goals',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: goals.isEmpty
                  ? const Center(
                      child: Text('No goals added yet!'),
                    )
                  : ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        final goal = goals[index];
                        final bool isDone = goal['done'] as bool;
                        final String subjectName = goal['subject'] as String;
                        final int hours = goal['hours'] as int;

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Checkbox(
                              value: isDone,
                              onChanged: (bool? value) {
                                _toggleGoalStatus(index);
                              },
                            ),
                            title: Text(
                              subjectName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                decoration: isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: isDone ? Colors.grey : Colors.black,
                              ),
                            ),
                            subtitle: Text('Planned Hours: $hours hrs'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteGoal(index),
                            ),
                            onTap: () {
                              _toggleGoalStatus(index);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleGoal,
        tooltip: 'Add Sample Goal',
        child: const Icon(Icons.add),
      ),
    );
  }
}