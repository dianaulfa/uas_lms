import 'package:flutter/material.dart';
import 'theme.dart';
import 'upload_file_screen.dart';
import 'core/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetailScreen extends StatefulWidget {
  final String title;
  const TaskDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool _submitted = false;
  String? _fileName;
  late final String _prefKeySubmitted;
  late final String _prefKeyFileName;

  Future<void> _openUpload() async {
    final res = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UploadFileScreen()));
    if (res != null && res is Map) {
      setState(() {
        _submitted = true;
        _fileName = res['name'] as String?;
      });
      // persist status
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefKeySubmitted, true);
      if (_fileName != null) await prefs.setString(_prefKeyFileName, _fileName!);
      // add notification
      NotificationService.instance.add('Anda telah mengirimkan tugas ${widget.title}.');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tugas berhasil diunggah')));
    }
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final submitted = prefs.getBool(_prefKeySubmitted) ?? false;
    final fname = prefs.getString(_prefKeyFileName);
    setState(() {
      _submitted = submitted;
      _fileName = fname;
    });
  }

  @override
  void initState() {
    super.initState();
    _prefKeySubmitted = 'task_submitted_${widget.title}';
    _prefKeyFileName = 'task_filename_${widget.title}';
    _loadStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  Row(children: [const Expanded(child: Text('Status Pengumpulan:')), Text(_submitted ? 'Sudah' : 'Belum')]),
                  const SizedBox(height: 8),
                  Row(children: [const Expanded(child: Text('Status Nilai:')), Text(_submitted ? '-' : '-')]),
                  const SizedBox(height: 8),
                  Row(children: const [Expanded(child: Text('Batas Waktu:')), Text('25 Des 2025')]),
                  const SizedBox(height: 8),
                  Row(children: const [Expanded(child: Text('Sisa Waktu:')), Text('2 Hari 3 Jam')]),
                  if (_submitted && _fileName != null) ...[
                    const SizedBox(height: 12),
                    Text('File dikirim: $_fileName', style: const TextStyle(fontStyle: FontStyle.italic)),
                  ]
                ],
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _openUpload,
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: const Text('Tambahkan Tugas'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _submitted ? () {/* implement edit if needed */} : null,
                child: const Text('Edit Pengajuan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
