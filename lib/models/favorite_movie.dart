import 'dart:convert';

class FavoriteMovie {
  final String id;
  final String title;
  final String imageUrl;
  final String rating;
  final String? actor;

  FavoriteMovie(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.rating,
      required this.actor});

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
        id: json['id'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        actor: json['actor']!,
        rating: json['rating']);
  }

  static Map<String, dynamic> toMap(FavoriteMovie movie) => {
        'id': movie.id,
        'rating': movie.rating,
        'title': movie.title,
        'imageUrl': movie.imageUrl,
        'actor': movie.actor!
      };

  static String encode(List<FavoriteMovie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => FavoriteMovie.toMap(movie))
            .toList(),
      );

  static List<FavoriteMovie> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<FavoriteMovie>((item) => FavoriteMovie.fromJson(item))
          .toList();
}
