import 'package:flutter/material.dart';
import '../theme.dart';
import '../course_detail_screen.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String lecturer;
  final double progress; // 0.0 - 1.0
  final VoidCallback? onTap;

  const CourseCard({Key? key, required this.title, required this.lecturer, required this.progress, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initials = title.isNotEmpty ? title.split(' ').map((e) => e[0]).take(2).join() : 'C';
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap ?? () {
          // Default navigation to CourseDetailScreen if onTap not provided
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => CourseDetailScreen(title: title)));
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0,2))],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(lecturer, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: progress, color: kPrimaryColor, backgroundColor: Colors.grey[200]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
