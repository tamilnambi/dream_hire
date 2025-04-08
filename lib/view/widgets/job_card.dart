// widgets/job_card.dart
import 'package:flutter/material.dart';

import '../../models/job/job_model.dart';
import '../../utils/app_colors.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final VoidCallback onTap;

  const JobCard({
    Key? key,
    required this.job,
    required this.isBookmarked,
    required this.onBookmarkTap,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Text colors based on theme
    final primaryTextColor = isDarkMode ? Colors.white : AppColors.secondaryBlue;
    final secondaryTextColor = isDarkMode
        ? Colors.white.withOpacity(0.8)
        : AppColors.secondaryBlue.withOpacity(0.8);
    final tertiaryTextColor = isDarkMode
        ? Colors.white.withOpacity(0.7)
        : AppColors.secondaryBlue.withOpacity(0.7);

    // Icon colors based on theme
    final primaryIconColor = isDarkMode ? Colors.white : AppColors.secondaryBlue;
    final accentIconColor = AppColors.primaryBlue;

    // Card background color based on theme
    final cardBackgroundColor = isDarkMode
        ? Color(0xFF1E1E1E)
        : Colors.white;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardBackgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primaryTextColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          job.companyName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: secondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildCompanyLogo(context, primaryIconColor),
                ],
              ),
              const SizedBox(height: 12),
              _buildJobInfoRow(context, Icons.work, job.jobType, accentIconColor, tertiaryTextColor),
              const SizedBox(height: 6),
              _buildJobInfoRow(context, Icons.location_on, job.candidateRequiredLocation, accentIconColor, tertiaryTextColor),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? AppColors.primaryBlue : primaryIconColor,
                    ),
                    onPressed: onBookmarkTap,
                    tooltip: isBookmarked ? 'Remove from bookmarks' : 'Add to bookmarks',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyLogo(BuildContext context, Color iconColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: job.companyLogo != null
            ? Image.network(
          job.companyLogo!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(
            Icons.business,
            color: iconColor,
          ),
        )
            : Icon(
          Icons.business,
          color: iconColor,
        ),
      ),
    );
  }

  Widget _buildJobInfoRow(BuildContext context, IconData icon, String text, Color iconColor, Color textColor) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}