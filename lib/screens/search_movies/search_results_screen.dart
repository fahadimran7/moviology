import 'package:flutter/material.dart';
import 'package:movie_search_app/screens/search_movies/widgets/search_result_card.dart';
import 'package:provider/provider.dart';

import '../../providers/movie_provider.dart';

class SearchResultsScreen extends StatefulWidget {
  final String title;

  const SearchResultsScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  Map? arg;

  @override
  void initState() {
    super.initState();
    final moviesProvider = Provider.of<MovieDataProvider>(
      context,
      listen: false,
    );
    moviesProvider.getSearchMovies(context, widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Search",
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 16),
            child: Text(
              'Search Results',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, bottom: 10),
            child: Text(
              "Here's what we found",
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),
          ),
          moviesProvider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Flexible(
                  child: ListView.builder(
                    itemCount: moviesProvider.searchMovies.length,
                    itemBuilder: (context, index) {
                      return SearchCard(
                        index: index,
                        searchMovies: moviesProvider.searchMovies,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
