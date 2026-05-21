import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.1.100:3000/api';
  static const Duration _timeoutDuration = Duration(seconds: 10);

  Future<Map<String, dynamic>> fetchTriviaQuestions({
    int count = 15,
    String? categories,
    String? difficulties,
    String? types,
  }) async {
    try {
      final queryParams = <String, String>{'limit': count.toString()};

      if (categories != null) queryParams['categories'] = categories;
      if (difficulties != null) queryParams['difficulties'] = difficulties;
      if (types != null) queryParams['types'] = types;

      final response = await http
          .get(
            Uri.parse(
              '$_baseUrl/questions/random',
            ).replace(queryParameters: queryParams),
          )
          .timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      }
      throw Exception('Server error: ${response.statusCode}');
    } on TimeoutException {
      throw Exception('Connection timed out. Check your network.');
    } on SocketException {
      throw Exception('No internet connection.');
    } catch (e) {
      throw Exception('Failed to load trivia: $e');
    }
  }

  Future<String> fetchRandomImageUrl({String category = ''}) async {
    final categoryKeywords = {
      'geography': 'nature,mountain,landscape',
      'science & nature': 'science,nature,laboratory',
      'science: computers': 'technology,computer,keyboard',
      'science: gadgets': 'technology,gadget,device',
      'history': 'ancient,monument,castle,history',
      'animals': 'animals,wildlife,nature',
      'art': 'art,painting,sculpture',
      'sports': 'sports,stadium,athlete',
      'entertainment: music': 'music,concert,guitar',
      'entertainment: books': 'book,library,reading',
      'entertainment: film': 'cinema,movie,camera',
      'general knowledge': 'education,knowledge,quiz',
      'default': 'education,trivia,quiz',
    };

    String keywords = 'default';
    for (final entry in categoryKeywords.entries) {
      if (category.toLowerCase().contains(entry.key)) {
        keywords = entry.value;
        break;
      }
    }

    final random = Random();
    final seed =
        'trivia-${DateTime.now().millisecondsSinceEpoch}-${random.nextInt(99999)}';
    return 'https://loremflickr.com/400/300/$keywords?random=$seed';
  }

  Future<List<String>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/questions/categories'))
          .timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data);
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<String>> fetchTags() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/questions/tags'))
          .timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data);
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load tags: $e');
    }
  }
}
