import 'dart:convert';
import 'package:http/http.dart' as http;

class ExerciseApiService {
  static const String _apiKey = 'ANN4e5n+H9pf/5W4c7ZdeQ==6O3OsSqSNb4uXrff';
  static const String _baseUrl = 'https://api.api-ninjas.com/v1/exercises';

  static Future<List<dynamic>> fetchExercises(String muscle) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?muscle=$muscle'),
      headers: {'X-Api-Key': _apiKey},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}
