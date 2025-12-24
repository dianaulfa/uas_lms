import 'package:flutter/material.dart';
import 'theme.dart';

class CourseDetailScreen extends StatelessWidget {
  final String title;
  const CourseDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> meetings = List.generate(8, (i) => {
      'title': 'Pertemuan ${i + 1}',
      'content': [
        {'title': 'Pengantar topik ${i + 1}', 'done': i % 3 == 0},
        {'title': 'Latihan dan referensi', 'done': i % 2 == 0},
      ]
    });

    final List<Map<String, dynamic>> tasks = [
      {'title': 'Tugas 1', 'deadline': '25 Des 2025', 'done': true},
      {'title': 'Kuis 1', 'deadline': '28 Des 2025', 'done': false},
      {'title': 'Tugas 2', 'deadline': '02 Jan 2026', 'done': false},
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: kPrimaryColor,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Materi'),
              Tab(text: 'Tugas Dan Kuis'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Materi
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: meetings.length,
              itemBuilder: (context, idx) {
                final m = meetings[idx];
                return ExpansionTile(
                  title: Text(m['title']),
                  children: (m['content'] as List<Map<String, dynamic>>).map((s) => ListTile(
                    leading: const Icon(Icons.article),
                    title: Text(s['title']),
                    trailing: s['done'] == true ? Icon(Icons.check_circle, color: kAccentColor) : null,
                  )).toList(),
                );
              },
            ),

            // Tugas dan Kuis
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                final t = tasks[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.assignment, color: kPrimaryColor),
                    title: Text(t['title']),
                    subtitle: Text('Tenggat: ${t['deadline']}'),
                    trailing: t['done'] == true ? Icon(Icons.check_circle, color: kAccentColor) : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
