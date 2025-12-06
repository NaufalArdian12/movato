// lib/features/topic/topic_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movato/features/course/quiz_page.dart';
import 'package:movato/src/di/providers.dart';
import 'package:movato/features/topic/models/topic.dart';
import 'package:movato/features/topic/video_player_page.dart';

class TopicDetailPage extends ConsumerWidget {
  final int topicId;
  const TopicDetailPage({required this.topicId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTopic = ref.watch(topicDetailProvider(topicId));

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: asyncTopic.when(
        data: (Topic topic) {
          // convert dynamic videos/quizzes to expected shapes
          final lessons = _normalizeLessons(topic.videos);
          final quizzes = _normalizeQuizzes(topic.quizzes);

          return SafeArea(
            child: CustomScrollView(
              slivers: [
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
                            child: _buildHeaderImage(topic),
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
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
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

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic.title,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        if ((topic.description ?? '').isNotEmpty)
                          Text(
                            topic.description ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        const SizedBox(height: 20),

                        // Lessons
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
                              leading: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7B61FF).withOpacity(0.12),
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
                                lesson['title'] ?? '-',
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
                                      topicTitle: topic.title,
                                      lessons: lessons,
                                      quiz: quizzes,
                                      initialIndex: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),

                        // Quiz card (if exists)
                        if (quizzes.isNotEmpty)
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
                                'Quiz Dasar ${topic.title}',
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuizPage(
                                      title: 'Quiz – ${topic.title}',
                                      questions: quizzes,
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: ${err.toString()}')),
      ),
    );
  }

  Widget _buildHeaderImage(Topic topic) {
    // If API provides image url, use NetworkImage. Else fallback to placeholder.
    // Here we try some common keys that backend might provide.
    final imageUrl = _extractImageUrl(topic);
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) {
        return Container(
          color: const Color(0xFFEDE9FF),
          alignment: Alignment.center,
          child: Icon(
            Icons.menu_book_rounded,
            size: 64,
            color: Colors.deepPurple.shade300,
          ),
        );
      });
    }

    // fallback static asset
    return Image.asset(
      'assets/images/class4.jpg',
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
    );
  }

  String? _extractImageUrl(Topic t) {
    // try common fields
    try {
      // if topic has a 'thumbnail' or 'image' in its videos/quizzes structure or root, adjust here
      // since Topic model is dynamic, we keep this flexible
      return null;
    } catch (_) {
      return null;
    }
  }

  List<Map<String, String>> _normalizeLessons(List<dynamic>? raw) {
    // Accept many shapes:
    // - List<Map<String, dynamic>> with keys: title, video, desc
    // - List<String> (video urls)
    // - null -> []
    if (raw == null) return [];

    final List<Map<String, String>> out = [];
    for (var item in raw) {
      if (item == null) continue;
      if (item is String) {
        out.add({'title': 'Video', 'video': item, 'desc': ''});
      } else if (item is Map) {
        final title = (item['title'] ?? item['name'] ?? '').toString();
        final video = (item['video'] ?? item['url'] ?? item['source'] ?? '').toString();
        final desc = (item['description'] ?? item['desc'] ?? '').toString();
        // if video looks like a YouTube id, try to convert, else maybe full url
        out.add({'title': title.isEmpty ? 'Video' : title, 'video': video, 'desc': desc});
      } else {
        out.add({'title': 'Video', 'video': item.toString(), 'desc': ''});
      }
    }
    return out;
  }

  List<String> _normalizeQuizzes(List<dynamic>? raw) {
    if (raw == null) return [];
    final List<String> out = [];
    for (var item in raw) {
      if (item == null) continue;
      if (item is String) {
        out.add(item);
      } else if (item is Map) {
        // try to extract question/title
        final q = (item['question'] ?? item['title'] ?? item['text'] ?? '').toString();
        if (q.isNotEmpty) out.add(q);
      } else {
        out.add(item.toString());
      }
    }
    return out;
  }
}
