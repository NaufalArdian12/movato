import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movato/features/course/quiz_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String topicTitle;
  final List<Map<String, String>> lessons;
  final List<String> quiz;
  final int initialIndex;

  const VideoPlayerPage({
    super.key,
    required this.topicTitle,
    required this.lessons,
    required this.quiz,
    required this.initialIndex,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late int _currentIndex;
  YoutubePlayerController? _ytController;

  String extractYoutubeId(String url) {
    // Bersihkan URL YouTube dari parameter tambahan
    if (url.contains("&")) {
      url = url.split("&")[0];
    }

    // Ambil ID menggunakan converter bawaan
    final id = YoutubePlayer.convertUrlToId(url);

    if (id == null || id.isEmpty) {
      debugPrint("❌ Invalid YouTube URL: $url");
      return '';
    }

    return id;
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _initControllerWith(widget.lessons[_currentIndex]['video'] ?? '');
  }

  void _initControllerWith(String url) {
    final id = extractYoutubeId(url);

    _ytController = YoutubePlayerController(
      initialVideoId: id.isEmpty ? "dQw4w9WgXcQ" : id, // fallback ID aman
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  void _loadVideo(String url) {
    final newId = extractYoutubeId(url);

    if (_ytController == null) return;

    if (newId.isNotEmpty) {
      _ytController!.load(newId);
    } else {
      debugPrint("⚠ Invalid ID — keeping current controller alive");
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if lessons list changed, keep playing current index if possible
    if (oldWidget.lessons != widget.lessons) {
      final url = widget.lessons[_currentIndex]['video'] ?? '';
      _loadVideo(url);
    }
  }

  @override
  void dispose() {
    _ytController?.dispose();
    super.dispose();
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
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _ytController == null
                ? const Center(child: CircularProgressIndicator())
                : YoutubePlayer(
                    controller: _ytController!,
                    showVideoProgressIndicator: true,
                  ),
          ),

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
                  Text(
                    lesson['title'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson['desc'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20),

                  ...widget.lessons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isActive = index == _currentIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                        final url =
                            widget.lessons[_currentIndex]['video'] ?? '';
                        _loadVideo(url);
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

                  if (widget.quiz.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizPage(
                              title: 'Quiz – ${widget.topicTitle}',
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
                            colors: [Color(0xFF6A4EFF), Color(0xFF9B7BFF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
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
                            'Latihan soal sesuai materi pada topik ini',
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
