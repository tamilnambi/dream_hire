// job_list_screen.dart with enhanced responsiveness
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
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isLandscape = size.width > size.height;
    final textScaleFactor = mediaQuery.textScaleFactor;

    // Calculate responsive values
    final headerHeight = size.height * (isLandscape ? 0.25 : 0.2);
    final logoSize = size.height * (isLandscape ? 0.2 : 0.15);
    final horizontalPadding = size.width * 0.02;
    final verticalPadding = size.height * 0.01;

    // Max width for content on larger screens
    final maxContentWidth = 700.0;

    // Responsive container for large screens
    Widget responsiveContainer(Widget child) {
      return size.width > maxContentWidth
          ? Center(
        child: SizedBox(
          width: maxContentWidth,
          child: child,
        ),
      )
          : child;
    }

    // Fetch jobs when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<JobBloc>().state is JobInitial) {
        context.read<JobBloc>().add(FetchJobs());
      }
    });

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: responsiveContainer(
          Column(
            children: [
              SizedBox(
                height: headerHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Find Your ',
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.white : Colors.black87,
                                        fontSize: 26 * textScaleFactor,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Dream',
                                      style: TextStyle(
                                        color: AppColors.primaryBlue,
                                        fontSize: 30 * textScaleFactor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primaryBlue,
                                      AppColors.secondaryBlue,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text(
                                  'JOB',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32 * textScaleFactor,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Hero(
                        tag: 'logo',
                        child: Image.asset(
                            'assets/images/logo.png',
                            height: logoSize
                        )
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<JobBloc, JobState>(
                  builder: (context, state) {
                    if (state is JobInitial || state is JobLoading) {
                      return _buildLoadingShimmer(isDarkMode, horizontalPadding, verticalPadding);
                    } else if (state is JobsLoaded) {
                      return _buildJobList(context, state.jobs, horizontalPadding, verticalPadding);
                    } else if (state is JobError) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
                                size: 48 * textScaleFactor,
                              ),
                              SizedBox(height: verticalPadding * 2),
                              Text(
                                'Error: ${state.message}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
                                  fontSize: 16 * textScaleFactor,
                                ),
                              ),
                              SizedBox(height: verticalPadding * 3),
                              ElevatedButton(
                                onPressed: () => context.read<JobBloc>().add(FetchJobs()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding,
                                    vertical: verticalPadding,
                                  ),
                                ),
                                child: Text(
                                  'Try Again',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16 * textScaleFactor,
                                  ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(bool isDarkMode, double horizontalPadding, double verticalPadding) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[600]! : Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 8, // Show 8 shimmer items while loading
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
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

  Widget _buildJobList(BuildContext context, List<Job> jobs, double horizontalPadding, double verticalPadding) {
    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;

    // Use grid layout for landscape on larger screens
    final isLandscape = mediaQuery.size.width > mediaQuery.size.height;
    final isLargeScreen = mediaQuery.size.width > 600;

    if (isLandscape && isLargeScreen) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
          crossAxisSpacing: horizontalPadding,
          mainAxisSpacing: verticalPadding,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return _buildJobItem(context, jobs[index], textScaleFactor);
        },
      );
    }

    return Scrollbar(
      child: ListView.builder(
        itemCount: jobs.length,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: _buildJobItem(context, jobs[index], textScaleFactor),
          );
        },
      ),
    );
  }

  Widget _buildJobItem(BuildContext context, Job job, double textScaleFactor) {
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
  }
}