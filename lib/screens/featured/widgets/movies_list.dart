import 'package:flutter/material.dart';
import 'package:movie_search_app/models/featured_movie_model.dart';
import 'package:movie_search_app/screens/featured/widgets/featured_card.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key, required this.movies}) : super(key: key);

  final List<FeaturedMovie> movies;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 400),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return FeaturedCard(index: index, movie: movies[index]);
          }),
    );
  }
}
