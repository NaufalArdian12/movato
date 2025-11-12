import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizPage extends StatefulWidget {
  final String title;
  final List<String> questions;

  const QuizPage({
    super.key,
    required this.title,
    required this.questions,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _controller = TextEditingController();
  int _index = 0;
  late final List<String> _answers;

  @override
  void initState() {
    super.initState();
    _answers = List.filled(widget.questions.length, '');
  }

  void _next() {
    _answers[_index] = _controller.text.trim();
    if (_index < widget.questions.length - 1) {
      setState(() {
        _index++;
        _controller.text = _answers[_index];
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _prev() {
    if (_index == 0) return;
    setState(() {
      _index--;
      _controller.text = _answers[_index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_index];
    return Scaffold(
      appBar: AppBar(title: Text(widget.title, style: GoogleFonts.poppins())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Soal ${_index + 1} dari ${widget.questions.length}',
                style: GoogleFonts.poppins(color: Colors.grey[700])),
            const SizedBox(height: 8),
            Text(q,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tulis jawabanmu...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child:
                        OutlinedButton(onPressed: _prev, child: const Text('Sebelumnya'))),
                const SizedBox(width: 12),
                Expanded(
                    child: ElevatedButton(
                        onPressed: _next,
                        child: Text(
                            _index == widget.questions.length - 1 ? 'Selesai' : 'Berikutnya'))),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF6F7FB),
    );
  }
}
