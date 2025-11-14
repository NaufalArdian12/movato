import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movato/src/core/widgets/course_card.dart';
import 'course_detail_page.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_CourseData> courses = [
      _CourseData(
        title: 'Mengenal Bilangan Pecahan',
        desc: 'Belajar konsep pecahan dengan cara yang menyenangkan.',
        progress: 0.76,
        image: 'assets/images/class1.png',
        courseKey: 'fraction',
      ),
      _CourseData(
        title: 'Pengenalan Bangun Ruang',
        desc: 'Kenali bentuk 3D di sekitar kita.',
        progress: 0.32,
        image: 'assets/images/course_shape.png',
        courseKey: 'shapes',
      ),
      _CourseData(
        title: 'Pengenalan Perkalian',
        desc: 'Dasar perkalian untuk pemula.',
        progress: 0.10,
        image: 'assets/images/course_math.png',
        courseKey: 'multiplication',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9F79FF), Color(0xFF7B61FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Text(
                  "Let's Learn New Course!",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // List cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: courses.map((c) {
                  return CourseCard(
                    title: c.title,
                    desc: c.desc,
                    progress: c.progress,
                    image: c.image,
                    onLearnMore: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseDetailPage(
                            courseKey: c.courseKey,
                            title: c.title,
                            subtitle: c.desc,
                            image: c.image,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _CourseData {
  final String title;
  final String desc;
  final double progress;
  final String image;
  final String courseKey;

  const _CourseData({
    required this.title,
    required this.desc,
    required this.progress,
    required this.image,
    required this.courseKey,
  });
}
