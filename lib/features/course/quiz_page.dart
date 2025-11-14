import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizPage extends StatefulWidget {
  final String title;

  final List<String> questions;

  const QuizPage({super.key, required this.title, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const Color kPurple = Color(0xFF4C39C7);
  static const Color kPurpleSoft = Color(0xFF7B61FF);
  static const Color kChipBg = Color(0xFFEBE9F6);
  static const Color kScaffold = Color(0xFFF6F7FB);

  final TextEditingController _answerCtrl = TextEditingController();
  late final List<String> _answers;
  int _idx = 0;

  @override
  void initState() {
    super.initState();
    _answers = List.filled(widget.questions.length, '');
    if (widget.questions.isNotEmpty) {
      _answerCtrl.text = _answers[_idx];
    }
  }

  @override
  void dispose() {
    _answerCtrl.dispose();
    super.dispose();
  }

  void _go(int delta) {
    if (widget.questions.isEmpty) return;
    _answers[_idx] = _answerCtrl.text.trim();

    final to = _idx + delta;
    if (to >= 0 && to < widget.questions.length) {
      setState(() {
        _idx = to;
        _answerCtrl.text = _answers[_idx];
      });
    }
  }

  void _submit() {
    if (widget.questions.isEmpty) return;
    _answers[_idx] = _answerCtrl.text.trim();

    // TODO: kirim ke backend jika diperlukan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Jawaban terkirim untuk soal ${_idx + 1}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int qTotal = widget.questions.length;

    if (qTotal == 0) {
      return Scaffold(
        backgroundColor: kScaffold,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _roundIcon(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _whiteCard(
                  child: Text(
                    'Belum ada soal untuk kuis ini.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final String cleanTitle = widget.title.replaceFirst('Quiz – ', '');
    final String qText = widget.questions[_idx];

    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _roundIcon(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cleanTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _whiteCard(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    _segmentedChip(label: 'Course Preview', active: true),
                    const SizedBox(width: 8),
                    Expanded(child: _timeChip('2hr 15min')),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: kPurpleSoft.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quiz Dasar Pecahan',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet',
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.help_outline,
                        color: kPurple,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 10,
                children: List.generate(qTotal, (i) {
                  final active = i == _idx;
                  return GestureDetector(
                    onTap: () {
                      _answers[_idx] = _answerCtrl.text.trim();
                      setState(() {
                        _idx = i;
                        _answerCtrl.text = _answers[_idx];
                      });
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: active ? kPurple : kChipBg,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${i + 1}',
                        style: GoogleFonts.poppins(
                          color: active
                              ? Colors.white
                              : const Color(0xFF6B6B7A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              _whiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quiz Dasar Pecahan',
                      style: GoogleFonts.poppins(
                        color: kPurple,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${_idx + 1}. $qText',
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              Text(
                'Tuliskan Jawaban!',
                style: GoogleFonts.poppins(
                  color: kPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFF3),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _answerCtrl,
                  minLines: 4,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Tulis Jawabanmu disini!',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _miniRound(
                    icon: Icons.keyboard_double_arrow_left,
                    onTap: () => _go(-1),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: kPurple,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${_idx + 1}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _miniRound(
                    icon: Icons.keyboard_double_arrow_right,
                    onTap: () => _go(1),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F2DB9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Send Answer!',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _whiteCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: padding ?? const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: child,
    );
  }

  Widget _roundIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFEDECF8),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: kPurple, size: 22),
      ),
    );
  }

  Widget _segmentedChip({required String label, bool active = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFF2F0FF) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9E7F6)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: active ? kPurple : const Color(0xFF6B6B7A),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _timeChip(String t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9E7F6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.schedule, size: 16, color: Color(0xFF6B6B7A)),
          const SizedBox(width: 6),
          Text(
            t,
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B6B7A),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniRound({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(color: kChipBg, shape: BoxShape.circle),
        child: Icon(icon, color: const Color(0xFF6B6B7A), size: 20),
      ),
    );
  }
}
