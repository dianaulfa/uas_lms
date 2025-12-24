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

  final List<Map<String, String>> _banners = [
    {
      'image': 'assets/images/banner1.png',
      'title': 'Pengumuman UTS',
      'subtitle': 'Jadwal UTS dimulai 5 Januari 2026',
    },
    {
      'image': 'assets/images/banner2.png',
      'title': 'Pendaftaran PKL',
      'subtitle': 'Buka sampai 10 Januari 2026',
    },
    {
      'image': 'assets/images/banner3.png',
      'title': 'Workshop Flutter',
      'subtitle': 'Gratis untuk 50 peserta pertama',
    },
  ];

  @override
  void initState() {
    super.initState();
    displayName = _nameFromEmail(widget.userEmail);
    _pageController = PageController(initialPage: 0);
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_banners.isEmpty) return;
      _currentBanner = (_currentBanner + 1) % _banners.length;
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
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _banners.length,
                            onPageChanged: (p) => setState(() => _currentBanner = p),
                            itemBuilder: (context, index) {
                              final banner = _banners[index];
                              final path = banner['image']!;
                              final title = banner['title']!;
                              final subtitle = banner['subtitle']!;
                              return GestureDetector(
                                onTap: () {
                                  showDialog(context: context, builder: (_) => AlertDialog(title: Text(title), content: Text(subtitle), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))]));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(path, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: Colors.grey[300])),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [Colors.black.withOpacity(0.45), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        bottom: 12,
                                        right: 12,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 4),
                                            Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_banners.length, (i) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: i == _currentBanner ? 18 : 8,
                                height: 8,
                                decoration: BoxDecoration(color: i == _currentBanner ? kPrimaryColor : Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                              )),
                        ),
                      ],
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
