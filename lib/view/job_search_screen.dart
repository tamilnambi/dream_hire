import 'package:dream_hire/view/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../core/api_service.dart';
import '../core/bookmark/bookmark_bloc.dart';
import '../core/bookmark/bookmark_event.dart';
import '../core/search/search_bloc.dart';
import '../core/search/search_event.dart';
import '../core/search/search_state.dart';
import '../models/job/job_model.dart';
import '../utils/app_colors.dart';
import 'job_description_screen.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => SearchBloc(apiService: ApiService()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            // appBar: AppBar(
            //   title: const Text(
            //     'Search Jobs',
            //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            //   backgroundColor: AppColors.primaryBlue,
            //   elevation: 0,
            // ),
            body: Column(
              children: [
                _buildSearchBar(context, isDarkMode),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return _buildSearchInitial(isDarkMode);
                      } else if (state is SearchLoading) {
                        return _buildLoadingShimmer(isDarkMode);
                      } else if (state is SearchLoaded) {
                        return state.jobs.isEmpty
                            ? _buildNoResults(context, state.query, isDarkMode)
                            : _buildSearchResults(context, state.jobs);
                      } else if (state is SearchError) {
                        return _buildErrorState(context, state.message, isDarkMode);
                      }
                      return const Center(child: Text('Unknown state'));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search jobs...',
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryBlue,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                filled: true,
                fillColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<SearchBloc>().add(SearchJobs(value));
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                final query = _searchController.text.trim();
                if (query.isNotEmpty) {
                  context.read<SearchBloc>().add(SearchJobs(query));
                  _searchFocusNode.unfocus();
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
              ),
              onPressed: () {
                _searchController.clear();
                context.read<SearchBloc>().add(ClearSearch());
                _searchFocusNode.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInitial(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Search for remote jobs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Enter keywords like "front end", "java", "flutter" etc.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults(BuildContext context, String query, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No jobs found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'We couldn\'t find any jobs matching "$query"',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              context.read<SearchBloc>().add(ClearSearch());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Clear Search',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, bool isDarkMode) {
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
            'Error: $message',
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : AppColors.secondaryBlue,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final query = _searchController.text.trim();
              if (query.isNotEmpty) {
                context.read<SearchBloc>().add(SearchJobs(query));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[600]! : Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6, // Show 6 shimmer items while loading
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, List<Job> jobs) {
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