import 'package:dream_hire/view/job_search_screen.dart';
import 'package:dream_hire/view/profile_screen.dart';
import 'package:dream_hire/view/saved_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../core/theme/theme_bloc.dart';
import '../utils/app_colors.dart';
import 'job_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController();
  int selected = 0;

  @override
  void initState() {
    super.initState();
    // Add listener to update selected index when page changes
    controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onPageChanged);
    controller.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    if (!controller.hasClients) return;

    final page = controller.page?.round() ?? 0;
    if (page != selected) {
      setState(() {
        selected = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme
    final isDarkMode = context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark;
    final primaryColor = !isDarkMode
        ? AppColors.primaryBlue
        : Colors.white;
    final unselectedColor = isDarkMode ? Colors.grey[400] : Colors.grey;

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller,
          // Optional: if you want to disable swiping
          // physics: const NeverScrollableScrollPhysics(),
          children: const [
            JobListScreen(),
            JobSearchScreen(),
            SavedJobsScreen(),
            ProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: [
          BottomBarItem(
            icon: const Icon(Icons.house_outlined),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor: primaryColor,
            unSelectedColor: unselectedColor!,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            selectedIcon: const Icon(Icons.search),
            selectedColor: primaryColor,
            unSelectedColor: unselectedColor,
            title: const Text('Search'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.save_outlined),
            selectedIcon: const Icon(Icons.save),
            selectedColor: primaryColor,
            unSelectedColor: unselectedColor,
            title: const Text('Saved Jobs'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            selectedColor: primaryColor,
            unSelectedColor: unselectedColor,
            title: const Text('Profile'),
          ),
        ],
        option: AnimatedBarOptions(
          iconStyle: IconStyle.animated,
        ),
        currentIndex: selected,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}