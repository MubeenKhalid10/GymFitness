import 'package:flutter/material.dart';
import 'package:gymfitness/api_services/exercise_api_services.dart';
import 'exercise_detail_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final String muscle;
  const ExerciseListScreen({super.key, required this.muscle});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  late Future<List<dynamic>> exercises;
  final Set<String> _favorites = {};

  // Map exercise names to custom local images (use your own paths)
  final Map<String, String> imageMap = {
    'Hammer Curls': 'assets/hammercurls.jpg',
    'Barbell Curl': 'assets/barbellcurl.jpg',
    'Incline Hammer Curls': 'assets/inclinehammercurls.jpg',
    'Wide-grip barbell curl': 'assets/widegripbarbell.jpg',
    'EZ-bar spider curl': 'assets/ezbarspidercurl.jpg',
    'EZ-Bar Curl': 'assets/ezbarcurl.jpg',
    'Zottman Curl': 'assets/zottmancurl.jpg',
    'Biceps curl to shoulder press': 'assets/bicepcurltoshoulder.jpg',
    'Concentration curl': 'assets/concentrationcurl.jpg',
    'Flexor Incline Dumbbell Curls': 'assets/flexor.jpg',
    // Add more mappings as needed
  };

  @override
  void initState() {
    super.initState();
    exercises = ExerciseApiService.fetchExercises(widget.muscle);
  }

  void toggleFavorite(String name) {
    setState(() {
      if (_favorites.contains(name)) {
        _favorites.remove(name);
      } else {
        _favorites.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.muscle.toUpperCase()} Exercises'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: exercises,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final ex = snapshot.data![index];
              final name = ex['name'];
              final equipment = ex['equipment'];
              final instructions = ex['instructions'];
              final image =
                  imageMap[name] ?? 'assets/image9.png'; // fallback image

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExerciseDetailScreen(
                        name: name,
                        equipment: equipment,
                        instructions: instructions,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(image),
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
                              colors: [Colors.black54, Colors.transparent],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 40,
                          child: Text(name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 15,
                          child: Text('Equipment: $equipment',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white70)),
                        ),
                        // Heart Icon Favorite
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap: () => toggleFavorite(name),
                            child: Icon(
                              _favorites.contains(name)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.redAccent,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
