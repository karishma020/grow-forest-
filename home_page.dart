import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> info = [
    {
      "title": "Log Your Activities",
      "description":
          "Record your daily activities such as transportation, energy usage, and consumption habits."
    },
    {
      "title": "Get Insights",
      "description":
          "Our AI prioritizes your data to provide personalized insights and visualizations of your carbon footprint."
    },
    {
      "title": "Take Action",
      "description":
          "Receive tailored recommendations and complete challenges to reduce your environmental impact."
    },
  ];

  final List<String> bulletPoints = [
    "Get personalized insights into your carbon footprint.",
    "Track your progress over time and set goals.",
    "Earn badges and complete challenges.",
    "Receive AI-generated recommendations."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How It Works"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section (From the image)
              Text(
                "Start Today",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                "Small changes, big impact",
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
              ),
              SizedBox(height: 10),
              Text(
                "Record your daily activities and see how they contribute to your carbon footprint. "
                "Our AI-powered analysis helps you understand your impact and find ways to reduce it.",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bulletPoints.map((point) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, size: 20, color: Colors.green),
                        SizedBox(width: 10),
                        Expanded(child: Text(point, style: TextStyle(fontSize: 14))),
                      ],
                    ),
                  );
                }).toList(),
              ),
              Divider(height: 40, thickness: 1),
              // Bottom Section (Your original cards)
              Text(
                "Track, analyze and reduce your carbon footprints\nwith our AI powered platforms.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Column(
                children: info.map((item) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.eco, color: Colors.green),
                      title: Text(
                        item["title"]!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(item["description"]!),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
