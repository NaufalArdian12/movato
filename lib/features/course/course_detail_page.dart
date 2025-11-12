import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_page.dart';

class CourseDetailPage extends StatelessWidget {
  final String courseKey; // 'fraction' | 'shapes' | 'multiplication'
  final String title;
  final String subtitle;
  final String image;

  const CourseDetailPage({
    super.key,
    required this.courseKey,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  // ---- LESSONS per course ----
  List<String> _lessonsFor(String key) {
    switch (key) {
      case 'fraction':
        return const [
          'Apa Itu Pecahan?',
          'Menghitung Besaran Pecahan Dalam Diagram',
          'Menghitung Perkalian Pecahan Penyebut Berbeda',
          'Menghitung Perkalian Pecahan Campuran',
        ];
      case 'shapes': // Pengenalan Bangun Ruang
        return const [
          'Mengenal Kubus & Balok',
          'Sisi, Rusuk, dan Titik Sudut',
          'Tabung, Kerucut, dan Bola',
          'Contoh Bangun Ruang di Sekitar Kita',
        ];
      case 'multiplication': // Pengenalan Perkalian
        return const [
          'Makna Perkalian sebagai Penjumlahan Berulang',
          'Perkalian Satuan Kecil',
          'Perkalian Puluhan',
          'Latihan Perkalian Dasar',
        ];
      default:
        return const [];
    }
  }

  // ---- QUIZ per course (pakai soal dari kamu) ----
  List<String> _quizFor(String key) {
    switch (key) {
      case 'shapes': // Pengenalan Bangun Ruang
        return const [
          'Sebutkan tiga contoh benda di sekitar kita yang berbentuk kubus!',
          'Sebuah balok memiliki berapa sisi, rusuk, dan titik sudut?',
          'Benda berikut yang berbentuk tabung adalah ...',
          'Perhatikan benda berikut: bola, dadu, kaleng, dan lemari. Benda yang tidak memiliki rusuk adalah …',
          'Bangun ruang yang memiliki dua tutup berbentuk lingkaran dan satu selimut adalah …',
        ];

      case 'multiplication': // Pengenalan Perkalian
        return const [
          'Ada 3 piring. Setiap piring berisi 4 kue. Berapa jumlah seluruh kue?',
          '5 × 2 artinya …',
          'Bu Guru memiliki 7 kantong. Setiap kantong berisi 10 kelereng. Berapa jumlah semua kelereng?',
          'Hasil dari 6 × 6 adalah …',
          'Hasil dari 8 × 9 adalah …',
        ];

      case 'fraction': // Mengenal Bilangan Pecahan
        return const [
          'Pecahan 3/4 setara dengan berapa persen?',
          'Sederhanakan pecahan 8/12.',
          'Manakah yang lebih besar: 2/3 atau 3/5? Jelaskan singkat.',
          'Ubah 1 1/2 menjadi pecahan biasa.',
          'Hasil dari 2/5 + 1/5 adalah …',
        ];

      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _lessonsFor(courseKey);
    final quiz = _quizFor(courseKey);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER: gambar + back
            SizedBox(
              height: 260,
              child: Stack(
                children: [
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
                            color: Colors.deepPurple.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
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

            // BODY
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    // tag & durasi
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2ECFF),
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
                              color: const Color(0xFF7B61FF),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.schedule,
                            size: 16,
                            color: Color(0xFF9E9E9E),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '2hr 15min',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // LIST LESSON + QUIZ
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ...lessons.map(
                            (t) => _LessonItem(title: t, isQuiz: false),
                          ),
                          if (quiz.isNotEmpty)
                            _LessonItem(
                              title: 'Quiz',
                              isQuiz: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuizPage(
                                      title: 'Quiz - $title',
                                      questions: quiz,
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),

                    // BUTTON GET STARTED
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: mulai dari lesson pertama
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
  final VoidCallback? onTap;

  const _LessonItem({required this.title, required this.isQuiz, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bgColor = isQuiz ? const Color(0xFF7B61FF) : const Color(0xFFF2ECFF);
    final textColor = isQuiz ? Colors.white : const Color(0xFF3C3C3C);
    final iconBgColor = isQuiz
        ? Colors.white
        : const Color(0xFF7B61FF).withOpacity(0.15);
    final iconColor = isQuiz
        ? const Color(0xFF7B61FF)
        : const Color(0xFF7B61FF);
    final iconData = isQuiz ? Icons.help_outline : Icons.play_arrow_rounded;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
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
              child: Icon(iconData, color: iconColor, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
