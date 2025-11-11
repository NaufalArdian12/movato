import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const CourseDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // dummy list lesson (bisa kamu ganti isi nya)
    final lessons = [
      'Apa Itu Pecahan?',
      'Menghitung Besaran Pecahan Dalam Diagram',
      'Menghitung Perkalian Pecahan Penyebut Berbeda',
      'Menghitung Perkalian Pecahan Campuran',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER: back + gambar =====
            SizedBox(
              height: 260,
              child: Stack(
                children: [
                  // gambar full width
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFEDE9FF),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 60,
                            color: Color(0xFF7B61FF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // gradient overlay halus biar text kebaca
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.25),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // tombol back
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== BODY PUTIH BAWAH =====
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul course
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tag + durasi
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B61FF),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Course Preview',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 254, 254, 255),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.schedule,
                            size: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '2hr 15min',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 255, 254, 254),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ===== LIST LESSON =====
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ...lessons.map(
                            (lesson) => _LessonItem(
                              title: lesson,
                              isQuiz: false,
                            ),
                          ),
                          // Quiz terakhir
                          const _LessonItem(
                            title: 'Quiz Dasar Pecahan',
                            isQuiz: true,
                          ),
                        ],
                      ),
                    ),

                    // ===== BUTTON GET STARTED =====
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: mulai course / buka lesson pertama
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7B61FF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          'Get Started!',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonItem extends StatelessWidget {
  final String title;
  final bool isQuiz;

  const _LessonItem({
    required this.title,
    required this.isQuiz,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isQuiz ? const Color(0xFF7B61FF) : const Color(0xFFF2ECFF);
    final textColor = isQuiz ? Colors.white : const Color(0xFF3C3C3C);
    final iconBgColor =
        isQuiz ? Colors.white : const Color(0xFF7B61FF).withOpacity(0.15);
    final iconColor = isQuiz ? const Color(0xFF7B61FF) : const Color(0xFF7B61FF);
    final iconData = isQuiz ? Icons.help_outline : Icons.play_arrow_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              iconData,
              color: iconColor,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
