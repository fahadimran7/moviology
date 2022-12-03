import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_search_app/models/featured_movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search_app/models/search_results.dart';

Future<List<FeaturedMovie>> getFeaturedMovies(context) async {
  List<FeaturedMovie> featuredMovies;

  final response = await http.get(Uri.parse(
      'https://imdb-api.com/en/API/MostPopularMovies/${dotenv.env['IMDB_API_KEY']}'));

  if (response.statusCode == 200) {
    final parsed =
        jsonDecode(response.body)["items"].cast<Map<String, dynamic>>();

    featuredMovies = parsed
        .map<FeaturedMovie>((json) => FeaturedMovie.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load movies');
  }

  return featuredMovies;
}

Future<List<SearchMovie>> getSearchResults(context, title) async {
  List<SearchMovie> searchMovies;

  final response = await http.get(Uri.parse(
      'https://imdb-api.com/API/AdvancedSearch/${dotenv.env['IMDB_API_KEY']}/?title=$title'));

  if (response.statusCode == 200) {
    final parsed =
        jsonDecode(response.body)["results"].cast<Map<String, dynamic>>();

    searchMovies =
        parsed.map<SearchMovie>((json) => SearchMovie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load movies');
  }

  return searchMovies;
}
