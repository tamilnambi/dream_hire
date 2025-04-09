import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/theme_bloc.dart';
import '../core/theme/theme_event.dart';
import '../utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 30 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 30 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 1024;

    // Calculate responsive dimensions
    final double headerHeight = isDesktop ? 300 : isTablet ? 250 : 200;
    final double avatarRadius = isDesktop ? 70 : isTablet ? 60 : 50;
    final double horizontalPadding = isDesktop ? size.width * 0.15 : isTablet ? 32.0 : 16.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_isScrolled ? kToolbarHeight : 0),
        child: AnimatedOpacity(
          opacity: _isScrolled ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: isDarkMode
                ? Colors.black.withValues(alpha: 0.7)
                : AppColors.primaryBlue,
            elevation: 0,
            title: const Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: false,
            actions: [
              Switch(
                value: isDarkMode,
                onChanged: (_) => context.read<ThemeBloc>().add(ToggleThemeEvent()),
                activeColor: Colors.amber,
                inactiveThumbColor: Colors.blueGrey,
                inactiveTrackColor: Colors.white,
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                      (Set<WidgetState> states) {
                    if (isDarkMode) {
                      return const Icon(Icons.nightlight_round, color: Colors.black);
                    } else {
                      return const Icon(Icons.wb_sunny, color: Colors.yellow);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Header section with avatar
          SliverToBoxAdapter(
            child: _buildHeader(
              context,
              isDarkMode,
              headerHeight,
              avatarRadius,
              isTablet,
              isDesktop,
            ),
          ),

          // Content section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // User name and stats
                _buildUserInfo(context, isDarkMode, isTablet),

                const SizedBox(height: 16),

                // Options section (wrapped in a Card for better styling)
                Card(
                  color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        _buildOption(
                          context,
                          icon: Icons.person,
                          title: 'My Profile',
                          subtitle: 'View and edit your profile information',
                          isTablet: isTablet,
                        ),
                        _buildDivider(),
                        _buildOption(
                          context,
                          icon: Icons.settings,
                          title: 'App Settings',
                          subtitle: 'Customize app behavior and notifications',
                          isTablet: isTablet,
                        ),
                        _buildDivider(),
                        _buildOption(
                          context,
                          icon: Icons.bookmark,
                          title: 'Saved Jobs',
                          subtitle: 'View your bookmarked jobs',
                          isTablet: isTablet,
                        ),
                        _buildDivider(),
                        _buildOption(
                          context,
                          icon: Icons.history,
                          title: 'Application History',
                          subtitle: 'Track your job applications',
                          isTablet: isTablet,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Support section
                Card(
                  color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        _buildOption(
                          context,
                          icon: Icons.help,
                          title: 'Help & Support',
                          subtitle: 'Get assistance and answers to questions',
                          isTablet: isTablet,
                        ),
                        _buildDivider(),
                        _buildOption(
                          context,
                          icon: Icons.feedback,
                          title: 'Send Feedback',
                          subtitle: 'Help us improve your experience',
                          isTablet: isTablet,
                        ),
                        _buildDivider(),
                        _buildOption(
                          context,
                          icon: Icons.info,
                          title: 'About Us',
                          subtitle: 'Learn more about DreamHire',
                          isTablet: isTablet,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Sign out button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Sign out logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign Out functionality coming soon')),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.red.shade50,
                      foregroundColor: isDarkMode ? Colors.white : Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                // Footer with version info
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'DreamHire v1.0.0',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context,
      bool isDarkMode,
      double height,
      double avatarRadius,
      bool isTablet,
      bool isDesktop,
      ) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [
            Colors.blueGrey.shade900,
            Colors.blueGrey.shade800,
            Colors.grey.shade900,
          ]
              : [
            AppColors.primaryBlue,
            AppColors.primaryBlue.withValues(alpha: 0.8),
            AppColors.secondaryBlue,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.blue.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Theme toggle switch
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.blueGrey.shade800.withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: isDarkMode,
                      onChanged: (_) => context.read<ThemeBloc>().add(ToggleThemeEvent()),
                      activeColor: Colors.amber,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.blue.shade300,
                      thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                            (Set<WidgetState> states) {
                          if (isDarkMode) {
                            return const Icon(Icons.nightlight_round, color: Colors.black, size: 16);
                          } else {
                            return const Icon(Icons.wb_sunny, color: Colors.yellow, size: 16);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Avatar
            Positioned(
              bottom: 0,
              child: Transform.translate(
                offset: Offset(0, avatarRadius / 2),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? Colors.black26
                            : Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.blue.shade50,
                    radius: avatarRadius,
                    child: Icon(
                      Icons.person,
                      color: AppColors.primaryBlue,
                      size: avatarRadius,
                    ),
                  ),
                ),
              ),
            ),

            // Upload photo icon
            Positioned(
              bottom: 0,
              right: isDesktop ? size.width / 2 - avatarRadius + 10 : null,
              child: Transform.translate(
                offset: Offset(isDesktop ? 0 : avatarRadius / 2, avatarRadius / 3),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.blueGrey.shade700 : AppColors.primaryBlue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: isTablet ? 24 : 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, bool isDarkMode, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.only(top: 56, bottom: 8),
      child: Column(
        children: [
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: isTablet ? 28 : 22,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'johndoe@example.com',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),

          // Stats row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(
                  context,
                  '24',
                  'Applications',
                  isDarkMode,
                  isTablet,
                ),
                _buildVerticalDivider(isDarkMode),
                _buildStatItem(
                  context,
                  '12',
                  'Bookmarks',
                  isDarkMode,
                  isTablet,
                ),
                _buildVerticalDivider(isDarkMode),
                _buildStatItem(
                  context,
                  '3',
                  'Interviews',
                  isDarkMode,
                  isTablet,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context,
      String value,
      String label,
      bool isDarkMode,
      bool isTablet,
      ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 14 : 12,
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(bool isDarkMode) {
    return Container(
      height: 36,
      width: 1,
      color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 64,
      endIndent: 16,
    );
  }

  Widget _buildOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required bool isTablet,
      }) {
    final isDarkMode = context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: isTablet ? 8 : 4,
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade800 : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primaryBlue,
          size: isTablet ? 28 : 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: isTablet ? 18 : 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: isTablet ? 14 : 12,
          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
        ),
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coming Soon')),
        );
      },
    );
  }
}