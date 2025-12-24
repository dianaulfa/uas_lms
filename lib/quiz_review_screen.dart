import 'package:flutter/material.dart';
import 'theme.dart';
import 'quiz_screen.dart';

class QuizReviewScreen extends StatelessWidget {
  const QuizReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> questions = List.generate(15, (i) => 'Pertanyaan ${i + 1}');
    return Scaffold(
      appBar: AppBar(title: const Text('Review Jawaban'), backgroundColor: kPrimaryColor),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Dimulai Pada: Kamis...'),
                SizedBox(height: 6),
                Text('Status: Selesai'),
                SizedBox(height: 6),
                Text('Nilai: 85 / 100'),
              ]),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, i) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(questions[i]),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                        SizedBox(height: 6),
                        Text('Soal singkat ditampilkan di sini...', style: TextStyle(color: Colors.black87)),
                        SizedBox(height: 6),
                        Text('Jawaban Tersimpan', style: TextStyle(color: Colors.grey)),
                      ]),
                      trailing: TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizScreen(title: 'Review'))), child: const Text('Lihat Soal', style: TextStyle(color: Colors.blue))),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
