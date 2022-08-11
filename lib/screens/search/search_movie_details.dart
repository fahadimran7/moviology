import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/models/favourite_movie.dart';
import 'package:movie_search_app/models/search_movie_model.dart';
import 'package:movie_search_app/utils/play_sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchMovieDetailsScreen extends StatefulWidget {
  final SearchMovie movie;

  const SearchMovieDetailsScreen({Key? key, required this.movie})
      : super(key: key);

  @override
  State<SearchMovieDetailsScreen> createState() => _FeaturedMovieDetailsState();
}

class _FeaturedMovieDetailsState extends State<SearchMovieDetailsScreen> {
  late SharedPreferences prefs;
  List<FavouriteMovie> movies = [];
  bool isAlreadySaved = false;

  num calculateRating(rating) {
    if (rating == "") {
      return 0;
    }
    return (num.parse(rating) / 10 * 5).round();
  }

  @override
  void initState() {
    super.initState();
    getSaved();
  }

  void getSaved() async {
    prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    if (prefs.getString('favourite_movies') != null) {
      final String moviesData = prefs.getString('favourite_movies')!;
      movies = FavouriteMovie.decode(moviesData);

      for (var movie in movies) {
        if (movie.id == widget.movie.id) {
          setState(() {
            isAlreadySaved = true;
          });
        }
      }
    } else {
      movies = [];
    }
  }

  void saveMovie(movieData) async {
    movies.add(movieData);

    final String encodedData = FavouriteMovie.encode(movies);

    await prefs.setString('favourite_movies', encodedData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Movie added to favourites!")),
    );
  }

  void removeFavourite(removeId) async {
    movies.removeWhere((movie) => movie.id == removeId);

    final String encodedData = FavouriteMovie.encode(movies);
    await prefs.setString('favourite_movies', encodedData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Movie removed from favourites!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Movie Details",
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: widget.movie.imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 380,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.movie.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                            i < calculateRating(widget.movie.rating);
                            i++)
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                            size: 20,
                          ),
                        for (int i = 0;
                            i < 5 - calculateRating(widget.movie.rating);
                            i++)
                          Icon(
                            Icons.star_border,
                            color: Colors.yellow.shade700,
                            size: 20,
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 246, 194, 255),
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Text(
                          widget.movie.genre,
                          style: TextStyle(
                              color: Colors.purple.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
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
                              "New",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.movie,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Duration ${widget.movie.runtimeStr}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "IMDB Rating ${widget.movie.rating}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.tv,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Content Rating ${widget.movie.contentRating}",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Plot",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.movie.plot,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Actors",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (widget.movie.actorList != null)
                          for (var actor in widget.movie.actorList!)
                            Column(
                              children: [
                                Text(
                                  "${actor["name"]}",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 3,
                                )
                              ],
                            ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        enableFeedback: false),
                    onPressed: !isAlreadySaved
                        ? () {
                            final favMovie = FavouriteMovie(
                                id: widget.movie.id,
                                title: widget.movie.title,
                                imageUrl: widget.movie.imageUrl,
                                actor: widget.movie.actor,
                                rating: widget.movie.rating);

                            saveMovie(favMovie);
                            setState(() {
                              isAlreadySaved = true;
                            });

                            PlaySound.playSound();
                          }
                        : () {
                            removeFavourite(widget.movie.id);
                            setState(() {
                              isAlreadySaved = false;
                            });

                            PlaySound.playSound();
                          },
                    child: Text(
                      isAlreadySaved
                          ? 'Remove from Favourites'.toUpperCase()
                          : 'Add to Favourites'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
