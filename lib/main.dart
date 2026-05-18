import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/landing_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebase not configured — email collection will be unavailable
  }
  runApp(const YourDaysApp());
}

class YourDaysApp extends StatelessWidget {
  const YourDaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Days — Mood Tracking & Journaling',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const LandingScreen(),
    );
  }
}
