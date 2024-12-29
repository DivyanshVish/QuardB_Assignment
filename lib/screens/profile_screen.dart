import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                // Profile Icon
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[800],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 20),
                // Name and Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "John Cena", // Static Name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "johncena@yahoo.com", // Static Email
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Settings Icon
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    // Navigate to Settings or open settings dialog
                    print("Settings pressed");
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Additional Profile Details can be added here
            // For example: Account Settings, Logout Button, etc.
            const Text(
              "Additional Profile Information",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle logout or other actions here
                print("Log out pressed");
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Log Out", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
