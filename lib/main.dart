// import 'package:flutter/material.dart';
// import 'package:quad_assignment/screens/home_screen.dart';
// import 'package:quad_assignment/screens/search_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Movie App',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         scaffoldBackgroundColor: Colors.black,
//       ),
//       home: MainScreen(), // Main entry point
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0; // Current selected index for bottom navigation

//   // Screens for the bottom navigation
//   final List<Widget> _screens = [
//     HomeScreen(),
//     SearchScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Update the selected index
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex], // Display the selected screen
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.black, // Netflix-like dark theme
//         selectedItemColor: Colors.redAccent,
//         unselectedItemColor: Colors.white,
//         currentIndex: _selectedIndex, // Highlight the selected item
//         onTap: _onItemTapped, // Handle navigation
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quad_assignment/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner

      theme: ThemeData(
        primarySwatch: Colors.red, // Set your app's primary theme color
        scaffoldBackgroundColor:
            Colors.black, // Background color for all screens
      ),
      home: SplashScreen(), // Start with the Splash Screen
    );
  }
}
