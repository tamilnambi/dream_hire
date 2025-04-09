import 'package:dream_hire/view/widgets/apply_job_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../core/bookmark/bookmark_bloc.dart';
import '../core/bookmark/bookmark_event.dart';
import '../models/job/job_model.dart';
import '../utils/app_colors.dart';

class JobDescriptionScreen extends StatelessWidget {
  final Job job;

  const JobDescriptionScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarkBloc = context.watch<BookmarkBloc>();
    final isBookmarked = job.isBookmarked || bookmarkBloc.isJobBookmarked(job.id);
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final textScaler = mediaQuery.textScaler;
    final horizontalPadding = screenSize.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: textScaler.scale(18),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? AppColors.primaryBlue : null,
              size: textScaler.scale(24),
            ),
            onPressed: () {
              if (isBookmarked) {
                context.read<BookmarkBloc>().add(RemoveBookmark(job.id));
              } else {
                context.read<BookmarkBloc>().add(BookmarkJob(job));
              }
            },
            tooltip: isBookmarked ? 'Remove from bookmarks' : 'Add to bookmarks',
          ),
          SizedBox(width: horizontalPadding * 0.3),
        ],
      ),
      body: _buildJobDescription(context),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: mediaQuery.padding.bottom > 0
              ? mediaQuery.padding.bottom
              : 16,
        ),
        child: ApplyJobButton(onPressed: () {
          // Implement apply action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Application process started'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildJobDescription(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;
    final screenSize = mediaQuery.size;
    final horizontalPadding = screenSize.width * 0.05;
    final verticalSpacing = screenSize.height * 0.015;

    // Determine if we're on a tablet or large screen
    final isLargeScreen = screenSize.width > 600;
    final maxContentWidth = isLargeScreen ? 600.0 : double.infinity;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Header
              _buildJobHeader(context),

              SizedBox(height: verticalSpacing * 1.5),

              // Job Details Section
              _buildJobDetailsSection(context),

              SizedBox(height: verticalSpacing * 1.5),

              // Tags
              _buildTagsSection(context),

              SizedBox(height: verticalSpacing),

              const Divider(thickness: 1),

              SizedBox(height: verticalSpacing),

              // Job Description
              Text(
                'Job Description',
                style: TextStyle(
                  fontSize: textScaler.scale(20),
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : AppColors.secondaryBlue,
                ),
              ),

              SizedBox(height: verticalSpacing * 0.8),

              // HTML Content
              Html(
                data: job.description,
                style: {
                  "body": Style(
                    fontSize: FontSize(textScaler.scale(16)),
                    color: isDarkMode ? Colors.white : Colors.black87,
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "h1, h2, h3, h4, h5, h6": Style(
                    color: isDarkMode ? Colors.white : AppColors.secondaryBlue,
                  ),
                  "li": Style(
                    margin: Margins.only(bottom: 8),
                  ),
                  "ul, ol": Style(
                    margin: Margins.only(bottom: 16, top: 8),
                  ),
                  "p": Style(
                    margin: Margins.only(bottom: 16),
                  ),
                  "a": Style(
                    color: AppColors.primaryBlue,
                  ),
                },
              ),

              // Extra space at bottom for the fixed apply button
              SizedBox(height: mediaQuery.padding.bottom + 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.title,
          style: TextStyle(
            fontSize: textScaler.scale(24),
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : AppColors.secondaryBlue,
          ),
        ),
        SizedBox(height: mediaQuery.size.height * 0.01),

        // Company info
        Row(
          children: [
            _buildCompanyLogo(context),
            SizedBox(width: mediaQuery.size.width * 0.03),
            Expanded(
              child: Text(
                job.companyName,
                style: TextStyle(
                  fontSize: textScaler.scale(18),
                  fontWeight: FontWeight.w500,
                  color: isDarkMode
                      ? Colors.white.withValues(alpha: 0.9)
                      : AppColors.secondaryBlue.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompanyLogo(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final logoSize = MediaQuery.of(context).size.width * 0.13; // Responsive logo size
    final logoSizeCapped = logoSize > 60 ? 60.0 : logoSize; // Cap maximum size

    return Container(
      width: logoSizeCapped,
      height: logoSizeCapped,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2A2A2A) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(logoSizeCapped * 0.2),
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
        borderRadius: BorderRadius.circular(logoSizeCapped * 0.2),
        child: job.companyLogoUrl != null && job.companyLogoUrl!.isNotEmpty
            ? CachedNetworkImage(
          imageUrl: job.companyLogoUrl!,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: logoSizeCapped * 0.4,
              height: logoSizeCapped * 0.4,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          errorWidget: (_, __, ___) => Icon(
            Icons.business,
            size: logoSizeCapped * 0.6,
            color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue.withValues(alpha: 0.7),
          ),
        )
            : Icon(
          Icons.business,
          size: logoSizeCapped * 0.6,
          color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _buildJobDetailsSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;
    final verticalSpacing = mediaQuery.size.height * 0.01;

    // Values for properties
    final textColor = isDarkMode ? Colors.white.withValues(alpha: 0.9) : Colors.black87;
    final labelColor = isDarkMode
        ? AppColors.primaryBlue.withValues(alpha: 0.9)
        : AppColors.secondaryBlue;

    Widget buildDetailItem(String label, String value) {
      return Padding(
        padding: EdgeInsets.only(bottom: verticalSpacing),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100 * textScaler.scale(1),  // Fixed width for labels
              child: Text(
                '$label: ',
                style: TextStyle(
                  fontSize: textScaler.scale(15),
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: textScaler.scale(15),
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.size.width * 0.04,
          vertical: mediaQuery.size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (job.salary != null) buildDetailItem('Salary', job.salary!),
            buildDetailItem('Location', job.candidateRequiredLocation),
            buildDetailItem('Job Type', job.jobType),
            buildDetailItem('Category', job.category),
            buildDetailItem('Posted on', job.publicationDate),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: TextStyle(
            fontSize: textScaler.scale(18),
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : AppColors.secondaryBlue,
          ),
        ),
        SizedBox(height: mediaQuery.size.height * 0.01),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: job.tags.map<Widget>((tag) =>
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.primaryBlue.withValues(alpha: 0.2)
                      : AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryBlue.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: textScaler.scale(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
          ).toList(),
        ),
      ],
    );
  }
}