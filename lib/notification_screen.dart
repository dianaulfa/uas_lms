import 'package:flutter/material.dart';
import 'theme.dart';
import 'core/notification_service.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {'title': 'Nilai Tugas Desain UI/UX sudah tersedia.', 'time': '1 Hari 2 Jam Yang Lalu'},
      {'title': 'Kuis Sistem Operasi dijadwalkan besok.', 'time': '12 Jam Yang Lalu'},
      {'title': 'Pengumuman: Perubahan jadwal kuliah.', 'time': '2 Hari Yang Lalu'},
    ];
    // merge runtime notifications
    final runtime = NotificationService.instance.items;
    final merged = [...runtime, ...items];

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
        title: const Text('Notifikasi', style: TextStyle(color: Color(0xFF212121))),
        iconTheme: const IconThemeData(color: Color(0xFF212121)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: merged.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final it = merged[i];
          return ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.article, color: kPrimaryColor),
            ),
            title: Text(it['title'] ?? ''),
            subtitle: Text(it['time'] ?? '', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          );
        },
      ),
    );
  }
}
