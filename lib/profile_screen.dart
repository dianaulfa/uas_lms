import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets/course_card.dart';

String _displayNameFromEmail(String email) {
  final parts = email.split('@');
  if (parts.isEmpty) return 'Mahasiswa';
  final name = parts[0];
  return name.split('.').map((s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}').join(' ');
}

class ProfileScreen extends StatelessWidget {
  final String userEmail;
  const ProfileScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          // Top red header
          Container(
            height: h * 0.32,
            color: kPrimaryColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: const SizedBox.shrink(),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Builder(builder: (context) {
                            final username = userEmail.split('@').first;
                            final assetPath = 'assets/images/$username.png';
                            final initials = username.isNotEmpty ? username[0].toUpperCase() : 'U';
                            return FutureBuilder<bool>(
                              future: precacheImage(AssetImage(assetPath), context).then((_) => true).catchError((_) => false),
                              builder: (context, snap) {
                                if (snap.hasData && snap.data == true) {
                                  return CircleAvatar(radius: 44, backgroundImage: AssetImage(assetPath), backgroundColor: Colors.white);
                                }
                                return CircleAvatar(radius: 44, backgroundColor: Colors.white, child: Text(initials, style: const TextStyle(fontSize: 28, color: kPrimaryColor)));
                              },
                            );
                          }),
                          const SizedBox(height: 8),
                          Text(_displayNameFromEmail(userEmail), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // White card overlapping
          Positioned(
            top: h * 0.28,
            left: 12,
            right: 12,
            bottom: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
              ),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: kPrimaryColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [Tab(text: 'About Me'), Tab(text: 'Kelas'), Tab(text: 'Edit Profile')],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // About Me
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: $userEmail'),
                                const SizedBox(height: 8),
                                const Text('Program Studi: Teknik Informatika'),
                                const SizedBox(height: 8),
                                const Text('Fakultas: Teknik'),
                                const SizedBox(height: 8),
                                const Text('Aktivitas terakhir: 2 jam yang lalu'),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                                    child: const Text('Log Out'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Kelas
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: ListView(
                              children: const [
                                CourseCard(title: 'Pemrograman Mobile', lecturer: 'Dosen A', progress: 0.6),
                                SizedBox(height: 8),
                                CourseCard(title: 'Desain UI/UX', lecturer: 'Dosen B', progress: 0.35),
                                SizedBox(height: 8),
                                CourseCard(title: 'Basis Data', lecturer: 'Dosen C', progress: 0.85),
                              ],
                            ),
                          ),

                          // Edit Profile
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                TextField(decoration: const InputDecoration(labelText: 'Nama Depan')),
                                const SizedBox(height: 8),
                                TextField(decoration: const InputDecoration(labelText: 'Nama Belakang')),
                                const SizedBox(height: 8),
                                TextField(decoration: const InputDecoration(labelText: 'Email')),
                                const SizedBox(height: 8),
                                TextField(decoration: const InputDecoration(labelText: 'Deskripsi'), maxLines: 3),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                                    child: const Text('Simpan'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
