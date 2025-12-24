import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'theme.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({Key? key}) : super(key: key);

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  String? _fileName;
  String? _filePath;
  Uint8List? _fileBytes;
  int? _fileSize;
  String? _extension;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(withData: true, allowMultiple: false);
      if (result == null) return;
      final file = result.files.single;
      // On web, `path` is always null — use `bytes` instead. Guard access.
      final String? path = file.path;
      final bytes = file.bytes;
      setState(() {
        _fileName = file.name;
        _filePath = path;
        _fileBytes = bytes;
        _fileSize = file.size;
        _extension = file.extension;
      });
    } catch (e) {
      final message = e is Exception ? e.toString() : 'Gagal memilih file';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _save() {
    if (_fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih file terlebih dahulu')));
      return;
    }
    // Simulate upload: return file info to caller
    Navigator.of(context).pop({'name': _fileName, 'path': _filePath, 'size': _fileSize, 'bytes': _fileBytes});
  }

  Widget _buildPreview() {
    if (_fileName == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.cloud_upload, size: 64, color: Colors.blue),
          SizedBox(height: 12),
          Text('File yang akan diupload tampil di sini', style: TextStyle(color: Colors.black54)),
        ],
      );
    }

    final isImage = _extension != null && ['png', 'jpg', 'jpeg', 'gif', 'webp'].contains(_extension!.toLowerCase());
    final isVideo = _extension != null && ['mp4', 'mov', 'wmv', 'avi', 'mkv'].contains(_extension!.toLowerCase());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isImage && _fileBytes != null)
          Image.memory(_fileBytes!, height: 120, fit: BoxFit.contain)
        else if (isVideo)
          Column(children: const [Icon(Icons.videocam, size: 80, color: Colors.black45), SizedBox(height: 8), Text('Preview video tidak tersedia')])
        else
          Column(children: const [Icon(Icons.insert_drive_file, size: 64, color: Colors.grey), SizedBox(height: 8), Text('Preview tidak tersedia')]),
        const SizedBox(height: 12),
        Text(_fileName ?? ''),
        if (_fileSize != null) Text('${(_fileSize! / 1024).toStringAsFixed(2)} KB', style: const TextStyle(color: Colors.black54, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload File'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Maksimum File 5MB. Ekstensi yang didukung: .pdf, .docx, .jpg, .png, .mp4'),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                  ),
                  child: Center(child: _buildPreview()),
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickFile,
                    child: const Text('Pilih File'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
