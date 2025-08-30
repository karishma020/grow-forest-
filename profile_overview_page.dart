import 'package:flutter/material.dart';
import 'settings_page.dart';

class ProfileOverviewPage extends StatelessWidget {
  const ProfileOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Profile"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Achievements"),
              Tab(text: "Reports"),
              Tab(text: "Footprint"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AchievementsTab(),
            ReportsTab(),
            FootprintTab(),
          ],
        ),
      ),
    );
  }
}

class AchievementsTab extends StatelessWidget {
  const AchievementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // 2 cards per row
      padding: const EdgeInsets.all(12),
      childAspectRatio: 1.2, // Smaller box shape
      children: const [
        InfoCard(title: 'Total Cool Points', value: '7'),
        InfoCard(title: 'Completed Actions', value: '2'),
        InfoCard(title: 'Ongoing Streak', value: '0 days'),
        InfoCard(title: 'Saved Emissions', value: '1.9 kg CO₂eq'),
      ],
    );
  }
}

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        ListTile(title: Text('Travel'), subtitle: LinearProgressIndicator(value: 0.6)),
        ListTile(title: Text('Energy'), subtitle: LinearProgressIndicator(value: 0.3)),
        ListTile(title: Text('Food'), subtitle: LinearProgressIndicator(value: 0.5)),
        ListTile(title: Text('Waste'), subtitle: LinearProgressIndicator(value: 0.2)),
      ],
    );
  }
}

class FootprintTab extends StatelessWidget {
  const FootprintTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.eco, size: 80, color: Colors.green),
          SizedBox(height: 16),
          Text(
            "Your Carbon Footprint is not yet calculated!",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 80, // Controls the box height
      child: Card(
        margin: const EdgeInsets.all(6),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white70 : Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
