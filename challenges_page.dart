import 'package:flutter/material.dart';

class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> challenges = [
    {
      'title': 'Carbon Commuter',
      'description': 'Use public transportation or carpool for 5 days.',
      'status': 'Completed',
      'progress': 100
    },
    {
      'title': 'Energy Saver',
      'description': 'Reduce your electricity usage by 10% for a month.',
      'status': 'Active',
      'progress': 80
    },
    {
      'title': 'Zero Waste Hero',
      'description': 'Eliminate single-use plastics for 2 weeks.',
      'status': 'Completed',
      'progress': 100
    },
    {
      'title': 'Plant-Based Pioneer',
      'description': 'Eat plant-based meals for 10 days in a month.',
      'status': 'Active',
      'progress': 60
    },
    {
      'title': 'Local Shopper',
      'description': 'Buy only locally produced food for 2 weeks.',
      'status': 'Completed',
      'progress': 100
    },
    {
      'title': 'Water Guardian',
      'description': 'Reduce your water consumption by 15% for a month.',
      'status': 'Active',
      'progress': 75
    },
    {
      'title': 'Digital Minimalist',
      'description': 'Reduce screen time by 20% for 3 weeks.',
      'status': 'Active',
      'progress': 40
    },
    {
      'title': 'Eco Educator',
      'description': 'Share 5 social media posts about sustainability.',
      'status': 'Completed',
      'progress': 100
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredChallenges = selectedFilter == 'All'
        ? challenges
        : challenges.where((c) => c['status'] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Eco Challenges"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Complete challenges to earn badges and reduce your carbon footprint",
                style: TextStyle(fontSize: 14, color: Colors.grey[700])),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard("Completed Challenges", "4"),
                _buildStatCard("Active Challenges", "5"),
                _buildStatCard("Carbon Saved", "285 kg CO₂"),
              ],
            ),

            SizedBox(height: 24),
            _buildFilterChips(),

            SizedBox(height: 24),
            Text("Featured Challenge", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            _buildFeaturedChallenge(),

            SizedBox(height: 24),
            Text("Your Challenges", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            ...filteredChallenges.map(_buildChallengeCard).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 1,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Active', 'Completed'];
    return Wrap(
      spacing: 10,
      children: filters.map((f) {
        return ChoiceChip(
          label: Text(f),
          selected: selectedFilter == f,
          selectedColor: Colors.green,
          onSelected: (_) {
            setState(() {
              selectedFilter = f;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildFeaturedChallenge() {
    return Card(
      elevation: 2,
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("30-Day Meatless Challenge", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(
                "Reduce your carbon footprint by avoiding meat products for 30 days. Save up to 100kg of CO₂ emissions!"),
            SizedBox(height: 8),
            Text("Start Date: November 1, 2023"),
            Text("Participants: 1,243 people"),
            Row(
              children: List.generate(3, (index) => Icon(Icons.star, size: 16, color: Colors.green)),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: Text("Join Challenge"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    bool isCompleted = challenge['progress'] == 100;
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.emoji_events, color: Colors.green),
        title: Text(challenge['title']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(challenge['description']),
            if (isCompleted)
              Text("Earned", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
            else
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: LinearProgressIndicator(
                  value: challenge['progress'] / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
