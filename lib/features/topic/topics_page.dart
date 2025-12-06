// lib/features/topic/topics_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movato/src/core/widgets/course_card.dart'; // pakai card lama
import 'package:movato/features/topic/topic_detail_page.dart';
import 'package:movato/src/di/providers.dart';
import 'models/topic.dart';

class TopicsPage extends ConsumerWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ambil semua topic (tanpa filter) -> pass null
    final asyncTopics = ref.watch(topicsListProvider(null));

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
                  "Let's Learn New Topic!",
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
              child: asyncTopics.when(
                data: (topics) {
                  if (topics.isEmpty) {
                    return const Center(child: Text('Belum ada topik'));
                  }
                  return Column(
                    children: topics.map((t) {
                      return _buildTopicCard(context, t);
                    }).toList(),
                  );
                },
                loading: () => const Center(child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: CircularProgressIndicator(),
                )),
                error: (err, stack) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: Text('Error: ${err.toString()}')),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, Topic t) {
    return CourseCard(
      title: t.title,
      desc: t.description ?? '-',
      progress: 0.0, // jika punya progress API, ganti dari sana
      image: 'assets/images/class4.jpg', // replace kalau API punya image
      onLearnMore: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TopicDetailPage(topicId: t.id),
          ),
        );
      },
    );
  }
}
