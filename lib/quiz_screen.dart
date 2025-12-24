import 'dart:async';

import 'package:flutter/material.dart';
import 'theme.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  const QuizScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _current = 0;
  int _selected = -1;
  Timer? _timer;
  Duration _remaining = const Duration(minutes: 15);

  final List<Map<String, dynamic>> _questions = List.generate(15, (i) => {
    'text': 'Radio button dapat digunakan untuk menentukan? (Soal ${i + 1})',
    'options': ['Pilihan A', 'Pilihan B', 'Pilihan C', 'Pilihan D', 'Pilihan E']
  });

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining -= const Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(children: [const Icon(Icons.timer), const SizedBox(width: 6), Text(_format(_remaining))]),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // question numbers
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _questions.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () => setState(() {
                    _current = i;
                    _selected = -1;
                  }),
                  child: Container(
                    width: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == _current ? kAccentColor : Colors.grey[200],
                    ),
                    child: Center(child: Text('${i + 1}', style: TextStyle(color: i == _current ? Colors.white : Colors.black))),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Soal Nomor ${_current + 1} / ${_questions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(q['text']),
            const SizedBox(height: 16),
            ...List.generate((q['options'] as List).length, (idx) {
              final opt = q['options'][idx];
              final selected = _selected == idx;
              return GestureDetector(
                onTap: () => setState(() => _selected = idx),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selected ? Colors.pink.shade100 : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: selected ? kPrimaryColor : Colors.grey.shade300),
                  ),
                  child: Row(children: [Text(String.fromCharCode(65 + idx) + '. '), const SizedBox(width: 8), Expanded(child: Text(opt))]),
                ),
              );
            }),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_current < _questions.length - 1) {
                    setState(() {
                      _current += 1;
                      _selected = -1;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: const Text('Soal Selanjutnya'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
