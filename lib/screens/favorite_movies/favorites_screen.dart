import 'package:flutter/material.dart';
import 'package:movie_search_app/models/favorite_movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/favourites_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavoriteMovie> savedMovies = [];

  void getMovies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    final String moviesData = prefs.getString('favourite_movies')!;

    final List<FavoriteMovie> movies = FavoriteMovie.decode(moviesData);

    setState(() {
      savedMovies = movies;
    });
  }

  void saveMovie(movies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = FavoriteMovie.encode(movies);

    await prefs.setString('favourite_movies', encodedData);
  }

  void removeFavourite(removeId) {
    savedMovies.removeWhere((movie) => movie.id == removeId);
    setState(() {
      savedMovies;
    });

    saveMovie(savedMovies);
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, left: 16),
          child: Text(
            "Favourites",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, bottom: 10),
          child: Text(
            "Movies and TV Shows you've liked",
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),
        ),
        savedMovies.isNotEmpty
            ? Flexible(
                child: ListView.builder(
                  itemCount: savedMovies.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                'DELETE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      key: Key("item $index"),
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.startToEnd) {
                          removeFavourite(savedMovies[index].id);
                        }
                      },
                      child: FavouritesCard(
                          favouriteMovies: savedMovies,
                          index: index,
                          removeFavourite: removeFavourite),
                    );
                  },
                ),
              )
            : Expanded(
                child: Center(
                  child: Text(
                    "You haven't liked any movies yet ;(",
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),
                ),
              )
      ],
    );
  }
}
