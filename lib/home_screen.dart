import 'dart:async';

import 'package:flutter/material.dart';
import 'theme.dart';
import 'profile_screen.dart';
import 'widgets/course_card.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;
  const HomeScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String displayName;
  late final PageController _pageController;
  int _currentBanner = 0;
  Timer? _bannerTimer;

  final List<String> _bannerImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  @override
  void initState() {
    super.initState();
    displayName = _nameFromEmail(widget.userEmail);
    _pageController = PageController(initialPage: 0);
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_bannerImages.isEmpty) return;
      _currentBanner = (_currentBanner + 1) % _bannerImages.length;
      _pageController.animateToPage(_currentBanner, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  String _nameFromEmail(String email) {
    final parts = email.split('@');
    if (parts.isEmpty) return 'Mahasiswa';
    final name = parts[0];
    return name.split('.').map((s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}').join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hallo, $displayName',
                      style: kHeaderTextStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen(userEmail: widget.userEmail)));
                    },
                    child: _buildAvatar(),
                  ),
                ],
              ),
            ),

            // Kartu Tugas (Merah)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Desain Antarmuka Mobile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('Tugas 01 - Buat wireframe', style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Text('Waktu Pengumpulan: 25 Des 2025', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),

            // Pengumuman (Carousel)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pengumuman Terakhir', style: kHeaderTextStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _bannerImages.length,
                      itemBuilder: (context, index) {
                        final path = _bannerImages[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(path, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: Colors.grey[300], child: Center(child: Text('Banner')))),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Progres Kelas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Progres Kelas', style: kHeaderTextStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 12),
                  CourseCard(title: 'Pemrograman Mobile', lecturer: 'Dosen A', progress: 0.6),
                  const SizedBox(height: 8),
                  CourseCard(title: 'Desain UI/UX', lecturer: 'Dosen B', progress: 0.35),
                  const SizedBox(height: 8),
                  CourseCard(title: 'Basis Data', lecturer: 'Dosen C', progress: 0.85),
                ],
              ),
            ),

            SizedBox(height: height * 0.06),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final username = widget.userEmail.split('@').first;
    final assetPath = 'assets/images/$username.png';
    return FutureBuilder(
      future: precacheImage(AssetImage(assetPath), context).then((_) => true).catchError((_) => false),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return CircleAvatar(radius: 22, backgroundImage: AssetImage(assetPath));
        }
        // fallback to initials
        final initials = username.isNotEmpty ? username[0].toUpperCase() : 'U';
        return CircleAvatar(radius: 22, child: Text(initials));
      },
    );
  }
}
