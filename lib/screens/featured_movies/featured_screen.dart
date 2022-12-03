import 'package:flutter/material.dart';
import 'package:movie_search_app/screens/featured_movies/widgets/movies_list.dart';
import 'package:provider/provider.dart';

import '../../providers/movie_provider.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  bool online = false;
  late String data;

  @override
  void initState() {
    super.initState();
    final moviesProvider =
        Provider.of<MovieDataProvider>(context, listen: false);
    moviesProvider.getMovies(context);
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieDataProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, left: 16),
          child: Text(
            "Recommended For You",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, bottom: 20),
          child: Text(
            "Movies and TV Shows picked for you",
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),
        ),
        moviesProvider.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : MoviesList(movies: moviesProvider.featuredMovies)
      ],
    );
  }
}
