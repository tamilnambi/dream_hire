// job_list_screen.dart without local BlocProvider
import 'package:dream_hire/view/saved_jobs_screen.dart';
import 'package:dream_hire/view/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../core/bookmark/bookmark_bloc.dart';
import '../core/bookmark/bookmark_event.dart';
import '../core/job/job_bloc.dart';
import '../core/job/job_event.dart';
import '../core/job/job_state.dart';
import '../models/job/job_model.dart';
import '../utils/app_colors.dart';
import 'job_description_screen.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Fetch jobs when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<JobBloc>().state is JobInitial) {
        context.read<JobBloc>().add(FetchJobs());
      }
    });

    return Scaffold(
      // Use theme's scaffoldBackgroundColor instead of hardcoding white
      backgroundColor: theme.scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: Text(
      //     'Remote Jobs',
      //     style: TextStyle(
      //         color: isDarkMode ? Colors.white : Colors.white,
      //         fontWeight: FontWeight.bold
      //     ),
      //   ),
      //   backgroundColor: AppColors.primaryBlue,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.bookmark, color: Colors.white),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const SavedJobsScreen(),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobInitial || state is JobLoading) {
            return _buildLoadingShimmer(isDarkMode);
          } else if (state is JobsLoaded) {
            return _buildJobList(context, state.jobs);
          } else if (state is JobError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(
                        color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.read<JobBloc>().add(FetchJobs()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                    ),
                    child: const Text('Try Again', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<JobBloc>().add(FetchJobs()),
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildLoadingShimmer(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[600]! : Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 8, // Show 8 shimmer items while loading
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobList(BuildContext context, List<Job> jobs) {
    return ListView.builder(
      itemCount: jobs.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final job = jobs[index];
        final bookmarkBloc = context.watch<BookmarkBloc>();
        final isBookmarked = bookmarkBloc.isJobBookmarked(job.id);

        return JobCard(
          job: job,
          isBookmarked: isBookmarked,
          onBookmarkTap: () {
            if (isBookmarked) {
              context.read<BookmarkBloc>().add(RemoveBookmark(job.id));
            } else {
              context.read<BookmarkBloc>().add(BookmarkJob(job));
            }
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDescriptionScreen(
                  job: job.copyWith(isBookmarked: isBookmarked),
                ),
              ),
            );
          },
        );
      },
    );
  }
}