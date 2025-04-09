import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme_bloc.dart';
import '../../utils/app_colors.dart';

class ApplyJobButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ApplyJobButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final isDarkMode = context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark;
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;

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
            size: textScaler.scale(20),
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            'Apply for this Job',
            style: TextStyle(
              fontSize: textScaler.scale(16),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}