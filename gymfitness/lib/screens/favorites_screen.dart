import 'package:flutter/material.dart';
import 'exercise_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: Colors.redAccent,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites added yet."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final ex = favorites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExerciseDetailScreen(
                          name: ex['name'],
                          equipment: ex['equipment'],
                          instructions: ex['instructions'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                              ex['image'] ?? 'assets/default_bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black87, Colors.transparent],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 20,
                            child: Text(
                              ex['name'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 5,
                            child: Text(
                              "Equipment: ${ex['equipment']}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white70),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
