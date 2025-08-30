import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            const SizedBox(height: 20),
            const Text("Eco Warrior", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Total Carbon Saved: 75 kg"),
            const Text("Challenges Completed: 6"),
            const Text("Current Streak: 4 Days"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Log out logic
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
