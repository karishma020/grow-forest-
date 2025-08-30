import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  String selectedCategory = 'All Categories';
  String selectedImpact = 'All Impacts';

  final List<Map<String, String>> tips = [
    {
      "title": "Switch to LED Lighting",
      "description":
          "Replace traditional incandescent bulbs with LED lights to reduce energy consumption by up to 80%.",
      "category": "Home Energy",
      "impact": "Medium Impact",
    },
    {
      "title": "Install a Programmable Thermostat",
      "description":
          "Automatically adjust your home temperature to save up to 10% on heating and cooling costs.",
      "category": "Home Energy",
      "impact": "Medium Impact",
    },
    {
      "title": "Use Public Transportation",
      "description":
          "Taking public transit just once a week instead of driving can reduce your carbon footprint by approx. 20%.",
      "category": "Transportation",
      "impact": "High Impact",
    },
    {
      "title": "Try Carpooling",
      "description":
          "Share rides with coworkers or neighbors to reduce your transportation emissions by up to 50%.",
      "category": "Transportation",
      "impact": "High Impact",
    },
    {
      "title": "Use Reusable Shopping Bags",
      "description":
          "Switch to reusable bags to save resources and reduce plastic waste in landfills and oceans.",
      "category": "Shopping",
      "impact": "Low Impact",
    },
    {
      "title": "Unplug Electronic Devices",
      "description":
          "Unplug electronics when not in use to eliminate phantom energy usage, saving up to 10% on your bill.",
      "category": "Home Energy",
      "impact": "Low Impact",
    },
    {
      "title": "Take Shorter Showers",
      "description":
          "Reducing your shower time by just 2 minutes can save up to 10 gallons of water per shower.",
      "category": "Home Energy",
      "impact": "Low Impact",
    },
    {
      "title": "Reduce Meat Consumption",
      "description":
          "Two plant-based meals per week can reduce your dietary carbon footprint by up to 25%.",
      "category": "Food & Diet",
      "impact": "High Impact",
    },
  ];

  final List<String> categories = [
    'All Categories',
    'Home Energy',
    'Transportation',
    'Food & Diet',
    'Shopping'
  ];

  final List<String> impacts = [
    'All Impacts',
    'High Impact',
    'Medium Impact',
    'Low Impact'
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTips = tips.where((tip) {
      final matchCategory = selectedCategory == 'All Categories' ||
          tip['category'] == selectedCategory;
      final matchImpact =
          selectedImpact == 'All Impacts' || tip['impact'] == selectedImpact;
      return matchCategory && matchImpact;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('AI Recommendations'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Personalized eco-friendly tips to reduce your carbon footprint",
                style: TextStyle(fontSize: 14, color: Colors.grey[700])),
            SizedBox(height: 16),

            // Category Filter
            Text("Filter by Category", style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  selectedColor: Colors.green,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Impact Filter
            Text("Filter by Impact", style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: impacts.map((impact) {
                return ChoiceChip(
                  label: Text(impact),
                  selected: selectedImpact == impact,
                  selectedColor: Colors.green,
                  onSelected: (_) {
                    setState(() {
                      selectedImpact = impact;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Tips List
            Expanded(
              child: filteredTips.isEmpty
                  ? Center(child: Text("No tips match your filters."))
                  : ListView.builder(
                      itemCount: filteredTips.length,
                      itemBuilder: (context, index) {
                        final tip = filteredTips[index];
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tip['impact']!,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                                Text(tip['category']!,
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                            title: Text(tip['title']!,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(tip['description']!),
                            trailing: Text("Learn more >",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green)),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}