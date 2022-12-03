import 'package:flutter/material.dart';

import '../models/featured_movie.dart';
import '../models/search_results.dart';
import 'movie_api.dart';

class MovieDataProvider with ChangeNotifier {
  bool loading = false;
  late List<FeaturedMovie> featuredMovies;
  late List<SearchMovie> searchMovies;

  void getMovies(context) async {
    loading = true;
    featuredMovies = await getFeaturedMovies(context);
    loading = false;

    notifyListeners();
  }

  void getSearchMovies(context, title) async {
    loading = true;
    searchMovies = await getSearchResults(context, title);
    loading = false;

    notifyListeners();
  }
}
