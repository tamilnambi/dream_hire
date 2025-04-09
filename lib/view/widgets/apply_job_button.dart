import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ApplyJobButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ApplyJobButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.send_outlined,
            size: 20 * textScaleFactor,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            'Apply for this Job',
            style: TextStyle(
              fontSize: 16 * textScaleFactor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}