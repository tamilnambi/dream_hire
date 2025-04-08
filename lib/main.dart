import 'package:dream_hire/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/api_service.dart';
import 'core/bookmark/bookmark_bloc.dart';
import 'core/job/job_bloc.dart';
import 'core/search/search_bloc.dart';
import 'core/theme/theme_bloc.dart';
import 'core/theme/theme_data.dart';
import 'core/theme/theme_state.dart';


void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => JobBloc(apiService: ApiService())),
        BlocProvider(create: (_) => BookmarkBloc()),
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DreamHire',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
