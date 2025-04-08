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
        : AppColors.secondaryBlue.withOpacity(0.7);
    final tertiaryTextColor = isDarkMode
        ? Colors.white.withOpacity(0.7)
        : AppColors.secondaryBlue.withOpacity(0.6);

    // Card background color based on theme
    final cardBackgroundColor = isDarkMode
        ? Color(0xFF1E1E1E)
        : Colors.white;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: cardBackgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side - Company Logo
              _buildCompanyLogo(context),

              const SizedBox(width: 16),

              // Right side - Job Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            job.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? AppColors.primaryBlue : primaryTextColor,
                            size: 22,
                          ),
                          onPressed: onBookmarkTap,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          tooltip: isBookmarked ? 'Remove from bookmarks' : 'Add to bookmarks',
                        ),
                      ],
                    ),

                    Text(
                      job.companyName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: secondaryTextColor,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Additional info
                    Row(
                      children: [
                        _buildInfoChip(context, job.jobType, isDarkMode),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            job.candidateRequiredLocation,
                            style: TextStyle(
                              color: tertiaryTextColor,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyLogo(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2A2A2A) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: job.companyLogo != null
            ? Image.network(
          job.companyLogo!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(
            Icons.business,
            size: 30,
            color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue.withOpacity(0.7),
          ),
        )
            : Icon(
          Icons.business,
          size: 30,
          color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String text, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.primaryBlue.withOpacity(0.2) : AppColors.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}