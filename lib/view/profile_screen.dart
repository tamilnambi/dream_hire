import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/theme_bloc.dart';
import '../core/theme/theme_event.dart';
import '../utils/app_colors.dart'; // Update with your actual path

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   centerTitle: true,
      //   actions: [
      //     Switch(
      //       value: isDarkMode,
      //       onChanged: (_) {
      //         context.read<ThemeBloc>().add(ToggleThemeEvent());
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(height: 180),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Switch(
                    value: isDarkMode,
                    onChanged: (_) =>
                        context.read<ThemeBloc>().add(ToggleThemeEvent()),
                    activeColor: Colors.amber, // For light theme toggle color
                    inactiveThumbColor: Colors.blueGrey, // For dark theme thumb
                    inactiveTrackColor: Colors.white,
                    thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                          (Set<MaterialState> states) {
                        if (isDarkMode) {
                          return const Icon(Icons.nightlight_round, color: Colors.black);
                        } else {
                          return const Icon(Icons.wb_sunny, color: Colors.yellow);
                        }
                      },
                    ),
                  ),
                ),
                 CircleAvatar(
                   backgroundColor: Colors.white,
                  radius: 50,
                  child: Icon(Icons.person, color: AppColors.primaryBlue, size: 50),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          _buildOption(context, icon: Icons.person, title: 'My Profile'),
          _buildOption(context, icon: Icons.settings, title: 'App Settings'),
          _buildOption(context, icon: Icons.feedback, title: 'Feedback'),
          _buildOption(context, icon: Icons.info, title: 'About Us'),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, {required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Coming Soon')),
        );
      },
    );
  }
}
