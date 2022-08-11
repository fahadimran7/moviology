import 'dart:convert';

class OfflineMovie {
  final String id;
  final String title;
  final String year;
  final String imageUrl;
  final String rating;
  final List<dynamic> crewList;
  final String ratingCount;

  OfflineMovie(
      {required this.id,
      required this.title,
      required this.year,
      required this.imageUrl,
      required this.rating,
      required this.crewList,
      required this.ratingCount});

  factory OfflineMovie.fromJson(Map<String, dynamic> json) {
    return OfflineMovie(
        id: json['id'],
        title: json['title'],
        year: json['year'],
        imageUrl: json['image'],
        crewList: json['crew'],
        ratingCount: json['imDbRatingCount'] ?? "Not Provided",
        rating: json['imDbRating']);
  }

  static Map<String, dynamic> toMap(OfflineMovie movie) => {
        'id': movie.id,
        'year': movie.year,
        'crew': movie.crewList,
        'imDbRatingCount': movie.ratingCount,
        'imDbRating': movie.rating,
        'title': movie.title,
        'image': movie.imageUrl,
      };

  static String encode(List<OfflineMovie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => OfflineMovie.toMap(movie))
            .toList(),
      );

  static List<OfflineMovie> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<OfflineMovie>((item) => OfflineMovie.fromJson(item))
          .toList();
}
