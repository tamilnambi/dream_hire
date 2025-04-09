// widgets/job_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final textScaler = mediaQuery.textScaler;

    // Adjust sizes based on screen width
    final isSmallScreen = screenSize.width < 360;
    final logoSize = isSmallScreen ? 60.0 : 70.0;
    final horizontalPadding = screenSize.width * 0.04;
    final verticalPadding = screenSize.height * 0.01;

    // Text colors based on theme
    final primaryTextColor = isDarkMode ? Colors.white : AppColors.secondaryBlue;
    final secondaryTextColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.8)
        : AppColors.secondaryBlue.withValues(alpha: 0.7);
    final tertiaryTextColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.7)
        : AppColors.secondaryBlue.withValues(alpha: 0.6);

    // Card background color based on theme
    final cardBackgroundColor = isDarkMode
        ? Color(0xFF1E1E1E)
        : Colors.white;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: cardBackgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side - Company Logo
              _buildCompanyLogo(context, logoSize),

              SizedBox(width: horizontalPadding),

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
                              fontSize: textScaler.scale(16),
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
                            size: isSmallScreen ? 20 : 22,
                          ),
                          onPressed: onBookmarkTap,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          tooltip: isBookmarked ? 'Remove from bookmarks' : 'Add to bookmarks',
                        ),
                      ],
                    ),

                    Text(
                      job.companyName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: secondaryTextColor,
                        fontSize: textScaler.scale(14),
                      ),
                    ),

                    SizedBox(height: verticalPadding * 2),

                    // Additional info
                    Row(
                      children: [
                        _buildInfoChip(context, job.jobType, isDarkMode, textScaler),
                        SizedBox(width: horizontalPadding * 0.5),
                        Expanded(
                          child: Text(
                            job.candidateRequiredLocation,
                            style: TextStyle(
                              color: tertiaryTextColor,
                              fontSize: textScaler.scale(13),
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

  Widget _buildCompanyLogo(BuildContext context, double size) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: job.companyLogo != null && job.companyLogo!.isNotEmpty
            ? CachedNetworkImage(
          imageUrl: job.companyLogo!,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.business,
            size: size * 0.43, // Scale icon size relative to container
            color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue.withValues(alpha: 0.7),
          ),
        )
            : Icon(
          Icons.business,
          size: size * 0.43,
          color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String text, bool isDarkMode, TextScaler textScaler) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.primaryBlue.withValues(alpha: 0.2) : AppColors.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textScaler.scale(12),
          fontWeight: FontWeight.w500,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}