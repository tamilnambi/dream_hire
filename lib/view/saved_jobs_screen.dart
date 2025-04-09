import 'package:dream_hire/view/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/bookmark/bookmark_bloc.dart';
import '../core/bookmark/bookmark_event.dart';
import '../core/bookmark/bookmark_state.dart';
import '../models/job/job_model.dart';
import '../utils/app_colors.dart';
import 'job_description_screen.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;
    final screenSize = mediaQuery.size;
    final horizontalPadding = screenSize.width * 0.04;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Saved Jobs',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: textScaler.scale(18),
            color: isDarkMode ? Colors.white : Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryBlue,
        elevation: isDarkMode ? 0 : 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkInitial || state is BookmarkLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryBlue,
              ),
            );
          } else if (state is BookmarksLoaded) {
            if (state.bookmarkedJobs.isEmpty) {
              return _buildEmptyState(context, isDarkMode);
            }
            return _buildBookmarkedJobsList(
                context,
                state.bookmarkedJobs,
                horizontalPadding
            );
          } else if (state is BookmarkError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: textScaler.scale(48),
                      color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: textScaler.scale(16),
                        color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDarkMode) {
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;
    final screenSize = mediaQuery.size;
    final horizontalPadding = screenSize.width * 0.08;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: textScaler.scale(64),
              color: isDarkMode ? Colors.white.withValues(alpha: 0.54) : Colors.grey,
            ),
            SizedBox(height: screenSize.height * 0.02),
            Text(
              'No saved jobs yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textScaler.scale(18),
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text(
              'Bookmark jobs to view them here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textScaler.scale(14),
                color: isDarkMode ? Colors.white.withValues(alpha: 0.54) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkedJobsList(
      BuildContext context,
      List<Job> jobs,
      double horizontalPadding,
      ) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;

    // Determine if we're on a tablet or large screen
    final isLargeScreen = screenSize.width > 600;
    final maxContentWidth = isLargeScreen ? 600.0 : double.infinity;

    // Calculate spacing between cards
    final verticalSpacing = screenSize.height * 0.012;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: ListView.separated(
          itemCount: jobs.length,
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.016,
            //horizontal: horizontalPadding,
          ),
          separatorBuilder: (context, index) => SizedBox(height: verticalSpacing),
          itemBuilder: (context, index) {
            final job = jobs[index];

            return Dismissible(
              key: Key('job_${job.id}'),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: screenSize.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                context.read<BookmarkBloc>().add(RemoveBookmark(job.id));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${job.title} removed from bookmarks'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                      bottom: screenSize.height * 0.02,
                      left: horizontalPadding,
                      right: horizontalPadding,
                    ),
                  ),
                );
              },
              child: JobCard(
                job: job,
                isBookmarked: true,
                onBookmarkTap: () {
                  context.read<BookmarkBloc>().add(RemoveBookmark(job.id));
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDescriptionScreen(job: job),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}