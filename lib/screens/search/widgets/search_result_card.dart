import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/models/search_movie_model.dart';
import 'package:movie_search_app/screens/featured/featured_movie_details.dart';
import 'package:movie_search_app/screens/search/search_movie_details.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required this.searchMovies,
    required this.index,
  }) : super(key: key);

  final List<SearchMovie> searchMovies;
  final int index;

  num calculateRating(rating) {
    if (rating == "") {
      return 0;
    }
    return (num.parse(rating) / 10 * 5).round();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchMovieDetailsScreen(
                      movie: searchMovies[index],
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: SizedBox(
          height: 200,
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: searchMovies[index].imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    fit: BoxFit.cover,
                    height: 220,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              searchMovies[index].title,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: searchMovies[index].genre == "Fiction"
                                  ? const Color.fromARGB(255, 200, 221, 255)
                                  : const Color.fromARGB(255, 246, 194, 255),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Text(
                            searchMovies[index].genre,
                            style: TextStyle(
                                color: searchMovies[index].genre == "Fiction"
                                    ? Colors.blue.shade600
                                    : Colors.purple.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            searchMovies[index].runtimeStr,
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            searchMovies[index].actor,
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 14),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < calculateRating(searchMovies[index].rating);
                              i++)
                            Icon(
                              Icons.star,
                              color: Colors.yellow.shade700,
                              size: 20,
                            ),
                          for (int i = 0;
                              i <
                                  5 -
                                      calculateRating(
                                          searchMovies[index].rating);
                              i++)
                            Icon(
                              Icons.star_border,
                              color: Colors.yellow.shade700,
                              size: 20,
                            )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
