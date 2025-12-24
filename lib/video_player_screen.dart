import 'package:flutter/material.dart';
import 'theme.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String title;
  final String? videoUrl;
  const VideoPlayerScreen({Key? key, required this.title, this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> others = [
      {'title': 'UI Design - Part 2', 'time': '10:23'},
      {'title': 'Wireframe Basics', 'time': '08:12'},
      {'title': 'Prototyping Tips', 'time': '12:45'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: kPrimaryColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // video area (mock)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.play_arrow, color: Colors.white, size: 48),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Text('UI DESIGN', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 22, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
            if (videoUrl != null) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Link Video:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(videoUrl!, style: const TextStyle(color: Colors.blueAccent)),
              ]),
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Video Lainnya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: others.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final it = others[i];
                return ListTile(
                  leading: Container(width: 80, color: Colors.grey[300]),
                  title: Text(it['title'] ?? ''),
                  subtitle: Text(it['time'] ?? ''),
                  onTap: () {},
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
