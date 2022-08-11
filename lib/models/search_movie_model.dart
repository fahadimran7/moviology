class SearchMovie {
  final String id;
  final String title;
  final String imageUrl;
  final String rating;
  final String plot;
  final String genre;
  final String runtimeStr;
  final String actor;
  final String? contentRating;
  final List<dynamic>? actorList;

  SearchMovie(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.rating,
      required this.plot,
      required this.runtimeStr,
      required this.actor,
      required this.actorList,
      required this.contentRating,
      required this.genre});

  factory SearchMovie.fromJson(Map<String, dynamic> json) {
    return SearchMovie(
        id: json['id'],
        title: json['title'],
        imageUrl: json['image'],
        rating: json['imDbRating'] ?? "0",
        genre: json['genres'] != null
            ? json['genres'].split(",")[0]
            : "Not provided",
        runtimeStr: json['runtimeStr'] ?? "0 min",
        actor: json["stars"] != null ? json["stars"].split(",")[0] : "",
        actorList: json['starList'],
        contentRating: json["contentRating"],
        plot: json['plot'] ?? "Not provided");
  }
}
