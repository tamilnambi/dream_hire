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
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 1024;

    return BlocProvider(
      create: (context) => SearchBloc(apiService: ApiService()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: _buildAppBar(context, isDarkMode, isTablet, isDesktop),
            body: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive layout based on screen width
                double horizontalPadding =
                    isDesktop
                        ? constraints.maxWidth * 0.15
                        : isTablet
                        ? 24.0
                        : 16.0;
                double verticalPadding =
                    isDesktop
                        ? constraints.maxHeight * 0.05
                        : isTablet
                        ? 16.0
                        : 8.0;

                return Column(
                  children: [
                    _buildSearchBar(context, isDarkMode, horizontalPadding),
                    Expanded(
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchInitial) {
                            return _buildSearchInitial(isDarkMode);
                          } else if (state is SearchLoading) {
                            return _buildLoadingShimmer(
                              isDarkMode,
                              isTablet,
                              isDesktop,
                            );
                          } else if (state is SearchLoaded) {
                            return state.jobs.isEmpty
                                ? _buildNoResults(
                                  context,
                                  state.query,
                                  isDarkMode,
                                )
                                : _buildSearchResults(
                                  context,
                                  state.jobs,
                                  verticalPadding,
                                );
                          } else if (state is SearchError) {
                            return _buildErrorState(
                              context,
                              state.message,
                              isDarkMode,
                            );
                          }
                          return const Center(child: Text('Unknown state'));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    bool isDarkMode,
    bool isTablet,
    bool isDesktop,
  ) {
    return AppBar(
      title: Row(
        children: [
          Icon(Icons.work, color: Colors.white, size: isTablet ? 36 : 30),
          const SizedBox(width: 12),
          Text(
            'DreamHire',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 22 : 18,
            ),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor:
          _isScrolled
              ? AppColors.primaryBlue
              : AppColors.primaryBlue.withValues(alpha: 0.95),
      elevation: _isScrolled ? 4 : 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryBlue.withValues(alpha: 0.4),
                AppColors.secondaryBlue.withValues(alpha: 0.2),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 4,
        ),
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    bool isDarkMode,
    double horizontalPadding,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(horizontalPadding, 20, horizontalPadding, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: isDarkMode ? Colors.grey.shade800 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Search for remote jobs...',
                    hintStyle: TextStyle(
                      color:
                          isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color:
                          isDarkMode
                              ? Colors.grey.shade400
                              : AppColors.primaryBlue.withValues(alpha: 0.7),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      final query = _searchController.text.trim();
                      if (query.isNotEmpty) {
                        context.read<SearchBloc>().add(SearchJobs(query));
                        _searchFocusNode.unfocus();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color:
                      isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
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
        ),
      ),
    );
  }

  Widget _buildSearchInitial(bool isDarkMode) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.search,
                size: 80,
                color:
                    isDarkMode
                        ? AppColors.primaryBlue.withValues(alpha: 0.7)
                        : AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Find Your Dream Remote Job',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Enter keywords like "front end", "java", "flutter" etc. to search for jobs that match your skills and interests.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildSuggestionChip(context, 'Java', isDarkMode),
                _buildSuggestionChip(context, 'Flutter', isDarkMode),
                _buildSuggestionChip(context, 'React', isDarkMode),
                _buildSuggestionChip(context, 'Full Stack', isDarkMode),
                _buildSuggestionChip(context, 'DevOps', isDarkMode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(
    BuildContext context,
    String label,
    bool isDarkMode,
  ) {
    return InkWell(
      onTap: () {
        _searchController.text = label;
        context.read<SearchBloc>().add(SearchJobs(label));
      },
      child: Chip(
        label: Text(label),
        backgroundColor:
            isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.white : Colors.grey.shade800,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  Widget _buildNoResults(BuildContext context, String query, bool isDarkMode) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.search_off,
                size: 80,
                color:
                    isDarkMode
                        ? Colors.orange.withValues(alpha: 0.7)
                        : Colors.orange,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No jobs found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'We couldn\'t find any jobs matching "$query"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    String message,
    bool isDarkMode,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isDarkMode
                      ? Colors.red.shade900.withValues(alpha: 0.3)
                      : Colors.red.shade50,
            ),
            padding: const EdgeInsets.all(24),
            child: Icon(
              Icons.error_outline,
              size: 64,
              color: isDarkMode ? Colors.red.shade300 : Colors.red,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              final query = _searchController.text.trim();
              if (query.isNotEmpty) {
                context.read<SearchBloc>().add(SearchJobs(query));
              }
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer(bool isDarkMode, bool isTablet, bool isDesktop) {
    // Calculate number of cards per row based on screen size
    int crossAxisCount =
        isDesktop
            ? 3
            : isTablet
            ? 2
            : 1;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[600]! : Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isDesktop
                  ? 48
                  : isTablet
                  ? 24
                  : 16,
          vertical: 8,
        ),
        child:
            isTablet || isDesktop
                ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 12, // Show more shimmer items for larger screens
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder:
                      (_, __) => Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                )
                : ListView.builder(
                  itemCount: 6, // Show 6 shimmer items while loading on mobile
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder:
                      (_, __) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[800] : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                ),
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    List<Job> jobs,
    double verticalPadding,
  ) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 1024;

    // Calculate number of cards per row based on screen size
    int crossAxisCount =
        isDesktop
            ? 3
            : isTablet
            ? 2
            : 1;

    return isTablet || isDesktop
        ? GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.5, // Adjust this for card size
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: jobs.length,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          itemBuilder: (context, index) {
            final job = jobs[index];
            final bookmarkBloc = context.watch<BookmarkBloc>();
            final isBookmarked = bookmarkBloc.isJobBookmarked(job.id);

            return JobCard(
              job: job,
              isBookmarked: isBookmarked,
              onBookmarkTap: () {
                if (isBookmarked) {
                  context.read<BookmarkBloc>().add(
                    RemoveBookmark(job.id),
                  );
                } else {
                  context.read<BookmarkBloc>().add(BookmarkJob(job));
                }
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => JobDescriptionScreen(
                          job: job.copyWith(isBookmarked: isBookmarked),
                        ),
                  ),
                );
              },
            );
          },
        )
        : ListView.builder(
          controller: _scrollController,
          itemCount: jobs.length,
          padding:  EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: 8,
          ),
          itemBuilder: (context, index) {
            final job = jobs[index];
            final bookmarkBloc = context.watch<BookmarkBloc>();
            final isBookmarked = bookmarkBloc.isJobBookmarked(job.id);

            return Padding(
              padding:  EdgeInsets.symmetric(vertical: verticalPadding),
              child: JobCard(
                job: job,
                isBookmarked: isBookmarked,
                onBookmarkTap: () {
                  if (isBookmarked) {
                    context.read<BookmarkBloc>().add(
                      RemoveBookmark(job.id),
                    );
                  } else {
                    context.read<BookmarkBloc>().add(BookmarkJob(job));
                  }
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => JobDescriptionScreen(
                            job: job.copyWith(isBookmarked: isBookmarked),
                          ),
                    ),
                  );
                },
              ),
            );
          },
        );
  }
}
