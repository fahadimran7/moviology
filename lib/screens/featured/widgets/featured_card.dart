import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/models/featured_movie_model.dart';
import 'package:movie_search_app/screens/featured/featured_movie_details.dart';

class FeaturedCard extends StatelessWidget {
  final FeaturedMovie movie;
  final int index;
  const FeaturedCard({Key? key, required this.index, required this.movie})
      : super(key: key);

  num calculateRating(rating) {
    if (rating == "") {
      return 0;
    }
    return (num.parse(rating) / 10 * 5).round();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FeaturedMovieDetailsScreen(
                      movie: movie,
                    )))
      },
      child: Padding(
        padding:
            EdgeInsets.only(top: 10, left: index % 2 == 0 ? 16 : 0, right: 16),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 280,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: movie.imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < calculateRating(movie.rating); i++)
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 18,
                    ),
                  for (int i = 0; i < 5 - calculateRating(movie.rating); i++)
                    Icon(
                      Icons.star_border,
                      color: Colors.yellow.shade700,
                      size: 18,
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.rating == "" ? "0" : movie.rating,
                    style: TextStyle(color: Colors.grey.shade600),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                movie.year,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
