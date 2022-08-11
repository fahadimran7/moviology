import 'dart:convert';

class FeaturedMovie {
  final String id;
  final String title;
  final String year;
  final String imageUrl;
  final String rating;
  final List<String> crewList;
  final String ratingCount;

  FeaturedMovie(
      {required this.id,
      required this.title,
      required this.year,
      required this.imageUrl,
      required this.rating,
      required this.crewList,
      required this.ratingCount});

  factory FeaturedMovie.fromJson(Map<String, dynamic> json) {
    return FeaturedMovie(
        id: json['id'],
        title: json['title'],
        year: json['year'],
        imageUrl: json['image'],
        crewList: json['crew'] != null ? json["crew"].split(",") : [],
        ratingCount: json['imDbRatingCount'] ?? "Not Provided",
        rating: json['imDbRating']);
  }

  static Map<String, dynamic> toMap(FeaturedMovie movie) => {
        'id': movie.id,
        'year': movie.year,
        'crew': movie.crewList,
        'imDbRatingCount': movie.ratingCount,
        'imDbRating': movie.rating,
        'title': movie.title,
        'image': movie.imageUrl,
      };

  static String encode(List<FeaturedMovie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => FeaturedMovie.toMap(movie))
            .toList(),
      );

  static List<FeaturedMovie> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<FeaturedMovie>((item) => FeaturedMovie.fromJson(item))
          .toList();
}
