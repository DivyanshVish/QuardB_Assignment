import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quad_assignment/screens/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> allMovies = []; // To hold all fetched movies
  List<dynamic> searchResults = []; // To hold filtered search results
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllMovies(); // Initially fetch all movies when screen loads
  }

  // Function to fetch all movies
  Future<void> fetchAllMovies() async {
    final url = "https://api.tvmaze.com/search/shows?q=all";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        allMovies = data;
        searchResults = allMovies; // Initially show all movies
      });
    }
  }

  // Function to search movies based on the query
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = allMovies; // If no query, show all movies
      });
    } else {
      final filteredResults = allMovies.where((movie) {
        final show = movie['show'];
        return show['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        searchResults = filteredResults;
      });
    }
  }

  // Helper to remove HTML tags
  String removeHtmlTags(String htmlText) {
    final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(regex, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Search Movies", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                searchMovies(
                    query); // Trigger search whenever the query changes
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                hintText: "Search for movies...",
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Results
          Expanded(
            child: searchResults.isEmpty
                ? const Center(
                    child: Text(
                      "No movie available",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final show = searchResults[index]['show'];
                      final summary = show['summary'] ?? "No summary available";

                      return GestureDetector(
                        onTap: () {
                          // Navigate to Details Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(show: show),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey[900],
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Thumbnail
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  show['image']?['medium'] ??
                                      'https://via.placeholder.com/100',
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Movie Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      show['name'] ?? "No Title",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      removeHtmlTags(summary),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
