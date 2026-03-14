import 'package:flutter/material.dart';
import 'exercise_list_screen.dart';

class ExerciseScreen extends StatelessWidget {
  final List<Map<String, String>> muscles = [
    {'name': 'biceps', 'type': 'upper body', 'image': 'assets/biceps.jpg'},
    {'name': 'triceps', 'type': 'upper body', 'image': 'assets/triceps.jpg'},
    {'name': 'chest', 'type': 'upper body', 'image': 'assets/chest.jpg'},
    {'name': 'back', 'type': 'upper body', 'image': 'assets/back.jpg'},
    {'name': 'calves', 'type': 'lower body', 'image': 'assets/calves.jpg'},
    {
      'name': 'quadriceps',
      'type': 'lower body',
      'image': 'assets/quadriceps.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Muscle Groups'),
          backgroundColor: Colors.redAccent),
      body: ListView.builder(
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          final muscle = muscles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseListScreen(muscle: muscle['name']!),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(muscle['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(muscle['name']!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(muscle['type']!,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
