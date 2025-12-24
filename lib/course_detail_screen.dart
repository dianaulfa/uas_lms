import 'package:flutter/material.dart';
import 'theme.dart';
import 'task_detail_screen.dart';
import 'quiz_info_screen.dart';
import 'video_player_screen.dart';
import 'document_viewer_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final String title;
  const CourseDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // map course title to sample video links (you can customize links)
    final Map<String, List<String>> videoLinks = {
      'UI/UX': [
        'https://www.youtube.com/watch?v=Ke90Tje7VS0',
        'https://www.youtube.com/watch?v=3JluqTojuME'
      ],
      'Sistem Operasi': ['https://www.youtube.com/watch?v=3Qh5Xg2v7HM'],
      'Kewarganegaraan': ['https://www.youtube.com/watch?v=dQw4w9WgXcQ'],
      'Multimedia': ['https://www.youtube.com/watch?v=ysz5S6PUM-U'],
      'Bahasa Inggris': ['https://www.youtube.com/watch?v=V-_O7nl0Ii0'],
      'Olah Raga': ['https://www.youtube.com/watch?v=2Vv-BfVoq4g'],
    };

    final List<Map<String, dynamic>> meetings = List.generate(8, (i) => {
      'title': 'Pertemuan ${i + 1}',
      'content': [
        // main material
        {'title': 'Pengantar topik ${i + 1}', 'done': i % 3 == 0, 'type': i % 2 == 0 ? 'video' : 'doc'},
        // latihan
        {'title': 'Latihan ${i + 1}', 'done': false, 'type': 'exercise', 'instructions': 'Kerjakan soal latihan nomor 1-5 sesuai materi.'},
        // referensi / tambahan
        {'title': 'Referensi dan bahan bacaan', 'done': i % 2 == 0, 'type': 'doc'},
      ]
    });

    final List<Map<String, dynamic>> tasks = [
      {'title': 'Tugas 1', 'deadline': '25 Des 2025', 'done': true, 'type': 'tugas'},
      {'title': 'Kuis 1', 'deadline': '28 Des 2025', 'done': false, 'type': 'kuis'},
      {'title': 'Tugas 2', 'deadline': '02 Jan 2026', 'done': false, 'type': 'tugas'},
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: kPrimaryColor,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
                  children: (m['content'] as List<Map<String, dynamic>>).map((s) {
                    Icon leading;
                    if (s['type'] == 'video') {
                      leading = const Icon(Icons.play_circle_fill);
                    } else {
                      leading = const Icon(Icons.description);
                    }
                        return ListTile(
                          leading: leading,
                          title: Text(s['title']),
                          trailing: s['done'] == true ? Icon(Icons.check_circle, color: kAccentColor) : null,
                          onTap: () {
                            if (s['type'] == 'video') {
                              // pick an appropriate video link based on course title and meeting index
                              final links = videoLinks[title] ?? [];
                              final link = links.isNotEmpty ? links[idx % links.length] : null;
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoPlayerScreen(title: s['title'], videoUrl: link)));
                            } else if (s['type'] == 'exercise') {
                              showDialog(context: context, builder: (_) => AlertDialog(
                                title: Text(s['title']),
                                content: Text(s['instructions'] ?? 'Kerjakan latihan ini.'),
                                actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Tutup'))],
                              ));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => DocumentViewerScreen(title: s['title'])));
                            }
                          },
                        );
                  }).toList(),
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
                    leading: Icon(t['type'] == 'kuis' ? Icons.quiz : Icons.assignment, color: kPrimaryColor),
                    title: Text(t['title']),
                    subtitle: Text('Tenggat: ${t['deadline']}'),
                    trailing: t['done'] == true ? Icon(Icons.check_circle, color: kAccentColor) : null,
                    onTap: () {
                      if (t['type'] == 'tugas') {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => TaskDetailScreen(title: t['title'])));
                      } else if (t['type'] == 'kuis') {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizInfoScreen(title: t['title'])));
                      }
                    },
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
