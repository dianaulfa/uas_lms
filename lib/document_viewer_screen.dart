import 'package:flutter/material.dart';
import 'theme.dart';

class DocumentViewerScreen extends StatelessWidget {
  final String title;
  const DocumentViewerScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white24),
              child: const Text('Halaman 1/26'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 1200,
              color: Colors.grey[200],
              child: const Center(child: Text('Halaman Dokumen (placeholder)', style: TextStyle(color: Colors.black54))),
            ),
          ],
        ),
      ),
    );
  }
}
