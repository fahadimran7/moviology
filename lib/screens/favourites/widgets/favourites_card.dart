import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/models/favourite_movie.dart';

class FavouritesCard extends StatefulWidget {
  const FavouritesCard({
    Key? key,
    required this.favouriteMovies,
    required this.index,
    required this.removeFavourite,
  }) : super(key: key);

  final List<FavouriteMovie> favouriteMovies;
  final int index;
  final Function removeFavourite;

  @override
  State<FavouritesCard> createState() => _FavouritesCardState();
}

class _FavouritesCardState extends State<FavouritesCard> {
  bool isPressed = true;

  num calculateRating(rating) {
    if (rating == "") {
      return 0;
    }
    return (num.parse(rating) / 10 * 5).round();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.favouriteMovies[widget.index].title;
    String? actor = widget.favouriteMovies[widget.index].actor;
    String rating = widget.favouriteMovies[widget.index].rating;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: SizedBox(
        height: 180,
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
                  imageUrl: widget.favouriteMovies[widget.index].imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
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
                        Expanded(
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: (isPressed)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              isPressed = !isPressed;
                            });

                            widget.removeFavourite(
                                widget.favouriteMovies[widget.index].id);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Movie removed from favourites!")),
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 18,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          actor == "" ? "Not Available" : actor!,
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "IMDB $rating",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 14),
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
                            i <
                                calculateRating(widget
                                    .favouriteMovies[widget.index].rating);
                            i++)
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                            size: 20,
                          ),
                        for (int i = 0;
                            i <
                                5 -
                                    calculateRating(widget
                                        .favouriteMovies[widget.index].rating);
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
    );
  }
}
