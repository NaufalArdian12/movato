import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'quiz_page.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseKey;
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

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  List<Map<String, String>> _lessonsFor(String key) {
    switch (key) {
      case 'fraction':
        return [
          {
            'title': 'Apa Itu Pecahan?',
            'video': 'https://www.youtube.com/watch?v=0hPRfqPFtt8',
            'desc':
                'Di materi ini kamu akan mengenal apa itu pecahan, pembilang, penyebut, dan contoh penggunaannya dalam kehidupan sehari-hari.',
          },
          {
            'title': 'Menghitung Besaran Pecahan Dalam Diagram',
            'video': 'https://www.youtube.com/watch?v=0c_8H4w4DkY',
            'desc':
                'Kamu belajar membaca dan menghitung pecahan menggunakan diagram gambar seperti lingkaran atau persegi yang dibagi beberapa bagian.',
          },
          {
            'title': 'Menghitung Perkalian Pecahan Penyebut Berbeda',
            'video': 'https://www.youtube.com/watch?v=CfOScoklV3A',
            'desc':
                'Materi ini menjelaskan langkah mudah mengalikan dua pecahan yang penyebutnya berbeda.',
          },
          {
            'title': 'Menghitung Perkalian Pecahan Campuran',
            'video': 'https://www.youtube.com/watch?v=s9alztxLsyk',
            'desc':
                'Di sini kamu belajar mengubah pecahan campuran menjadi pecahan biasa dan menghitung perkaliannya.',
          },
        ];

      case 'shapes':
        return [
          {
            'title': 'Mengenal Kubus & Balok',
            'video': 'https://www.youtube.com/watch?v=EB2rOeSnheY',
            'desc':
                'Kamu akan mengenal bangun ruang kubus dan balok: jumlah sisi, rusuk, dan titik sudutnya.',
          },
          {
            'title': 'Sisi, Rusuk, dan Titik Sudut',
            'video': 'https://www.youtube.com/watch?v=NdaOS3841h0',
            'desc':
                'Materi ini membantumu membedakan mana yang disebut sisi, rusuk, dan titik sudut pada bangun ruang.',
          },
          {
            'title': 'Tabung, Kerucut, dan Bola',
            'video': 'https://www.youtube.com/watch?v=p0k_TWCMLZ8',
            'desc':
                'Kamu akan mengenal bangun ruang tabung, kerucut, dan bola beserta contoh bendanya di sekitar kita.',
          },
          {
            'title': 'Contoh Bangun Ruang di Sekitar Kita',
            'video': 'https://www.youtube.com/watch?v=qAVBIYN23Zw',
            'desc':
                'Di materi ini kamu diajak mengamati benda-benda di rumah dan sekolah yang bentuknya seperti bangun ruang.',
          },
        ];

      case 'multiplication':
        return [
          {
            'title': 'Makna Perkalian sebagai Penjumlahan Berulang',
            'video': 'https://www.youtube.com/watch?v=N4ulEwN7wjw',
            'desc':
                'Kamu belajar bahwa perkalian adalah penjumlahan yang diulang berkali-kali, dengan contoh yang sederhana.',
          },
          {
            'title': 'Perkalian Satuan Kecil',
            'video': 'https://www.youtube.com/watch?v=inSZoE5-n_g',
            'desc':
                'Di materi ini kamu berlatih mengalikan bilangan satuan kecil seperti 2×3, 4×5, dan lainnya.',
          },
          {
            'title': 'Perkalian Puluhan',
            'video': 'https://www.youtube.com/watch?v=Ed22Z6XHrho',
            'desc':
                'Kamu akan belajar trik mudah mengalikan bilangan puluhan supaya lebih cepat.',
          },
          {
            'title': 'Latihan Perkalian Dasar',
            'video': 'https://www.youtube.com/watch?v=DoHeSR-iSws',
            'desc':
                'Materi ini berisi latihan soal untuk menguatkan pemahaman perkalian dasar yang sudah dipelajari.',
          },
        ];

      default:
        return [];
    }
  }

  List<String> _quizFor(String key) {
    switch (key) {
      case 'shapes':
        return const [
          'Sebutkan tiga contoh benda di sekitar kita yang berbentuk kubus!',
          'Sebuah balok memiliki berapa sisi, rusuk, dan titik sudut?',
          'Benda berikut yang berbentuk tabung adalah ...',
          'Benda yang tidak memiliki rusuk adalah …',
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
          'Manakah yang lebih besar: 2/3 atau 3/5?',
          'Ubah 1 1/2 menjadi pecahan biasa.',
          'Hasil dari 2/5 + 1/5 adalah …',
        ];

      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _lessonsFor(widget.courseKey);
    final quiz = _quizFor(widget.courseKey);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // HEADER GAMBAR
            SliverAppBar(
              pinned: false,
              expandedHeight: 260,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
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
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
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
            ),

            // ISI
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul course
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle course
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // LIST KARTU MATERI
                    ...lessons.asMap().entries.map((entry) {
                      final index = entry.key;
                      final lesson = entry.value;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          leading: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF7B61FF,
                              ).withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${index + 1}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF7B61FF),
                              ),
                            ),
                          ),
                          title: Text(
                            lesson['title'] ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            lesson['desc'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                          trailing: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF7B61FF),
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VideoPlayerPage(
                                  courseTitle: widget.title,
                                  lessons: lessons,
                                  quiz: quiz,
                                  initialIndex: index,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),

                    // KARTU QUIZ UNGU
                    if (quiz.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF6A4EFF), Color(0xFF9B7BFF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          title: Text(
                            'Quiz Dasar Pecahan',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'Latihan soal dasar mengenai materi ini',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          trailing: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.quiz_outlined,
                              color: Color(0xFF6A4EFF),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizPage(
                                  title: 'Quiz – ${widget.title}',
                                  questions: quiz,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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

// ================== VIDEO PAGE (KAYAK YOUTUBE) ==================

class VideoPlayerPage extends StatefulWidget {
  final String courseTitle;
  final List<Map<String, String>> lessons;
  final List<String> quiz;
  final int initialIndex;

  const VideoPlayerPage({
    super.key,
    required this.courseTitle,
    required this.lessons,
    required this.quiz,
    required this.initialIndex,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lessons[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          lesson['title'] ?? '',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // ===== VIDEO DI ATAS =====
          AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayerWidget(
              url: lesson['video'] ?? '',
            ),
          ),

          // ===== KONTEN DI BAWAH (judul + deskripsi + list materi + quiz) =====
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  // judul materi aktif
                  Text(
                    lesson['title'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // deskripsi materi aktif
                  Text(
                    lesson['desc'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // daftar materi selanjutnya (dan sebelumnya) — playlist
                  ...widget.lessons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isActive = index == _currentIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFE6DEFF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          title: Text(
                            item['title'] ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            item['desc'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                          trailing: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? const Color(0xFF6A4EFF)
                                  : const Color(0xFF7B61FF),
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  // kartu quiz di paling bawah (kalau ada)
                  if (widget.quiz.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizPage(
                              title: 'Quiz – ${widget.courseTitle}',
                              questions: widget.quiz,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF6A4EFF),
                              Color(0xFF9B7BFF),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 9, 0, 0).withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          title: Text(
                            'Quiz Dasar',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'Latihan soal sesuai materi pada kursus ini',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          trailing: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.quiz_outlined,
                              color: Color(0xFF6A4EFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ================== YOUTUBE PLAYER WIDGET ==================

class YoutubePlayerWidget extends StatefulWidget {
  final String url;
  const YoutubePlayerWidget({super.key, required this.url});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final id = YoutubePlayer.convertUrlToId(widget.url) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant YoutubePlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      final newId = YoutubePlayer.convertUrlToId(widget.url) ?? '';
      _controller.load(newId);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}

