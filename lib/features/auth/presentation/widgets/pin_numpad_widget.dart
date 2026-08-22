import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PinNumPadWidget extends StatelessWidget {
  final Function(String) onDigitPress;
  final VoidCallback onDeletePress;

  const PinNumPadWidget({
    super.key,
    required this.onDigitPress,
    required this.onDeletePress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 16),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 16),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 16),
        _buildBottomRow(),
      ],
    );
  }

  Widget _buildRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) => _buildButton(digit)).toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 75, height: 75),
        _buildButton('0'),
        SizedBox(
          width: 75,
          height: 75,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onDeletePress,
              child: const Center(
                child: Icon(Icons.backspace_outlined, size: 28, color: AppColors.textPrimary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: 75,
      height: 75,
      child: Material(
        color: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.06),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => onDigitPress(text),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}