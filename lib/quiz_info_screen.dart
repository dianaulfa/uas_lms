import 'package:flutter/material.dart';
import 'theme.dart';
import 'quiz_screen.dart';

class QuizInfoScreen extends StatelessWidget {
  final String title;
  const QuizInfoScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: kPrimaryColor),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Silahkan kerjakan kuis ini dalam waktu yang ditentukan.'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Batas Waktu: 15 menit'),
                SizedBox(height: 6),
                Text('Metode Penilaian: Nilai Tertinggi'),
              ]),
            ),
            const SizedBox(height: 12),
            const Text('Riwayat Percobaan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Belum ada percobaan.'),
            const Spacer(),
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: const Text('Kembali Ke Kelas'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizScreen(title: title))),
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  child: const Text('Ambil Kuis'),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
