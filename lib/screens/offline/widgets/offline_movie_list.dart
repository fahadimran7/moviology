import 'package:flutter/material.dart';
import 'package:movie_search_app/models/offline_movies.dart';
import 'package:movie_search_app/screens/offline/widgets/offline_card.dart';

class OfflineMoviesList extends StatelessWidget {
  const OfflineMoviesList({Key? key, required this.movies}) : super(key: key);

  final List<OfflineMovie> movies;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 400),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return OfflineCard(index: index, movie: movies[index]);
          }),
    );
  }
}
