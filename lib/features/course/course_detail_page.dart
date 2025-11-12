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

  // ---------------- LESSONS ----------------
  List<String> _lessonsFor(String key) {
    switch (key) {
      case 'fraction': // mengenal bilangan pecahan
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

  // ---------------- QUIZ (pakai soal kamu) ----------------
  List<String> _quizFor(String key) {
    switch (key) {
      case 'shapes':
        return const [
          'Sebutkan tiga contoh benda di sekitar kita yang berbentuk kubus!',
          'Sebuah balok memiliki berapa sisi, rusuk, dan titik sudut?',
          'Benda berikut yang berbentuk tabung adalah ...',
          'Perhatikan benda berikut: bola, dadu, kaleng, dan lemari. Benda yang tidak memiliki rusuk adalah …',
          'Bangun ruang yang memiliki dua tutup berbentuk lingkaran dan satu selimut adalah …',
        ];
      case 'multiplication':
        return const [
          'Ada 3 piring. Setiap piring berisi 4 kue. Berapa jumlah seluruh kue?',
          '5 × 2 artinya …',
          'Bu Guru memiliki 7 kantong. Setiap kantong berisi 10 kelereng. Berapa jumlah semua kelereng?',
          'Hasil dari 6 × 6 adalah …',
          'Hasil dari 8 × 9 adalah …',
        ];
      case 'fraction':
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
            // ---------------- HEADER ----------------
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
                        // fallback bila asset belum ada
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFEDE9FF),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 64,
                            color: Colors.deepPurple.shade300,
                          ),
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- BODY ----------------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
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

                    // tag preview + durasi
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2ECFF),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            'Course Preview',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF7B61FF),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.schedule, size: 16, color: Color(0xFF9E9E9E)),
                        const SizedBox(width: 4),
                        Text(
                          '2hr 15min',
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9E9E9E)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // list lessons + quiz
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ...lessons.asMap().entries.map(
                            (e) => _LessonItem(
                              index: e.key + 1,
                              title: e.value,
                              subtitle: 'Lorem ipsum dolor sit amet',
                              isQuiz: false,
                              onTap: () {
                                // TODO: buka materi (video/teks)
                              },
                            ),
                          ),
                          if (quiz.isNotEmpty)
                            _LessonItem(
                              isQuiz: true,
                              title: 'Quiz Dasar',
                              subtitle: 'Uji pemahamanmu dari materi ini',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuizPage(
                                      title: 'Quiz – $title',
                                      questions: quiz, // <- list soal aman (tidak null)
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),

                    // primary action
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
  final int? index;               // untuk lesson (1,2,3,…)
  final String title;
  final String? subtitle;         // deskripsi kecil
  final bool isQuiz;
  final VoidCallback? onTap;

  const _LessonItem({
    this.index,
    required this.title,
    this.subtitle,
    required this.isQuiz,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isQuiz ? const Color(0xFF7B61FF) : Colors.white;
    final fg = isQuiz ? Colors.white : const Color(0xFF3C3C3C);
    final sub = isQuiz ? Colors.white70 : Colors.grey[600];

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isQuiz
              ? [
                  BoxShadow(
                    color: const Color(0xFF7B61FF).withOpacity(0.28),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Row(
          children: [
            // chip index (untuk lesson) / ikon (untuk quiz)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isQuiz ? Colors.white : const Color(0xFF7B61FF).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: isQuiz
                  ? const Icon(Icons.help_outline, color: Color(0xFF7B61FF))
                  : Text(
                      '${index ?? ''}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7B61FF),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            // texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: fg,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: sub,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            // trailing
            Container(
              decoration: BoxDecoration(
                color: isQuiz
                    ? Colors.white.withOpacity(0.15)
                    : const Color(0xFF7B61FF).withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                isQuiz ? Icons.quiz_outlined : Icons.play_arrow_rounded,
                size: 22,
                color: isQuiz ? Colors.white : const Color(0xFF7B61FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
