import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_search_app/models/offline_movie.dart';
import 'package:movie_search_app/screens/offline_movies/widgets/offline_movie_list.dart';
import 'package:path_provider/path_provider.dart';

class OfflineMoviesScreen extends StatefulWidget {
  const OfflineMoviesScreen({Key? key}) : super(key: key);

  @override
  State<OfflineMoviesScreen> createState() => _OfflineMoviesState();
}

class _OfflineMoviesState extends State<OfflineMoviesScreen> {
  bool loading = true;

  // late List<FeaturedMovie> localMovies;
  late List<OfflineMovie> data;

  @override
  void initState() {
    super.initState();
    writeContent();
    readContent().then((String value) {
      var movieData = OfflineMovie.decode(value);
      setState(() {
        data = movieData;
        loading = false;
      });
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/offline_movies.txt');
  }

  Future<File> writeContent() async {
    final file = await _localFile;
    List<OfflineMovie> movies = [
      OfflineMovie(
          id: "tt9419884",
          title: "Doctor Strange in the Multiverse of Madness",
          year: "2022",
          imageUrl:
              "https://m.media-amazon.com/images/M/MV5BNWM0ZGJlMzMtZmYwMi00NzI3LTgzMzMtNjMzNjliNDRmZmFlXkEyXkFqcGdeQXVyMTM1MTE1NDMx._V1_UX128_CR0,3,128,176_AL_.jpg",
          rating: "7.3",
          crewList: ["Sam Raimi (dir), Test User"],
          ratingCount: "182995"),
      OfflineMovie(
          id: "tt5315212",
          title: "Senior Year",
          year: "2022",
          imageUrl:
              "https://m.media-amazon.com/images/M/MV5BNDUyYTM0ODYtYzIyMy00OTM2LWFmOTAtMTFlODQwN2NlYjY1XkEyXkFqcGdeQXVyNTk5NTQzNDI@._V1_UY176_CR6,0,128,176_AL_.jpg",
          rating: "5.5",
          crewList: ["Alex Hardcastle (dir.), Test User"],
          ratingCount: "24004")
    ];

    final String encodedData = OfflineMovie.encode(movies);

    // Write the file
    return file.writeAsString(encodedData);
  }

  Future<String> readContent() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 16),
            child: Text(
              "Offline Movies",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, bottom: 20),
            child: Text(
              "Movies and TV Shows you can browse offline",
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),
          ),
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : OfflineMoviesList(movies: data)
        ],
      );
    }
  }
}
