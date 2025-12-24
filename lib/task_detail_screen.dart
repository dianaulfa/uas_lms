import 'package:flutter/material.dart';
import 'theme.dart';
import 'upload_file_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final String title;
  const TaskDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Instruksi Tugas:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kerjakan tugas ini dengan mengikuti instruksi yang diberikan. Pastikan file yang diupload sesuai format dan tidak melebihi ukuran maksimum.',
            ),
            const SizedBox(height: 16),

            // Status box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(6)),
                    child: const Text('Status Tugas', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  Row(children: const [Expanded(child: Text('Status Pengumpulan:')), Text('Belum')]),
                  const SizedBox(height: 8),
                  Row(children: const [Expanded(child: Text('Status Nilai:')), Text('-')]),
                  const SizedBox(height: 8),
                  Row(children: const [Expanded(child: Text('Batas Waktu:')), Text('25 Des 2025')]),
                  const SizedBox(height: 8),
                  Row(children: const [Expanded(child: Text('Sisa Waktu:')), Text('2 Hari 3 Jam')]),
                ],
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UploadFileScreen())),
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: const Text('Tambahkan Tugas'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Edit Pengajuan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
