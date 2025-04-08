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

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: const Text(
      //     'Saved Jobs',
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: AppColors.primaryBlue,
      //   elevation: 0,
      // ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkInitial || state is BookmarkLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookmarksLoaded) {
            if (state.bookmarkedJobs.isEmpty) {
              return _buildEmptyState(context, isDarkMode);
            }
            return _buildBookmarkedJobsList(context, state.bookmarkedJobs);
          } else if (state is BookmarkError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: isDarkMode ? Colors.white54 : Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No saved jobs yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bookmark jobs to view them here',
            style: TextStyle(
              color: isDarkMode ? Colors.white54 : Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text(
              'Browse Jobs',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkedJobsList(BuildContext context, List<Job> jobs) {
    return ListView.builder(
      itemCount: jobs.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final job = jobs[index];

        return Dismissible(
          key: Key('job_${job.id}'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) {
            context.read<BookmarkBloc>().add(RemoveBookmark(job.id));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${job.title} removed from bookmarks'),
                behavior: SnackBarBehavior.floating,
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
    );
  }
}