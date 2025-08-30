import 'package:flutter/material.dart';
import 'profile_overview_page.dart'; // Make sure this path is correct

class StartTrackingPage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const StartTrackingPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor = isDarkMode ? Colors.white70 : Colors.black54;
    final Color backgroundColor = isDarkMode ? const Color(0xFF121212) : Colors.white;
    final Color featureBoxColor = isDarkMode ? Colors.green[700]! : Colors.green.shade50;
    final Color buttonColor = Colors.green[800]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text("Start Tracking", style: TextStyle(color: textColor)),
        actions: [
          // Profile Icon Button
          IconButton(
            icon: Icon(Icons.person_outline, color: textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileOverviewPage()),
              );
            },
          ),
          // Light/Dark Toggle
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: textColor,
            ),
            onPressed: () => toggleTheme(!isDarkMode),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 60),
                const SizedBox(width: 15),
                Text(
                  "Grow Forest",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Tips & Challenges
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: featureBoxColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: buildFeatureBox(context, "Tips", Icons.lightbulb, '/tips', buttonColor),
                  ),
                  const SizedBox(width: 12), // spacing
                  Expanded(
                    child: buildFeatureBox(context, "Challenges", Icons.emoji_events, '/challenges', buttonColor),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // Slogan Quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text.rich(
                TextSpan(
                  text: 'Lead the Change\n',
                  style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Share & Inspire ',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontSize: 22,
                      ),
                    ),
                    TextSpan(
                      text: 'others to join',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            const ImpactStats(),

            // 🌿 EcoBot Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/chat'),
                icon: Icon(Icons.chat_bubble_outline),
                label: Text("Ask EcoBot 🌿"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Spacer(),

            buildBottomNavigationBar(context, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureBox(BuildContext context, String title, IconData icon, String route, Color bgColor) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        // Removed fixed width ✅
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: isDarkMode ? Colors.white : Colors.black87),
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
          Image.asset('assets/images/logo.png', height: 40, width: 40),
          IconButton(
            icon: Icon(Icons.dashboard, color: isDarkMode ? Colors.white : Colors.black87),
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
          ),
        ],
      ),
    );
  }
}

class ImpactStats extends StatelessWidget {
  const ImpactStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "🌱 2.4 tons of carbon saved",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "👥 1200+ eco warriors inspired",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
