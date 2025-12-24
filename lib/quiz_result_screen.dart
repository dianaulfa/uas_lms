import 'package:flutter/material.dart';
import 'theme.dart';
import 'quiz_review_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final double score;
  const QuizResultScreen({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kPrimaryColor, title: const Text('Hasil Kuis')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nilai Akhir Anda Untuk Kuis Ini Adalah ${score.toStringAsFixed(1)} / 100.00', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Status'), SizedBox(height:4), Text('Selesai')])),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Waktu'), SizedBox(height:4), Text('Dikirim Pada Kamis...')])),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Nilai'), const SizedBox(height:4), Text('85.0')])),
                    TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuizReviewScreen())), child: const Text('Tinjau Kembali', style: TextStyle(color: Colors.blue))),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Ambil Kuis Lagi'))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton(onPressed: () => Navigator.maybePop(context), child: const Text('Kembali Ke Kelas'))),
            ])
          ],
        ),
      ),
    );
  }
}
