import 'package:flutter/material.dart';
import 'theme.dart';
import 'profile_screen.dart';
import 'widgets/course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hallo, Nama Mahasiswa',
                      style: kHeaderTextStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      child: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),

            // Kartu Tugas (Merah)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Desain Antarmuka Mobile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('Tugas 01 - Buat wireframe', style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Text('Waktu Pengumpulan: 25 Des 2025', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),

            // Pengumuman
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pengumuman Terakhir', style: kHeaderTextStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('Banner Pengumuman', style: kBodyTextStyle)),
                  ),
                ],
              ),
            ),

            // Progres Kelas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Progres Kelas', style: kHeaderTextStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 12),
                  CourseCard(title: 'Pemrograman Mobile', lecturer: 'Dosen A', progress: 0.6),
                  const SizedBox(height: 8),
                  CourseCard(title: 'Desain UI/UX', lecturer: 'Dosen B', progress: 0.35),
                  const SizedBox(height: 8),
                  CourseCard(title: 'Basis Data', lecturer: 'Dosen C', progress: 0.85),
                ],
              ),
            ),

            SizedBox(height: height * 0.06),
          ],
        ),
      ),
    );
  }
}
