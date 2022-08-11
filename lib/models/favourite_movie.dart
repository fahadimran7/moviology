import 'dart:convert';

class FavouriteMovie {
  final String id;
  final String title;
  final String imageUrl;
  final String rating;
  final String? actor;

  FavouriteMovie(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.rating,
      required this.actor});

  factory FavouriteMovie.fromJson(Map<String, dynamic> json) {
    return FavouriteMovie(
        id: json['id'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        actor: json['actor']!,
        rating: json['rating']);
  }

  static Map<String, dynamic> toMap(FavouriteMovie movie) => {
        'id': movie.id,
        'rating': movie.rating,
        'title': movie.title,
        'imageUrl': movie.imageUrl,
        'actor': movie.actor!
      };

  static String encode(List<FavouriteMovie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => FavouriteMovie.toMap(movie))
            .toList(),
      );

  static List<FavouriteMovie> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<FavouriteMovie>((item) => FavouriteMovie.fromJson(item))
          .toList();
}
