import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    this.text = 'Continue with Google',
    required this.onPressed,
    this.isBusy = false,
    this.filled = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isBusy;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    const double radius = 16;
    const double vPad = 12;
    const borderColor = Color(0xFFE4E4E7);

    final bgColor = filled ? Colors.black : Colors.white;
    final fgColor = filled ? Colors.white : Colors.black87;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: isBusy ? 0.7 : 1,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            if (!isBusy) onPressed();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: vPad, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: filled ? Colors.transparent : borderColor,
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: isBusy
                      ? SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/images/google.svg',
                          width: 18,
                          height: 18,
                        ),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ).copyWith(color: fgColor),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(width: 18, height: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
