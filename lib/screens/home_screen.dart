// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quad_assignment/screens/detail_screen.dart';
import 'package:quad_assignment/screens/profile_screen.dart';
import 'search_screen.dart'; // Import the Search Screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> movies = []; // List to hold fetched movies
  int _selectedIndex =
      0; // To track the selected index of the bottom navigation

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  // Fetch movies from API
  Future<void> fetchMovies() async {
    final url = "https://api.tvmaze.com/search/shows?q=all";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Filter out movies without valid images
      setState(() {
        movies = data
            .where((movie) =>
                movie['show']['image'] != null &&
                movie['show']['image']['medium'] != null)
            .toList();
      });
    } else {
      // Handle error
      setState(() {
        movies = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to load movies. Please try again."),
        ),
      );
    }
  }

  // Bottom navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens based on the selected index
    if (index == 0) {
      // Navigate to Home (current screen)
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen()), // Search Screen
      );
    }
    // Add more actions for additional items in the bottom navigation if needed
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < 600; // Mobile detection
    final bool isWeb =
        MediaQuery.of(context).size.width >= 600; // Web detection

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('NetMirror', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Navigate to the Search Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Now Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Trending Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            movies.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : CarouselSlider(
                    options: CarouselOptions(
                      height: isWeb ? 400 : 250, // Adjust the height for web
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio:
                          isWeb ? 16 / 9 : 4 / 3, // Adjust aspect ratio for web
                      enableInfiniteScroll: true,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                    items: movies.map((movie) {
                      final show = movie['show'];
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to Details Screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(show: show),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          show['image']?['medium']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    color: Colors.black.withOpacity(0.6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Text(
                                      show['name'] ?? "Unknown",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    color: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: const Text(
                                      "Recently added",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

            // Featured Movies Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Featured Movies",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            movies.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 2 : 4,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: movies.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final show = movies[index]['show'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(show: show),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey[900],
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    show['image']?['medium'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  show['name'] ?? "No Title",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

            // FAQ Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildFAQItem("What is NetMirror?",
                "NetMirror is a streaming service that offers a wide variety of TV shows, movies, anime, documentaries, and more on thousands of internet-connected devices."),
            _buildFAQItem("How much does NetMirror cost?",
                "Watch NetMirror on your smartphone, tablet, Smart TV, laptop, or streaming device, all for one fixed monthly fee. Plans range from \$8.99 to \$17.99 a month. No extra costs, no contracts."),
            _buildFAQItem("Where can I watch?",
                "Watch anywhere, anytime. Sign in with your NetMirror account to watch instantly on the web at netmirror.com from your personal computer or on any internet-connected device that offers the NetMirror app."),
            _buildFAQItem("How do I cancel?",
                "NetMirror is flexible. There are no contracts and no commitments. You can easily cancel your account online in two clicks. There are no cancellation fees – start or stop your account anytime."),
            _buildFAQItem("What can I watch on NetMirror?",
                "NetMirror has an extensive library of feature films, documentaries, TV shows, anime, award-winning originals, and more. Watch as much as you want, anytime you want."),
            _buildFAQItem("Is NetMirror good for kids?",
                "The NetMirror Kids experience is included in your membership to give parents control while kids enjoy family-friendly TV shows and movies in their own space."),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: "Profile",
          ),
          // Add more items for additional navigation options
        ],
      ),
    );
  }

  // Helper widget for FAQ items with a styled box
  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // Margin around each FAQ item
      padding: const EdgeInsets.all(8.0), // Padding inside the box
      decoration: BoxDecoration(
        color: Colors.black
            .withOpacity(0.7), // Dark background with some transparency
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        border: Border.all(
            color: Colors.white, width: 1.0), // White border around the box
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero, // Remove padding around the tile
        iconColor: Colors.white, // Set icon color to white
        collapsedIconColor: Colors.white, // Set collapsed icon color to white
        title: Text(
          question,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Add padding for child content
        children: [
          Text(
            answer,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
