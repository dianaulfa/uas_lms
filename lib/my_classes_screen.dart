import 'package:flutter/material.dart';
import 'widgets/course_card.dart';
import 'theme.dart';

class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> courses = [
      {'title': 'UI/UX', 'lecturer': 'Dosen A', 'progress': 0.45, 'image': 'https://picsum.photos/seed/uiux/200/200'},
      {'title': 'Sistem Operasi', 'lecturer': 'Dosen B', 'progress': 0.7, 'image': 'https://picsum.photos/seed/sos/200/200'},
      {'title': 'Kewarganegaraan', 'lecturer': 'Dosen C', 'progress': 0.2, 'image': 'https://picsum.photos/seed/kn/200/200'},
      {'title': 'Multimedia', 'lecturer': 'Dosen D', 'progress': 0.55, 'image': 'https://picsum.photos/seed/multimedia/200/200'},
      {'title': 'Bahasa Inggris', 'lecturer': 'Dosen E', 'progress': 0.8, 'image': 'https://picsum.photos/seed/eng/200/200'},
      {'title': 'Olah Raga', 'lecturer': 'Dosen F', 'progress': 0.1, 'image': 'https://picsum.photos/seed/sport/200/200'},
    ];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.maybePop(context),
        ),
        centerTitle: true,
        title: const Text('Kelas Saya', style: TextStyle(color: Color(0xFF212121))),
        iconTheme: const IconThemeData(color: Color(0xFF212121)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final c = courses[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: CourseCard(
                title: c['title'],
                lecturer: c['lecturer'],
                progress: c['progress'],
                imageUrl: c['image'],
              ),
          );
        },
      ),
    );
  }
}
