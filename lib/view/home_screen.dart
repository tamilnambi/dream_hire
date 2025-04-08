import 'package:dream_hire/view/job_search_screen.dart';
import 'package:dream_hire/view/profile_screen.dart';
import 'package:dream_hire/view/saved_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: PageView(
        controller: controller,
        children: [
          JobListScreen(),
          JobSearchScreen(),
          SavedJobsScreen(),
          const ProfileScreen()
        ],
      )),
      bottomNavigationBar: StylishBottomBar(items: [
        BottomBarItem(
          icon: const Icon(Icons.house_outlined),
          selectedIcon: const Icon(Icons.house_rounded),
          selectedColor: AppColors.primaryBlue,
          unSelectedColor: Colors.grey,
          title: const Text('Home'),
        ),
        BottomBarItem(
          icon: const Icon(Icons.search),
          selectedIcon: const Icon(Icons.search),
          selectedColor: AppColors.primaryBlue,
          unSelectedColor: Colors.grey,
          title: const Text('Search'),
        ),
        BottomBarItem(
          icon: const Icon(Icons.save),
          selectedIcon: const Icon(Icons.save),
          selectedColor: AppColors.primaryBlue,
          unSelectedColor: Colors.grey,
          title: const Text('Saved Jobs'),
        ),
        BottomBarItem(
          icon: const Icon(Icons.person),
          selectedIcon: const Icon(Icons.person),
          selectedColor: AppColors.primaryBlue,
          unSelectedColor: Colors.grey,
          title: const Text('Profile'),
        ),
      ],
        option: AnimatedBarOptions(
          // iconSize: 32,
          // barAnimation: BarAnimation.liquid,
          iconStyle: IconStyle.animated,

          // opacity: 0.3,
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
