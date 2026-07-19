import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'theme/app_colors.dart';

class AapkeLawyerApp extends StatelessWidget {
  const AapkeLawyerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aapke Lawyer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kBrown),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          hintStyle: const TextStyle(color: kHint, fontSize: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: kBorder, width: 1.4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: kBrown, width: 1.8),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
