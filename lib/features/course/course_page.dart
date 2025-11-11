import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_CourseData> courses = [
      _CourseData(
        title: 'Mengenal Bilangan Pecahan',
        desc: 'Belajar konsep pecahan dengan cara yang menyenangkan.',
        progress: 0.76,
        image: 'assets/images/course_fraction.png',
      ),
      _CourseData(
        title: 'Pengenalan Bangun Ruang',
        desc: 'Kenali bentuk 3D di sekitar kita.',
        progress: 0.32,
        image: 'assets/images/course_shape.png',
      ),
      _CourseData(
        title: 'Pengenalan Perkalian',
        desc: 'Dasar perkalian untuk pemula.',
        progress: 0.10,
        image: 'assets/images/course_math.png',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: courses
                    .map((c) => _CourseCard(data: c))
                    .toList(),
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

  const _CourseData({
    required this.title,
    required this.desc,
    required this.progress,
    required this.image,
  });
}

class _CourseCard extends StatelessWidget {
  final _CourseData data;

  const _CourseCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.asset(
              data.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _fallbackImage(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.desc,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Progress ${(data.progress * 100).toInt()}%',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF7B61FF),
                  ),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: data.progress,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFEDE9FF),
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFF7B61FF),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: ke detail course
                    },
                    child: Text(
                      'Learn More',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF7B61FF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      height: 150,
      width: double.infinity,
      color: const Color(0xFFEDE9FF),
      alignment: Alignment.center,
      child: Icon(
        Icons.menu_book_rounded,
        size: 48,
        color: Colors.deepPurple.shade300,
      ),
    );
  }
}
