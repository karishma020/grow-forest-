import 'package:flutter/material.dart';
import 'package:projects/ChatPage.dart';
import 'package:projects/ChatProvider.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';
import 'login_page.dart';
import 'start_tracking_page.dart';
import 'carbondashboard.dart';
import 'home_page.dart';
import 'tips_page.dart';
import 'challenges_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()), // Added
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(
              isDarkMode: themeProvider.isDarkMode,
              toggleTheme: (val) => themeProvider.toggleTheme(val),
            ),
        '/start': (context) => StartTrackingPage(
              toggleTheme: (val) => themeProvider.toggleTheme(val),
              isDarkMode: themeProvider.isDarkMode,
            ),
        '/dashboard': (context) => CarbonDashboard(),
        '/home': (context) => HomePage(),
        '/tips': (context) => TipsPage(),
        '/challenges': (context) => ChallengesPage(),
        '/chat': (context) => ChatPage(),
      },
    );
  }
}