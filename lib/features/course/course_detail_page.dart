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
  int? _expandedIndex;

  List<Map<String, String>> _lessonsFor(String key) {
    switch (key) {
      case 'fraction':
        return [
          {
            'title': 'Apa Itu Pecahan?',
            'video': 'https://www.youtube.com/watch?v=0hPRfqPFtt8',
          },
          {
            'title': 'Menghitung Besaran Pecahan Dalam Diagram',
            'video': 'https://www.youtube.com/watch?v=0c_8H4w4DkY',
          },

          {
            'title': 'Menghitung Perkalian Pecahan Penyebut Berbeda',
            'video': 'https://www.youtube.com/watch?v=CfOScoklV3A',
          },
          {
            'title': 'Menghitung Perkalian Pecahan Campuran',
            'video': 'https://www.youtube.com/watch?v=s9alztxLsyk',
          },
        ];
      case 'shapes':
        return [
          {
            'title': 'Mengenal Kubus & Balok',
            'video': 'https://www.youtube.com/watch?v=EB2rOeSnheY',
          },
          {
            'title': 'Sisi, Rusuk, dan Titik Sudut',
            'video': 'https://www.youtube.com/watch?v=NdaOS3841h0',
          },
          {
            'title': 'Tabung, Kerucut, dan Bola',
            'video': 'https://www.youtube.com/watch?v=p0k_TWCMLZ8',
          },
          {
            'title': 'Contoh Bangun Ruang di Sekitar Kita',
            'video': 'https://www.youtube.com/watch?v=qAVBIYN23Zw',
          },
        ];
      case 'multiplication':
        return [
          {
            'title': 'Makna Perkalian sebagai Penjumlahan Berulang',
            'video': 'https://www.youtube.com/watch?v=N4ulEwN7wjw',
          },
          {
            'title': 'Perkalian Satuan Kecil',
            'video': 'https://www.youtube.com/watch?v=inSZoE5-n_g',
          },
          {
            'title': 'Perkalian Puluhan',
            'video': 'https://www.youtube.com/watch?v=Ed22Z6XHrho',
          },
          {
            'title': 'Latihan Perkalian Dasar',
            'video': 'https://www.youtube.com/watch?v=DoHeSR-iSws',
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
    final lessons = _lessonsFor(widget.courseKey);
    final quiz = _quizFor(widget.courseKey);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: ListView(
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),

                    ...lessons.asMap().entries.map((entry) {
                      final index = entry.key;
                      final lesson = entry.value;
                      final isExpanded = _expandedIndex == index;

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _expandedIndex = isExpanded ? null : index;
                              });
                            },
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withValues(
                                      alpha: 0.05,
                                    ),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
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
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      lesson['title']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.play_arrow_rounded,
                                    color: const Color(0xFF7B61FF),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          if (isExpanded)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: YoutubePlayerWidget(
                                url: lesson['video'] ?? '',
                              ),
                            ),
                        ],
                      );
                    }),

                    if (quiz.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
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
                          icon: const Icon(Icons.quiz_outlined),
                          label: const Text("Mulai Quiz"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B61FF),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
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
      ),
    );
  }
}

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
    final videoId = YoutubePlayer.convertUrlToId(widget.url) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
